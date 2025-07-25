import 'package:cakewake_vendor/features/orders/repository/orders_repository.dart';
import 'package:get/get.dart';
import 'controller/orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(() => OrdersController(Get.find<OrdersRepository>()));
    Get.lazyPut(() => OrdersRepository());
  }
}
