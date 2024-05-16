import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:route_between_two_points/config/config.dart';
import 'package:route_between_two_points/config/data.dart';
import 'package:route_between_two_points/pages/Statistics/widgets/sampledata.dart';

import '../model/chart_model.dart';

class Keys extends GetxController {
  setKey(Map<String, dynamic> data) {
    config.bearer_token = "${config.type} ${data['token']}";
    config.refresh_token = data['refreshToken'];
    Map<String, dynamic> user = data['user'];
    int uid = user['userId'];
    Data.UserId = uid;
    Map<String, dynamic> role = user['role'];
    Data.role = role['roleName'];

    update();
  }

  void stationNameSet(
    List<String> names,
    List<dynamic> list,
  ) {
    Data.dashData = list;
    Data.stationNames = names;
    update();
  }

  Future<void> locationSet(List<LatLng> data) async {
    Data.routpoints = data;
  }

  void chartDataSet(List<ChartData> data) {
    chartDatafill.chartData = data;
  }
}
