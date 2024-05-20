// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class Data extends GetxController {
  static List<String> stationNames = [];
  static int UserId = 0;
  static List<String> stationNames2 = [];
  static String roleName = "";
  static String userName = "";
  static List<Map<String, dynamic>> stationNameswithId = [];
  static List<String> sensors = [];
  static List<dynamic> dashData = [];
  static List<String> parameter = [];
  static List<LatLng> routpoints = [];
  static List<dynamic> Roles = [];
  static String stationIds = '';
  static String date1 = '';
  static String date2 = '';
  static String role = '';
  static String AesKey = 'Tri12345Tems12345Tri12345Tid1234';
}
