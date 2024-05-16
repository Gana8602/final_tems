// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:route_between_two_points/bool/services/refresh_service.dart';
import 'package:route_between_two_points/config/config.dart';
import 'package:route_between_two_points/config/data.dart';

import '../../model/data_model/station_parameter_sensors.dart';

class SensorsNames {
  Future<void> SensorName() async {
    var response = await http.get(
        Uri.parse('${config.baseUrl}${config.sensorNameWithParameter}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": config.bearer_token,
          "apiKey": config.apiKey
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<SensorList> Sensors =
          (data['sensors'] as List).map((e) => SensorList.fromJson(e)).toList();
      Data.parameter.clear();
      for (var sensor in Sensors) {
        Data.sensors.add(sensor.sensorName);

        for (var parm in sensor.sensorParams) {
          Data.parameter.add(parm.parameterName);
        }
      }
    } else if (response.statusCode == 401) {
      RefreshToken().refreshToken();
    }
  }
}
