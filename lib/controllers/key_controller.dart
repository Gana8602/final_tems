import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:Tems/config/config.dart';
import 'package:Tems/config/data.dart';
import 'package:Tems/pages/Statistics/widgets/sampledata.dart';

import '../model/chart_model.dart';

class Keys extends GetxController {
  Future<void> setKey(Map<String, dynamic> data) async {
    config.bearer_token = "${config.type} ${data['token']}";
    config.refresh_token = data['refreshToken'];
    Map<String, dynamic> user = data['user'];
    int uid = user['userId'];
    Data.UserId = uid;
    Data.userName = user['userName'];
    Map<String, dynamic> role = user['role'];
    Data.role = role['roleName'];
    String rolename = role['roleName'];
    if (rolename == 'ROLE_ADMIN') {
      Data.roleName = "administrator";
    } else if (rolename == 'ROLE_PMANAGER') {
      Data.roleName = "Project manager";
    } else if (rolename == 'ROLE_CMANAGER') {
      Data.roleName = "client manager";
    } else if (rolename == 'ROLE_ENGINEER') {
      Data.roleName = "engineer";
    } else if (rolename == 'ROLE_USER') {
      Data.roleName = "user";
    } else if (rolename == 'ROLE_QA/QCMANAGER') {
      Data.roleName = "QA/QC MANAGER";
    }

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
