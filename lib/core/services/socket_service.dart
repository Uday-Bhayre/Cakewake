import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

class SocketService {
  IO.Socket? _socket;
  final String vendorId;
  final String workArea;
  final String workCity;
  final Function(Map<String, dynamic>) onNewOrder;
  final Function(Map<String, dynamic>)? onVendorOrderAccepted;
  final Function(Map<String, dynamic>)? onDeliveryRequest;
  final Function(Map<String, dynamic>)? onDeliveryAcceptedByPartner;

  SocketService({
    required this.vendorId,
    required this.workArea,
    required this.workCity,
    required this.onNewOrder,
    this.onVendorOrderAccepted,
    this.onDeliveryRequest,
    this.onDeliveryAcceptedByPartner,
  });


  void connect() {
    if (_socket != null && _socket!.connected) return;
    _socket = IO.io(
      'https://socket-server-8wsr.onrender.com',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'auth': {'token': box.read('token')},
      },
    );

    _socket!.connect();

    _socket!.onConnect((_) {
      if (kDebugMode) {
        print('Socket connected');
      }
      // Join work area room for receiving orders
      _socket!.emit('join-work-area', {
        'workArea': workArea,
        'workCity': workCity,
      });
    });

    // Listen for new orders (from backend)
    _socket!.on('vendor-search-request', (data) {
      if (kDebugMode) {
        print('New order received: $data');
      }
      print('New order received: $data');
      if (data is Map<String, dynamic>) {
        onNewOrder(data);
      } else if (data is Map) {
        onNewOrder(Map<String, dynamic>.from(data));
      }

    });

    // Listen for vendor order acceptance confirmations
    _socket!.on('vendor-order-accepted', (data) {
      if (kDebugMode) {
        print('Vendor order accepted: $data');
      }
      if (onVendorOrderAccepted != null) {
        if (data is Map<String, dynamic>) {
          onVendorOrderAccepted!(data);
        } else if (data is Map) {
          onVendorOrderAccepted!(Map<String, dynamic>.from(data));
        }
      }
    });

    // Listen for delivery requests (when order is ready)
    _socket!.on('delivery-request', (data) {
      if (kDebugMode) {
        print('Delivery request: $data');
      }
      if (onDeliveryRequest != null) {
        if (data is Map<String, dynamic>) {
          onDeliveryRequest!(data);
        } else if (data is Map) {
          onDeliveryRequest!(Map<String, dynamic>.from(data));
        }
      }
    });

    // Listen for delivery acceptance by partner
    _socket!.on('delivery-accepted-by-partner', (data) {
      if (kDebugMode) {
        print('Delivery accepted by partner: $data');
      }
      if (onDeliveryAcceptedByPartner != null) {
        print('Delivery accepted by partner: $data');
        if (data is Map<String, dynamic>) {
          onDeliveryAcceptedByPartner!(data);
        } else if (data is Map) {
          onDeliveryAcceptedByPartner!(Map<String, dynamic>.from(data));
        }
      }
    });

    _socket!.onDisconnect((_) {
      if (kDebugMode) {
        print('Socket disconnected');
      }
    });
  }

  // Emit order acceptance to backend
  void acceptOrder(String orderId, String userId) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit('order-accepted-by-vendor', {
        'orderId': orderId,
        'userId': userId,
      });
      if (kDebugMode) {
        print('Order accepted: $orderId for user: $userId');
      }
    }
  }

  // Emit order ready for delivery
  void orderReady(Map<String, dynamic> orderDetails) {
    if (_socket != null && _socket!.connected) {
      // _socket!.emit('order-ready', {
      //   // 'workArea': workArea,
      //   // 'workCity': workCity,
      //   'orderDetails': orderDetails,
      // });
      _socket!.emit('order-ready', orderDetails);
      if (kDebugMode) {
        print('Order ready for delivery: ${orderDetails['orderId']}');
      }
    }
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  bool get isConnected => _socket?.connected ?? false;
}
