import 'package:get/get.dart';

class MapStyle extends GetxController {
  String mapStyle =
      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}';
  String dark =
      'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.{ext}';
  String white =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png';
  String standard =
      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}';
  RxBool isLoading = false.obs;

  void changeStyle(String color) {
    isLoading.value = true;
    update();
    if (color == 'white') {
      mapStyle = white;

      // isLoading.value = false;
      update();
    } else if (color == 'dark') {
      mapStyle = dark;
      update();
      // isLoading.value = false;
    } else if (color == 'standard') {
      mapStyle = standard;
      // isLoading.value = false;
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      update();
      isLoading.value = false;
    });
  }
}
