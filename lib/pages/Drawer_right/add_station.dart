// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:route_between_two_points/config/config.dart';
import 'package:route_between_two_points/config/data.dart';
import 'package:route_between_two_points/utils/style.dart';
import 'package:http/http.dart' as http;
import '../../model/data_model/sensor_by_station_Id.dart';

class AddStation extends StatefulWidget {
  const AddStation({super.key});

  @override
  State<AddStation> createState() => _AddStationState();
}

class _AddStationState extends State<AddStation> {
  final MultiSelectController _controller = MultiSelectController();
  bool istick = false;
  bool isLoading = false;
  List<String> parametertype = [];
  String SelectedParameterType = "";
  List<Map<String, dynamic>> StationNames = [];

  String Selectedparameter = "";
  List<ValueItem>? SelectedStation;
  List<String> parameter = [];
  List<ValueItem> items = [];

  void itemSet() {
    List<ValueItem> itemss = Data.stationNameswithId
        .map((e) => ValueItem(label: e['name'], value: e['id'].toString()))
        .toList();

    setState(() {
      items = itemss;
      isLoading = false;
      SelectedStation = [items.first];
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getSensorDetails();
  }

  Future<void> getSensorDetails() async {
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
        String id = sensors.StationId.toString();
        String names = sensors.StationName;
        StationNames.add({'name': names, 'id': id});
        setState(() {
          Data.stationNameswithId = StationNames;
        });

        // ReportDataService().dataEncrypt(sensors.StationId);
        for (var sens in senss) {
          String sensor = sens.SensorName;
          parametertype.add(sensor);
          List<SensorParameters> senpar = sens.sensorParameters;
          for (var paramet in senpar) {
            String param = paramet.ParamName;
            parameter.add(param);
          }
        }
        SelectedParameterType = parametertype.first;
        Selectedparameter = parameter.first;

        itemSet();
      }
    } else {
      throw Exception('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                      title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Advance Customization'),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            istick = !istick;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: istick ? Colors.blue : Colors.grey,
                                  strokeAlign: 1)),
                          child: Center(
                            child: istick
                                ? const Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.blue,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'All Station',
                        style: GoogleFonts.ubuntu(fontSize: 18),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MultiSelectDropDown(
                    showClearIcon: true,
                    controller: _controller,
                    onOptionSelected: (options) {
                      debugPrint(options.toString());
                    },
                    options: items,
                    selectionType: SelectionType.multi,
                    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                    dropdownHeight: 300,
                    optionTextStyle: GoogleFonts.ubuntu(fontSize: 16),
                    selectedOptions: istick ? items : SelectedStation!,
                    showChipInSingleSelectMode: true,
                    selectedOptionIcon: const Icon(Icons.check_circle),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Parameter Type*'),
                      Drop(SelectedParameterType, parametertype, (value) {
                        SelectedParameterType = value!;
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Parameter*'),
                      Drop(Selectedparameter, parameter, (value) {
                        Selectedparameter = value!;
                      }),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border:
                              Border.all(color: AppColor.Blue, strokeAlign: 1),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.ubuntu(color: AppColor.Blue),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                          // Parameters to encrypt
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              // border: Border.all(color: Colors.blue, strokeAlign: 1),
                              color: AppColor.Blue),
                          child: Center(
                            child: Text(
                              'Search',
                              style: GoogleFonts.ubuntu(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
    );
  }

  Widget Drop(
    String? selectedValue,
    List<String> list,
    void Function(String?)? onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: list.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        ),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
