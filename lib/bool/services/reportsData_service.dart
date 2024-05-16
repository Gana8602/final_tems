// ignore_for_file: file_names

import 'dart:convert';

import 'Package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:route_between_two_points/bool/services/encrypt.dart';
import 'package:route_between_two_points/bool/services/refresh_service.dart';
import 'package:route_between_two_points/config/config.dart';
import 'package:route_between_two_points/config/data.dart';
import 'package:route_between_two_points/model/data_model/report_static_model.dart';

class ReportDataService extends GetxController {
  void dataEncrypt(int id, String d1, String d2) {
    String encId = encryptAES(id.toString(), Data.AesKey);
    encryptAES(d1, Data.AesKey);
    encryptAES(d2, Data.AesKey);

    Data.stationIds = encId;
    update();
    reportDatafetch();
  }

  Future<void> reportDatafetch() async {
    var response = await http.get(
        Uri.parse(
            '${config.baseUrl}${config.ReportData}?stationIds=${Data.stationIds}&fromDate=2024-03-03T12:12:50&toDate=2024-04-25T12:12:50'),
        headers: {
          "Authorization": config.bearer_token,
          "apiKey": config.apiKey,
          "Content-type": "application/json"
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      (data['stationDetails'] as List)
          .map((e) => ReportsData.fromJson(e))
          .toList();
    } else if (response.statusCode == 401) {
      RefreshToken().refreshToken();
    }
  }
}
