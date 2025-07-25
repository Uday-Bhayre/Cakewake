import 'package:cakewake_vendor/features/orders/repository/orders_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home/view/home_view.dart';
import 'orders/view/orders_view.dart';
import 'earnings/view/earning_view.dart';
import 'profile/view/profile_view.dart';
import 'home/controller/home_controller.dart';
import 'orders/controller/orders_controller.dart';
import 'earnings/controller/earnings_controller.dart';
import 'profile/controller/profile_controller.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeView(),
    OrdersView(),
    EarningView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Ensure all controllers and repositories are registered for GetX
    Get.put<HomeController>(HomeController(), permanent: true);
    Get.put<OrdersRepository>(
      OrdersRepository(),
      permanent: true,
    ); // Register repository first
    Get.put<OrdersController>(
      OrdersController(Get.find<OrdersRepository>()),
      permanent: true,
    );
    Get.put<EarningsController>(EarningsController(), permanent: true);
    Get.put<ProfileController>(ProfileController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Order'),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee),
            label: 'Earning',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
