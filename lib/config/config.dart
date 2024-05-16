// ignore_for_file: camel_case_types, constant_identifier_names, non_constant_identifier_names

class config {
  static const String apiKey = 'JyAaLfpOMxa6mi8NgmtqXrNfbIMXR2yRyVzxji7Oo54=';
  static const String baseUrl = 'http://apitems.homeunix.com:8090';
  static const String login = '/api/auth/login';
  static const String logout = '/api/logout';
  static const String allStations = '/api/stations/getAllStations';
  static const String sensorNameWithParameter = '/api/sensors/all';
  static const String SensorByStationId = '/api/sensors/by-station-ids';
  static const String ReportData = '/api/sensors/history/by-station-ids';
  static const String allRole = '/api/roles/all';
  static const String refresh = '/api/refresh_token';
  static const String userCreate = '/api/auth/add-user';
  static const String userlist = '/api/auth/all-users';
  static const String deltUser = '/api/auth/delete-user/';
  static const String type = 'Bearer';
  static String bearer_token = '';
  static String refresh_token = '';
}
