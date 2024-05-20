import 'package:get/get.dart';
import 'package:Tems/router/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = HomePageRoute.obs;
  var hoverItem = ''.obs;
}
