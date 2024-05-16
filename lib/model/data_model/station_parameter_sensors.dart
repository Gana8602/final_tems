class SensorList {
  final int sensorId;
  final String sensorName;
  final String sensorCode;
  final List<SensorParam> sensorParams;

  SensorList({
    required this.sensorId,
    required this.sensorName,
    required this.sensorCode,
    required this.sensorParams,
  });

  factory SensorList.fromJson(Map<String, dynamic> json) {
    return SensorList(
      sensorId: json['sensorId'],
      sensorName: json['sensorName'],
      sensorCode: json['sensorCode'],
      sensorParams: List<SensorParam>.from((json['sensorParams'] as List)
          .map((param) => SensorParam.fromJson(param))),
    );
  }
}

class SensorParam {
  final int sensorParamId;
  final bool dashFlag;
  final String parameterName;

  SensorParam({
    required this.sensorParamId,
    required this.dashFlag,
    required this.parameterName,
  });

  factory SensorParam.fromJson(Map<String, dynamic> json) {
    return SensorParam(
      sensorParamId: json['sensorParamId'],
      dashFlag: json['dashFlag'],
      parameterName: json['parameterName'],
    );
  }
}
