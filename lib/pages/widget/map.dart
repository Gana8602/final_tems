// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:Tems/config/config.dart';
import 'package:Tems/config/data.dart';
import 'package:Tems/model/data_model/sensor_by_station_Id.dart';
import 'package:Tems/pages/Statistics/widgets/linechart.dart';
import 'package:Tems/pages/widget/style.dart';
import '../../services/encrypt.dart';
import '../../services/refresh_service.dart';
import '../../controllers/key_controller.dart';
import '../../model/chart_model.dart';
import '../../model/data_model/report_static_model.dart';
import '../../utils/style.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List<LatLng> routpointss = [];
  List<String> stationNames = [];
  final List<ChartData> chartData = [];
  List<String> updateddate = [];
  bool isLoading = false;
  bool isOpen = false;
  String _displayedDate = "";
  String paraName = '';
  String dataa = '';
  String unit = '';
  String dateRage = "";

  @override
  void initState() {
    super.initState();

    getSensorDetails();
  }

  void _setDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter =
        DateFormat('yyyy-MM-ddTHH:mm:ss'); // Define the format
    final DateFormat formatterr = DateFormat('yyyy-MM-dd');

    if (now.day > 6) {
      _displayedDate = formatter.format(now.subtract(const Duration(days: 6)));
      dateRage =
          "${formatterr.format(now.subtract(const Duration(days: 6)))} to ${formatterr.format(now)}";
      dataEncrypt(1, _displayedDate, formatter.format(now));
      setState(() {});
    } else {
      _displayedDate = formatter.format(now);
    }
  }

  Future<void> getSensorDetails() async {
    isLoading = true;
    var response = await http.get(
        Uri.parse('${config.baseUrl}${config.SensorByStationId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': config.bearer_token,
          'apiKey': config.apiKey
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<SensorByStationId> Sensors = (data['stationDetails'] as List)
          .map((e) => SensorByStationId.fromJson(e))
          .toList();

      for (var sensors in Sensors) {
        String names = sensors.StationName;
        stationNames.add(names);
        setState(() {
          Data.stationNames = stationNames;
        });

        double lat = sensors.Latitude;
        double long = sensors.Longitude;

        routpointss.add(LatLng(lat.toDouble(), long.toDouble()));
        List<Sensorss> senss = sensors.sensors;

        setState(() {
          Data.routpoints = routpointss;
        });

        // ReportDataService().dataEncrypt(sensors.StationId);
        for (var sens in senss) {
          List<SensorParameters> senpar = sens.sensorParameters;
          for (var dates in senpar) {
            String timest = dates.Time;
            List<String> timeMid = timest.split(":");
            String time = timeMid.sublist(0, 2).join(':');
            String dateTime = '${dates.Date}  $time';
            updateddate.add(dateTime);
          }
        }
        setState(() {
          isLoading = false;
        });
        _setDate();
      }
    } else {
      throw Exception('error');
    }
  }

  void dataEncrypt(int id, String d1, String d2) {
    String encId = encryptAES(id.toString(), Data.AesKey);
    String da1 = encryptAES(d1, Data.AesKey);
    String da2 = encryptAES(d2, Data.AesKey);
    setState(() {
      Data.stationIds = encId;
      Data.date1 = da1;
      Data.date2 = da2;
    });

    reportDatafetch(encId, da1, da2);
  }

  Future<void> reportDatafetch(String id, String d1, String d2) async {
    isLoading = true;
    var response = await http.get(
        Uri.parse(
            '${config.baseUrl}${config.ReportData}?stationIds=$id&fromDate=$d1&toDate=$d2'),
        headers: {
          "Authorization": config.bearer_token,
          "apiKey": config.apiKey,
          "Content-type": "application/json"
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      List<ReportsData> list = (data['stationDetails'] as List)
          .map((e) => ReportsData.fromJson(e))
          .toList();

      for (var sensor in list) {
        List<RSensorss> one = sensor.sensors;
        for (var param in one) {
          List<RSensorParameters> two = param.sensorParameters;
          for (var senss in two) {
            paraName = senss.ParamName;
            unit = senss.Unit;
            List<RsensorDataPoint> sensss = senss.datapoints;
            for (var sens in sensss) {
              dataa = sens.Data;

              final chartDatas = ChartData(
                DateTime.parse("${sens.Date}T${sens.Time}"),
                double.parse(sens.Data),
              );
              chartData.add(chartDatas);
              Keys().chartDataSet(chartData);
            }
            setState(() {
              isLoading = false;
            });
          }
        }
      }

      // setState(() {
      //   _users = list;
      // });
    } else if (response.statusCode == 401) {
      RefreshToken().refreshToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    final MapStyle controller = Get.put(MapStyle());
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Stack(children: [
            FlutterMap(
              options: MapOptions(
                  center: routpointss[0],
                  zoom: 10,
                  onTap: ((tapPosition, point) => {
                        setState(() {
                          isOpen = false;
                        })
                      })),
              children: [
                TileLayer(
                  urlTemplate: controller.mapStyle,
                  // 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],

                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    for (int i = 0; i < Data.routpoints.length; i++)
                      Marker(
                          point: routpointss[i],
                          builder: (ctx) => InkWell(
                              onTap: () {
                                // dataEncrypt(1, '2024-03-03T12:12:50',
                                //     '2024-04-25T12:12:50');
                                // _showModalBottomSheet(context);
                                _showModalBottomSheet(
                                    context, stationNames[i], updateddate[i]);
                              },
                              child: Image.asset('assets/image/on.png')
                              // const Icon(
                              //   color: Colors.amber,
                              // ),
                              )),
                  ],
                ),
                const CircleLayer(
                  circles: [],
                ),
              ],
            ),
            if (isOpen)
              Positioned(
                  top: 200,
                  left: 3,
                  child: Container(
                    height: 350,
                    width: 350,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        const ChartFm(
                          isSelected: false,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 15,
                              width: 30,
                              color: AppColor.Blue,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(dateRage),
                          ],
                        )
                      ],
                    ),
                  ))
          ]);
  }

  void _showModalBottomSheet(
      BuildContext context, String name, String updatetime) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation: 10,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Container(
            width: 350,
            // color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Updated : $updatetime',
                        style: GoogleFonts.ubuntu(fontSize: 15),
                      ),
                      Text(
                        name,
                        style: GoogleFonts.ubuntu(
                            color: AppColor.Blue, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isOpen = true;
                    });
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white54,
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 3),
                              blurRadius: 15,
                              color: Colors.grey.withOpacity(0.3))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/level.svg',
                          height: 50,
                          width: 50,
                          color: Colors.blue,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(dataa),
                            Text(unit),
                          ],
                        ),
                        Text(paraName)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
