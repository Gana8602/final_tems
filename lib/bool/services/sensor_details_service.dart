// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:route_between_two_points/bool/services/refresh_service.dart';
import 'package:route_between_two_points/config/config.dart';

import '../../model/data_model/sensor_by_station_Id.dart';

class SensorDetails {
  Future<void> getSensorDetails() async {
    var response = await http.get(
        Uri.parse('${config.baseUrl}${config.SensorByStationId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': config.bearer_token,
          'apiKey': config.apiKey
        });
    if (response.statusCode == 200) {
      List<dynamic> dataas = [];
      List<String> stationnames = [];
      Map<String, dynamic> data = jsonDecode(response.body);
      List<SensorByStationId> Sensors = (data['stationDetails'] as List)
          .map((e) => SensorByStationId.fromJson(e))
          .toList();

      for (var sensors in Sensors) {
        List<Sensorss> data = sensors.sensors;
        String names = sensors.StationName;
        stationnames.add(names);
        //station name set in keys class
        for (var sensor in data) {
          List<SensorParameters> parameter = sensor.sensorParameters;
          for (var param in parameter) {
            String name = param.ParamName;
            String data = param.Data;
            String type = param.Unit;
            dataas.add({
              'name': name,
              'value': data,
              'type': type,
              'icon': 'assets/svg/level.svg'
            });

            // Keys().stationNameSet(stationnames, dataas);
          }

          // ReportDataService().dataEncrypt(sensors.StationId);
        }
      }
    } else if (response.statusCode == 401) {
      RefreshToken().refreshToken();
      throw Exception('error');
    }
  }
}
