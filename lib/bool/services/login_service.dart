import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:route_between_two_points/bool/services/getAllRole.dart';
import 'package:route_between_two_points/bool/services/sensor_details_service.dart';
import '../../config/config.dart';
import '../../controllers/key_controller.dart';
import '../../pages/home.dart';
import '../../pages/widget/toast.dart';
import 'station_service.dart';

class LoginService {
  Future<void> login(String user, String pass) async {
    Map<String, dynamic> credentials = {"username": user, "password": pass};
    String json = jsonEncode(credentials);
    try {
      var response =
          await http.post(Uri.parse("${config.baseUrl}${config.login}"),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: json);

      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Map<String, dynamic> user = data['user'];
        // int uid = user['userId'];

        Keys().setKey(data);
        StationService().GetStations();
        await SensorDetails().getSensorDetails();
        await GetRoles().getRoles();
        // ReportDataService().reportDatafetch();
        Get.to(() => const HomePage());
      } else if (response.statusCode == 401) {
        toaster().showsToast(data['message'], Colors.red, Colors.white);
      } else {
        toaster().showsToast("An error occurred", Colors.red, Colors.white);
      }
    } catch (e) {
      toaster().showsToast("An error occurred", Colors.red, Colors.white);
    }
  }
}
