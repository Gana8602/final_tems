// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Tems/services/refresh_service.dart';
import 'package:Tems/config/config.dart';
import 'package:Tems/pages/widget/bar.dart';
import 'package:Tems/pages/widget/drawer_left/drawer_left.dart';
import 'package:Tems/pages/widget/style.dart';
import 'package:Tems/utils/string.dart';
import '../../config/data.dart';
import 'package:http/http.dart' as http;
import '../../controllers/drawer_controller.dart';
import '../../model/data_model/sensor_by_station_Id.dart';
import '../../utils/style.dart';
import '../widget/float_Button.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final DrawerStrings _string = Get.put(DrawerStrings());
  final MapStyle controller = Get.put(MapStyle());
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final double val = 23.7;
  String todaydate = '';
  bool isLoading = false;
  List<String> StationNames = [];
  String _selectedItem = Data.stationNames.first;
  List<dynamic> datas = [];
  String ParaName = '';
  @override
  void initState() {
    super.initState();
    isLoading = true;

    getSensorDetails();
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
      List<SensorByStationId> Stations = (data['stationDetails'] as List)
          .map((e) => SensorByStationId.fromJson(e))
          .toList();

      for (var sensors in Stations) {
        List<Sensorss> senss = sensors.sensors;
        sensors.StationId.toString();
        String names = sensors.StationName;
        StationNames.add(names);

        setState(() {
          Data.stationNames2 = StationNames;
        });

        for (var sen in senss) {
          List<SensorParameters> param = sen.sensorParameters;
          for (var parameter in param) {
            String name = parameter.ParamName;
            String unit = parameter.Unit;
            String val = parameter.Data;
            double valu = double.parse(val);
            String value = valu.toStringAsFixed(2);

            String date = parameter.Date;
            String times = parameter.Time;
            List<String> timem = times.split(':');
            String time = timem.sublist(0, 2).join(':');

            setState(() {
              ParaName = name;
              todaydate = "$date $time";
            });

            Map<String, dynamic> data = {
              'name': name,
              'value': value,
              'type': unit,
              'icon': "assets/svg/level.svg"
            };
            datas.add(data);
          }
        }

        setState(() {
          isLoading = false;
        });
      }
    } else if (response.statusCode == 401) {
      RefreshToken().refreshToken();
      throw Exception('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: Head(context),
      drawer: const Drawerleft(),
      endDrawer: const DataQADra(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const FloatButton(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dashboard',
                        style: GoogleFonts.ubuntu(fontSize: 20),
                      ),

                      Row(
                        children: [
                          Text(
                            'Last Updated : ',
                            style: GoogleFonts.ubuntu(color: AppColor.Blue),
                          ),
                          Text(
                            todaydate,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Mandwa Jetty',
                        style: GoogleFonts.ubuntu(
                            fontSize: 30, color: AppColor.Blue),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: DropdownButtonFormField<String>(
                              value: _selectedItem,
                              items: Data.stationNames.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedItem = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.lightBlue),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _string.drawervalue = 'addStation';
                              });
                              _key.currentState!.openEndDrawer();
                            },
                            child: Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                      color: AppColor.Blue, width: 1)),
                              child: Center(
                                  child: Icon(
                                Icons.filter_alt_outlined,
                                color: AppColor.Blue,
                              )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: 400,
                            width: 400,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                image: DecorationImage(
                                    image: AssetImage('assets/image/buoy.jpeg'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),

                      // const Text('Buoy Watch Circle'),
                      const SizedBox(
                        height: 20,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              ParaName,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          for (int i = 0; i < datas.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 250,
                                width: 380,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        offset: const Offset(0, 1),
                                        blurRadius: 15,
                                      )
                                    ],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: AppColor.Blue,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(60))),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              '${datas[i]['icon']}',
                                              color: Colors.white,
                                              width: 70,
                                              height: 70,
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${datas[i]['value'].toString()} ${datas[i]['type']}',
                                        style: GoogleFonts.ubuntu(fontSize: 22),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        datas[i]['name'],
                                        style: GoogleFonts.ubuntu(
                                            fontSize: 27, color: AppColor.Blue),
                                      ),
                                    ]),
                              ),
                            )
                        ],
                      )
                    ]),
              ),
            ),
    );
  }
}
