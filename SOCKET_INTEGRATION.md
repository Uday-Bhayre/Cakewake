# Socket Integration Documentation

## Overview
This implementation provides real-time order notifications for vendors using WebSocket connections with the backend.

## Features Implemented

### 1. Socket Service (`lib/core/services/socket_service.dart`)
- Connects to the backend using socket.io client
- Handles authentication with JWT token
- Joins work area rooms for receiving orders
- Emits vendor events (order acceptance, order ready)
- Listens for backend events (new orders, confirmations)

### 2. Home Controller Integration
- Socket service is initialized when controller starts
- Connection is established when vendor goes online
- Connection is closed when vendor goes offline
- Handles new order notifications with callbacks

### 3. Notification System
- Red dot indicator on notification icon when new orders arrive
- Scrollable bottom sheet showing list of new orders
- Automatic snackbar notifications for real-time feedback
- Clear all notifications functionality

### 4. UI Components
- `NotificationIcon`: App bar widget with red dot indicator
- Updated `HomeView`: Integrated notification icon in app bar
- Bottom sheet: Displays new orders in a scrollable list

## Backend Events Handled

### Incoming Events (from backend to vendor):
- `newOrder`: New order received from customer
- `vendor-order-accepted`: Confirmation of order acceptance
- `delivery-request`: Order ready for delivery pickup

### Outgoing Events (from vendor to backend):
- `join-work-area`: Join work area room on connection
- `order-accepted-by-vendor`: Notify backend of order acceptance
- `order-ready`: Notify delivery partners that order is ready

## Configuration Required

### 1. Update Vendor Details
In `home_controller.dart`, update these values with actual data:
```dart
final String vendorId = "vendor_123"; // Replace with actual vendor ID
final String workArea = "Area1"; // Replace with actual work area  
final String workCity = "Delhi"; // Replace with actual work city
```

### 2. JWT Token
Ensure JWT token is stored in GetStorage with key 'token'

### 3. Backend URL
Update the socket server URL in `socket_service.dart` if needed:
```dart
_socket = IO.io('https://socket-server-8wsr.onrender.com', ...);
```

## Usage

### 1. Online/Offline Toggle
When vendor clicks the availability switch:
- Online: Connects to socket and joins work area room
- Offline: Disconnects from socket

### 2. Receiving Orders
When a new order arrives:
- Red dot appears on notification icon with count
- Snackbar notification is shown
- Order is added to notifications list

### 3. Viewing Notifications
Click the notification icon to:
- View all new orders in a bottom sheet
- Clear all notifications
- Tap on individual orders (can be extended for actions)

### 4. Order Actions
Updated order action flow:
- New → Accept (emits order-accepted-by-vendor)
- Accepted → Preparing
- Preparing → Ready for Pickup (emits order-ready)
- Ready for Pickup → Completed
- Completed → Order Done

## Dependencies Added
- `socket_io_client: ^2.0.3+1`

## Next Steps

1. **Real Order Integration**: Replace mock orders with actual order data from socket events
2. **User ID Mapping**: Add proper user ID mapping for order acceptance
3. **Address Integration**: Add customer address handling for delivery
4. **Error Handling**: Add proper error handling for socket connection failures
5. **Reconnection Logic**: Implement automatic reconnection on network issues
6. **Background Notifications**: Consider adding background notification support
7. **Sound/Vibration**: Add audio/haptic feedback for new orders

## Testing

To test the implementation:
1. Ensure backend is running and accessible
2. Update vendor details in controller
3. Toggle online status to connect
4. Backend should emit 'newOrder' events to test notifications
5. Check socket connection in debug logs

## Troubleshooting

- Check JWT token validity
- Verify backend URL accessibility
- Check work area and city names match backend expectations
- Monitor debug logs for connection status
- Ensure proper room joining in backend
