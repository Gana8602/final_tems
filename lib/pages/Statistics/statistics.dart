// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:route_between_two_points/bool/services/refresh_service.dart';
import 'package:route_between_two_points/config/config.dart';
import 'package:route_between_two_points/pages/Drawer_right/drawer_right.dart';
import 'package:route_between_two_points/pages/Drawer_right/statis_drawer_filter.dart';
import 'package:route_between_two_points/pages/widget/bar.dart';
import 'package:route_between_two_points/pages/widget/drawer_left/drawer_left.dart';
import 'package:route_between_two_points/utils/string.dart';
import 'package:http/http.dart' as http;
import '../../bool/services/encrypt.dart';
import '../../config/data.dart';
import '../../controllers/key_controller.dart';
import '../../model/chart_model.dart';
import '../../model/data_model/report_static_model.dart';
import '../../utils/style.dart';
import 'widgets/linechart.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({
    super.key,
  });

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final DrawerStrings _strings = Get.put(DrawerStrings());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<ChartData> chartData = [];
  bool isLoading = false;
  String stationName = "";

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
      Data.stationNameswithId.clear();
      for (var sensor in list) {
        stationName = sensor.StationName;
        String name = sensor.StationName;
        int id = sensor.StationId;
        Data.stationNameswithId.add({'name': name, 'id': id});

        List<RSensorss> one = sensor.sensors;
        for (var param in one) {
          List<RSensorParameters> two = param.sensorParameters;
          for (var sens in two) {
            final chartDatas = ChartData(
              DateTime.parse(sens.Date),
              double.parse(sens.Data),
            );
            chartData.add(chartDatas);
            Keys().chartDataSet(chartData);
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

  late String _selectedStartDate;
  late String _selectedEndDate;
  late int _selectedStationName;

  void updateSelectedDatesAndStation(
      String startDate, String endDate, int stationName) {
    setState(() {
      _selectedStartDate = startDate;
      _selectedEndDate = endDate;
      _selectedStationName = stationName;
    });

    dataEncrypt(_selectedStationName, _selectedStartDate, _selectedEndDate);
  }

  @override
  void initState() {
    super.initState();
    dataEncrypt(1, '2024-03-03T12:12:50', '2024-04-25T12:12:50');
  }

  Widget DrawerNav2() {
    String data = _strings.drawervalue;
    if (data == 'SataticFilter') {
      return StaticticDrawerFilter(
        onFilterSelected: updateSelectedDatesAndStation,
      );
    } else if (data == 'main') {
      return const DrawerRight();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: Head(context),
      drawer: const Drawerleft(),
      endDrawer: DrawerNav2(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Stack(children: [
        Positioned(
          bottom: 20,
          right: 0, // Adjust 50.0 as needed
          child: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _strings.drawervalue = 'main';
                  });

                  Scaffold.of(context).openEndDrawer();
                },
                backgroundColor: Colors.transparent,
                child: Container(
                    height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      color: AppColor.Blue,
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Lottie.asset('assets/svg/gear.json',
                            width: 8, height: 8),
                      ),
                    )),
              );
            },
          ),
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Statistics',
                    style: GoogleFonts.ubuntu(fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _strings.drawervalue = 'SataticFilter';
                        });

                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColor.Blue, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.filter_alt_outlined,
                                color: AppColor.Blue,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Filter",
                                style: TextStyle(
                                    color: AppColor.Blue, fontSize: 20),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              //

              // Row(
              //   children: [
              //     SizedBox(width: 6),
              //     Text(
              //       'Water Level',
              //       style: GoogleFonts.ubuntu(
              //         color: AppColor.Blue,
              //         fontSize: 20,
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 450,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const ChartF(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 50,
                              color: Colors.lightBlue,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(stationName)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}