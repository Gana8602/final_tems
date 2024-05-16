import 'package:get/get.dart';
import 'package:route_between_two_points/router/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = HomePageRoute.obs;
  var hoverItem = ''.obs;
}
