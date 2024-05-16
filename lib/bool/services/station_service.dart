// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:route_between_two_points/config/config.dart';

import 'refresh_service.dart';

class StationService {
  Future<List<String>> GetStations() async {
    try {
      var response = await http.get(
        Uri.parse('${config.baseUrl}${config.allStations}'),
        headers: {
          "Content-Type": "application/json",
          "apiKey": config.apiKey,
          "Authorization": config.bearer_token,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> stations = jsonDecode(response.body)['stations'];
        List<String> stationNames = [];
        List<Map<String, dynamic>> stationList = [];

        for (var station in stations) {
          String stationName = station['stationName'];
          stationNames.add(stationName);
          int ids = station['stationId'];
          Map<String, dynamic> stationInfo = {
            'name': stationName,
            'id': ids,
          };

          // Add the map to the stationList
          stationList.add(stationInfo);
        }

        return stationNames;
      } else {
        RefreshToken().refreshToken();
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
