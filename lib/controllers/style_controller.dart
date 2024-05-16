// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:route_between_two_points/utils/style.dart';

class StyleController extends GetxController {
  void ChangeColor(String val) {
    if (val == 'red') {
      AppColor.Blue = AppColor.red;
      update();
    }
    if (val == 'green') {
      AppColor.Blue = AppColor.green;
      update();
    }
    if (val == 'yellow') {
      AppColor.Blue = AppColor.yello;
      update();
    }
    if (val == 'blue') {
      AppColor.Blue = AppColor.primary;
      update();
    }
    update();
  }
}
