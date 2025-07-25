# 🍰 CakeWake Vendor App

A Flutter-based mobile application for cake vendors to manage orders, receive real-time notifications and tracking, and handle their business operations efficiently.

## 📱 Overview

CakeWake Vendor is part of the CakeWake ecosystem, designed specifically for cake vendors to:
- Receive real-time order notifications
- Real time tracking
- Manage order status and workflow
- Handle vendor availability (online/offline)
- Track daily earnings and order statistics
- Communicate with delivery partners

## ✨ Features

### 🔔 Real-time Notifications
- **Socket.io Integration**: Persistent WebSocket connection for instant notifications
- **Order Alerts**: Immediate notifications when new orders arrive
- **Status Updates**: Real-time updates on order progress and delivery assignments
- **Visual Indicators**: Red dot notifications with order count

### 📊 Order Management
- **Order Workflow**: Complete order lifecycle from acceptance to completion
- **Status Tracking**: New → Accepted → Preparing → Ready for Pickup → Out for Delivery → Completed
- **Order Details**: Customer information, product details, pricing, and delivery information
- **Daily Statistics**: Track today's orders, earnings, and performance metrics

### 🔄 Availability Control
- **Online/Offline Toggle**: Control vendor availability with a simple switch
- **Smart Connection**: WebSocket connection only active when vendor is online
- **Work Area Management**: Join specific work area rooms for targeted order distribution

### 🚚 Delivery Integration
- **Delivery Partner Communication**: Notify delivery partners when orders are ready
- **Assignment Tracking**: Receive confirmations when delivery partners accept orders
- **Status Synchronization**: Automatic status updates throughout the delivery process

## 🛠️ Technical Stack

### Frontend
- **Framework**: Flutter 3.8+
- **State Management**: GetX
- **UI**: Material Design with custom theming
- **Responsive Design**: Flutter ScreenUtil for adaptive layouts

### Backend Integration
- **Real-time Communication**: Socket.io Client
- **HTTP Requests**: Dio for API calls
- **Authentication**: JWT Token-based auth
- **Local Storage**: GetStorage for local data persistence

### Key Dependencies
```yaml
dependencies:
  flutter: sdk: flutter
  get: ^4.7.2                    # State management
  socket_io_client: ^2.0.3+1     # WebSocket communication
  dio: ^5.8.0+1                  # HTTP client
  get_storage: ^2.1.1            # Local storage
  flutter_screenutil: ^5.9.3     # Responsive design
  geolocator: ^14.0.1            # Location services
  image_picker: ^1.1.2           # Image handling
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8 or higher)
- Dart SDK
- Android Studio / VS Code
- Android emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Uday-Bhayre/Cakewake.git
   cd cakewake_vendor
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure environment**
   - Create `.env` file in the root directory
   - Add your API endpoints and configuration
   ```env
   SOCKET_URL=https://your-socket-server.com
   API_BASE_URL=https://your-api-server.com
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

## ⚙️ Configuration

### Socket Configuration
Update the socket service configuration in `lib/core/services/socket_service.dart`:
```dart
// Update with your socket server URL
_socket = IO.io('https://your-socket-server.com', {
  'transports': ['websocket'],
  'autoConnect': false,
  'auth': {'token': yourJWTToken},
});
```

### Vendor Configuration
Update vendor details in `lib/features/home/controller/home_controller.dart`:
```dart
final String vendorId = "your_vendor_id";
final String workArea = "your_work_area";
final String workCity = "your_city";
```

## 📡 Socket Events

### Incoming Events (Server → App)
- `newOrder`: New order received from customer
- `vendor-order-accepted`: Confirmation of order acceptance
- `delivery-request`: Order ready for delivery
- `delivery-accepted-by-partner`: Delivery partner assigned

### Outgoing Events (App → Server)
- `join-work-area`: Join work area room on connection
- `order-accepted-by-vendor`: Accept a customer order
- `order-ready`: Notify when order is ready for pickup

## 🏗️ Project Structure

```
lib/
├── main.dart                    # App entry point
├── app.dart                     # App configuration
├── core/                        # Core utilities and services
│   ├── services/
│   │   └── socket_service.dart  # WebSocket management
│   ├── widgets/                 # Reusable UI components
│   │   ├── notification_icon.dart
│   │   ├── availability_switch.dart
│   │   └── custom_button.dart
│   └── theme/                   # App theming
├── features/                    # Feature modules
│   ├── home/                    # Home/Dashboard feature
│   │   ├── controller/
│   │   ├── view/
│   │   ├── model/
│   │   └── widgets/
│   ├── profile_setup/           # Vendor profile setup
│   └── splash_screen/           # App initialization
└── assets/                      # Static assets
    ├── images/
    └── fonts/
```

## 🎨 UI Components

### Custom Widgets
- **NotificationIcon**: App bar notification with badge
- **AvailabilitySwitch**: Online/offline toggle
- **OrderCard**: Order display component
- **StatCard**: Statistics display widget

### Theming
- Material Design 3 principles
- Custom color schemes
- Responsive typography
- Platform-adaptive design

## 🔧 Development

### Code Style
- Follow Dart/Flutter style guide
- Use meaningful variable names
- Comment complex business logic
- Implement proper error handling

### State Management
The app uses GetX for state management:
- **Controllers**: Business logic and state
- **Observables**: Reactive UI updates
- **Bindings**: Dependency injection


```

## 📦 Build 

### Android Build
```bash
# Debug build
flutter build apk --debug




## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.







