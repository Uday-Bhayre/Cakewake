import 'package:cakewake_vendor/features/home/model/order_model.dart';
import 'package:cakewake_vendor/core/services/socket_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  var isOnline = true.obs;
  var todayOrder = 0.obs;
  var todayEarning = 0.0.obs;

  var todayOrderChange = 0.0.obs;
  var todayEarningChange = 0.0.obs;
  var hasOrder = false.obs;
  var orders = <OrderModel>[].obs;
  var currentOrder = Rx<OrderModel?>(null);

  // Socket and notification related
  SocketService? _socketService;
  var newOrders = <Map<String, dynamic>>[].obs;
  var hasNewNotifications = false.obs;

  // These should come from user profile/settings
  final String vendorId = "vendor_123"; // Replace with actual vendor ID
  final String workCity = "Mumbai"; // Replace with actual work city
  final String workArea = "Bandra"; // Replace with actual work area

  @override
  void onInit() {
    super.onInit();
    setNoOrder();
    _initializeSocketService();
  }

  void _initializeSocketService() {
    _socketService = SocketService(
      vendorId: vendorId,
      workArea: workArea,
      workCity: workCity,
      onNewOrder: _handleNewOrder,
      onVendorOrderAccepted: handleOrderAccepted,
      onDeliveryRequest: handleDeliveryRequest,
      onDeliveryAcceptedByPartner: _handleDeliveryAcceptedByPartner,
    );
  }

  void _handleNewOrder(Map<String, dynamic> orderData) {
    // Add to new orders list for notifications
    newOrders.add(orderData);
    hasNewNotifications.value = true;

    // Show snackbar notification
    Get.snackbar(
      'New Order!',
      'You have received a new order',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void handleOrderAccepted(Map<String, dynamic> data) {
    // Handle order acceptance confirmation
    // SocketService.acceptOrder(
    //   data['orderId'],
    //   vendorId,
    // );
    _socketService?.acceptOrder(
      data['orderId'],
      data['userId'], // Assuming userId is part of the data
    );
    Get.snackbar(
      'Order Accepted',
      'Order ${data['orderId']} has been accepted',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  void handleDeliveryRequest(Map<String, dynamic> data) {

    // Handle delivery request

    _socketService?.orderReady(data);
    Get.snackbar(
      'Delivery Request',
      'Order ${data['orderId']} is ready for delivery',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  void _handleDeliveryAcceptedByPartner(Map<String, dynamic> data) {
    // Handle delivery partner acceptance
    final orderId = data['orderId'];
    final deliveryPartnerId = data['deliveryPartnerId'];

    Get.snackbar(
      'Delivery Partner Assigned!',
      'Order $orderId has been accepted by delivery partner $deliveryPartnerId',
      backgroundColor: Colors.purple,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );

    // Update order status if it matches current order
    if (currentOrder.value?.id == orderId) {
      // You can update the order status or add delivery partner info
      // For example, update to "Out for Delivery" status
      setOrder(status: 'Out for Delivery');
    }
  }

  void toggleOnline(bool value) {
    isOnline.value = value;

    if (value) {
      // Connect to socket when going online
      _socketService?.connect();
    } else {
      // Disconnect from socket when going offline
      _socketService?.disconnect();
    }
  }

  void setNoOrder() {
    hasOrder.value = true;
    todayOrder.value = 5;
    todayEarning.value = 900.0;
    todayOrderChange.value = 0.0;
    todayEarningChange.value = 0.0;
    orders.value = [
      OrderModel(
        id: '1001',
        date: '2 Nov 2024 04:24 PM',
        pincode: '110034',
        productName: 'Velvet Gold Crunch',
        customerName: 'Ankit Gupta',
        status: 'Preparing',
        amount: 1467.55,
        quantity: 1,
        weight: '500',
        productImageUrl:
            'https://images.pexels.com/photos/14105/pexels-photo-14105.jpeg?auto=compress&w=400&q=80',
      ),
      OrderModel(
        id: '1002',
        date: '3 Nov 2024 10:00 AM',
        pincode: '110035',
        productName: 'Chocolate Truffle',
        customerName: 'Priya Sharma',
        status: 'New',
        amount: 899.00,
        quantity: 2,
        weight: '1000',
        productImageUrl:
            'https://images.pexels.com/photos/533325/pexels-photo-533325.jpeg?auto=compress&w=400&q=80',
      ),
      OrderModel(
        id: '1003',
        date: '4 Nov 2024 12:30 PM',
        pincode: '110036',
        productName: 'Red Velvet',
        customerName: 'Rahul Verma',
        status: 'Accepted',
        amount: 1200.00,
        quantity: 1,
        weight: '750',
        productImageUrl:
            'https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg?auto=compress&w=400&q=80',
      ),
      OrderModel(
        id: '1004',
        date: '5 Nov 2024 03:00 PM',
        pincode: '110037',
        productName: 'Black Forest',
        customerName: 'Simran Kaur',
        status: 'Ready for Pickup',
        amount: 1050.00,
        quantity: 1,
        weight: '500',
        productImageUrl:
            'https://images.pexels.com/photos/1026126/pexels-photo-1026126.jpeg?auto=compress&w=400&q=80',
      ),
      OrderModel(
        id: '1005',
        date: '6 Nov 2024 06:00 PM',
        pincode: '110038',
        productName: 'Pineapple Cake',
        customerName: 'Rohit Singh',
        status: 'Completed',
        amount: 750.00,
        quantity: 1,
        weight: '500',
        productImageUrl:
            'https://images.pexels.com/photos/14105/pexels-photo-14105.jpeg?auto=compress&w=400&q=80',
      ),
      OrderModel(
        id: '1006',
        date: '7 Nov 2024 09:00 AM',
        pincode: '110039',
        productName: 'Butterscotch',
        customerName: 'Sneha Mehra',
        status: 'Preparing',
        amount: 950.00,
        quantity: 1,
        weight: '500',
        productImageUrl:
            'https://images.pexels.com/photos/357576/pexels-photo-357576.jpeg?auto=compress&w=400&q=80',
      ),
      OrderModel(
        id: '1007',
        date: '8 Nov 2024 11:00 AM',
        pincode: '110040',
        productName: 'Fruit Cake',
        customerName: 'Amit Kumar',
        status: 'New',
        amount: 1100.00,
        quantity: 1,
        weight: '1000',
        productImageUrl:
            'https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg?auto=compress&w=400&q=80',
      ),
      OrderModel(
        id: '1008',
        date: '9 Nov 2024 02:00 PM',
        pincode: '110041',
        productName: 'Coffee Cake',
        customerName: 'Neha Jain',
        status: 'Accepted',
        amount: 1300.00,
        quantity: 1,
        weight: '750',
        productImageUrl:
            'https://images.pexels.com/photos/1026126/pexels-photo-1026126.jpeg?auto=compress&w=400&q=80',
      ),
      OrderModel(
        id: '1009',
        date: '10 Nov 2024 05:00 PM',
        pincode: '110042',
        productName: 'Mango Cake',
        customerName: 'Vikas Yadav',
        status: 'Ready for Pickup',
        amount: 1250.00,
        quantity: 1,
        weight: '500',
        productImageUrl:
            'https://images.pexels.com/photos/14105/pexels-photo-14105.jpeg?auto=compress&w=400&q=80',
      ),
      OrderModel(
        id: '1010',
        date: '11 Nov 2024 08:00 PM',
        pincode: '110043',
        productName: 'Strawberry Cake',
        customerName: 'Divya Kapoor',
        status: 'Completed',
        amount: 1400.00,
        quantity: 1,
        weight: '500',
        productImageUrl:
            'https://images.pexels.com/photos/533325/pexels-photo-533325.jpeg?auto=compress&w=400&q=80',
      ),
    ];
    if (orders.isNotEmpty) {
      currentOrder.value = orders.first;
    }
  }

  void setOrder({
    required String status,
    int orderCount = 1,
    double earning = 230.55,
    double orderChange = 1.3,
    double earningChange = 1.3,
  }) {
    hasOrder.value = true;
    todayOrder.value = orderCount;
    todayEarning.value = earning;
    todayOrderChange.value = orderChange;
    todayEarningChange.value = earningChange;
    // For demo, update the status of the first order
    if (orders.isNotEmpty) {
      orders[0] = orders[0].copyWith(status: status, amount: earning);
      currentOrder.value = orders[0];
    }
  }

  void onOrderAction() {
    // Cycle through order statuses for demo
    final status = currentOrder.value?.status;
    if (status == 'New') {
      // Accept the order
      _socketService?.acceptOrder(
        currentOrder.value!.id,
        'user_123', // Replace with actual user ID from order
      );
      setOrder(status: 'Accepted');
    } else if (status == 'Accepted') {
      setOrder(status: 'Preparing');
    } else if (status == 'Preparing') {
      // setOrder(status: 'Ready for Pickup');
      // // Notify delivery partners that order is ready
      // _socketService?.orderReady(currentOrder.value!.id, {
      //   'productName': currentOrder.value!.productName,
      //   'customerName': currentOrder.value!.customerName,
      //   'amount': currentOrder.value!.amount,
      //   'address': 'Customer Address', // Add actual address
      // });
    } else if (status == 'Ready for Pickup') {
      setOrder(status: 'Completed');
    } else if (status == 'Completed') {
      setOrder(status: 'Order Done');
    } else {
      setNoOrder();
    }
  }

  // Notification related methods
  void clearNotifications() {
    newOrders.clear();
    hasNewNotifications.value = false;
  }

  void showNotificationBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.6,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'New Orders',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: clearNotifications,
                  icon: const Icon(Icons.clear_all),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: newOrders.isEmpty
                  ? const Center(child: Text('No new orders'))
                  : ListView.builder(
                      itemCount: newOrders.length,
                      itemBuilder: (context, index) {
                        final order = newOrders[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(child: Text('${index + 1}')),
                            title: Text(
                              order['productName'] ?? 'Unknown Product',
                            ),
                            subtitle: Text(
                              order['customerName'] ?? 'Unknown Customer',
                            ),
                            trailing: Text('₹${order['amount'] ?? '0'}'),
                            onTap: () {
                              // Handle order selection
                              Get.back();
                              // You can navigate to order details or handle acceptance
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  void onClose() {
    _socketService?.disconnect();
    super.onClose();
  }

  String getOrderButtonText(String status) {
    switch (status) {
      case 'Accepted':
        return 'Accepted';
      case 'Preparing':
        return 'Preparing';
      case 'Ready for Pickup':
        return 'Ready for Pickup';
      case 'Out for Delivery':
        return 'Out for Delivery';
      case 'Completed':
        return 'Completed';
      case 'Order Done':
        return 'Completed';
      default:
        return 'Accept';
    }
  }

  Color getOrderButtonColor(String status, BuildContext context) {
    switch (status) {
      case 'Preparing':
        return const Color.fromARGB(255, 226, 204, 1);
      case 'Ready for Pickup':
        return Colors.blueAccent;
      case 'Out for Delivery':
        return Colors.purple;
      case 'Completed':
        return Colors.green;
      case 'Order Done':
        return Colors.black87;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Color getOrderButtonTextColor(String status, BuildContext context) {
    switch (status) {
      case 'Out for Delivery':
      case 'Completed':
      case 'Order Done':
        return Colors.white;
      default:
        return Colors.white;
    }
  }
}
