// ignore_for_file: non_constant_identifier_names, file_names

class SensorByStationId {
  final int StationId;
  final String StationName;
  final String StationCode;
  final double Latitude;
  final double Longitude;
  final String? StationImg;
  final String LocationDetails;
  final List<Sensorss> sensors;

  SensorByStationId(
      {required this.StationId,
      required this.StationName,
      required this.StationCode,
      required this.Latitude,
      required this.Longitude,
      required this.StationImg,
      required this.LocationDetails,
      required this.sensors});

  factory SensorByStationId.fromJson(Map<String, dynamic> json) {
    return SensorByStationId(
      StationId: json['stationId'],
      StationName: json['stationName'],
      StationCode: json['stationCode'],
      Latitude: json['latitude'],
      Longitude: json['longitude'],
      StationImg: json['stationImg'],
      LocationDetails: json['locationDetails'],
      sensors: List<Sensorss>.from(
          json['sensors'].map((sensor) => Sensorss.fromJson(sensor))),
    );
  }
}

class Sensorss {
  final int SensorId;
  final String SensorName;
  final String SensorCode;
  final List<SensorParameters> sensorParameters;

  Sensorss(
      {required this.SensorId,
      required this.SensorName,
      required this.SensorCode,
      required this.sensorParameters});
  factory Sensorss.fromJson(Map<String, dynamic> json) {
    return Sensorss(
      SensorId: json['sensorId'],
      SensorName: json['sensorName'],
      SensorCode: json['sensorCode'],
      sensorParameters: List<SensorParameters>.from(json['sensorParams']
          .map((params) => SensorParameters.fromJson(params))),
    );
  }
}

class SensorParameters {
  final int ParamId;
  final String ParamName;
  final String Unit;
  final double Warn;
  final double Danger;
  final double Min;
  final double Max;
  final String Data;
  final String Date;
  final String Time;

  SensorParameters(
      {required this.ParamId,
      required this.ParamName,
      required this.Unit,
      required this.Warn,
      required this.Danger,
      required this.Min,
      required this.Max,
      required this.Data,
      required this.Date,
      required this.Time});

  factory SensorParameters.fromJson(Map<String, dynamic> json) {
    return SensorParameters(
        ParamId: json['paramId'],
        ParamName: json['paramName'],
        Unit: json['unit'],
        Warn: json['warn'],
        Danger: json['danger'],
        Min: json['min'],
        Max: json['max'],
        Data: json['data'],
        Date: json['date'],
        Time: json['time']);
  }
}
