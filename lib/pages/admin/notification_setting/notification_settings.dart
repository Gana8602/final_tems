// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:route_between_two_points/pages/widget/bar.dart';
import 'package:route_between_two_points/pages/widget/drawer_left/drawer_left.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/style.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  String SelectedStation = 'WQ1';
  String SelectedType = 'Water Quality';
  String SelectedSensors = 'BOTH(WARN & DANGER)';

  List<String> Stations = ['WQ1', 'Bhitarkanika National Park'];
  List<String> sensors = [
    'BOTH(WARN & DANGER)',
    'WARN',
    'DANGER',
    'GENERAL(INTRUSION)'
  ];
  List<String> types = ['Water Quality'];
  List<String> addedStation = [];
  List<String> addedSensor = [];
  List<String> addedtypes = [];
  List<String> addednames = [];
  List<String> addedemails = [];

  void clearFields() {
    setState(() {
      SelectedStation = 'WQ1';
      SelectedType = 'Water Quality';
      SelectedSensors = 'BOTH(WARN & DANGER)';
      _name.clear();
      _email.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Head(context),
        drawer: const Drawerleft(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(
                'User Action Log',
                style: GoogleFonts.ubuntu(fontSize: 20),
              ),
              const Row(
                children: [
                  Text('Home | '),
                  Text('User Action Log'),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(0, 2),
                              blurRadius: 6.0)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Station Name*'),
                              const SizedBox(
                                height: 5,
                              ),
                              Drop(SelectedStation, Stations, (newValue) {
                                setState(() {
                                  SelectedStation = newValue!;
                                });
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Sensor Name*'),
                              const SizedBox(
                                height: 5,
                              ),
                              Drop(SelectedType, types, (newValue) {
                                setState(() {
                                  SelectedType = newValue!;
                                });
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Calibration Type*'),
                              const SizedBox(
                                height: 5,
                              ),
                              Drop(SelectedSensors, sensors, (newValue) {
                                setState(() {
                                  SelectedSensors = newValue!;
                                });
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Name*'),
                              SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _name,
                                  decoration: const InputDecoration(
                                    // contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Email id*'),
                              SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _email,
                                  decoration: const InputDecoration(
                                    // contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        addedStation.add(SelectedStation);
                                        addedtypes.add(SelectedType);
                                        addedSensor.add(SelectedSensors);
                                        addednames.add(_name.text);
                                        addedemails.add(_email.text);
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: AppColor.Blue,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6))),
                                      child: Center(
                                        child: Text(
                                          'Add',
                                          style: GoogleFonts.ubuntu(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      clearFields();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: AppColor.Blue,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6))),
                                      child: Center(
                                        child: Text(
                                          'Clear',
                                          style: GoogleFonts.ubuntu(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Water Quality Notification Details',
                                style: GoogleFonts.ubuntu(fontSize: 19),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                      columnSpacing: 10,
                                      columns: const [
                                        DataColumn(
                                            label: SizedBox(
                                                width: 60,
                                                child: Text(
                                                  'Station Name',
                                                  softWrap: true,
                                                ))),
                                        DataColumn(
                                            label: SizedBox(
                                                width: 70,
                                                child: Text(
                                                  'Sensor Type',
                                                  softWrap: true,
                                                ))),
                                        DataColumn(
                                            label: SizedBox(
                                                width: 75,
                                                child: Text(
                                                  'Notification Type',
                                                  softWrap: true,
                                                ))),
                                        DataColumn(label: Text('Name')),
                                        DataColumn(label: Text('Email id')),
                                        // DataColumn(label: Text('action')),
                                      ],
                                      rows: List.generate(addedStation.length,
                                          (index) {
                                        return DataRow(cells: [
                                          // DataCell(Text(name ?? "")),
                                          DataCell(Text(addedStation[index])),
                                          DataCell(Center(
                                              child: Text(addedtypes[index]))),
                                          DataCell(Center(
                                              child: Text(addedSensor[index]))),
                                          DataCell(Center(
                                              child: Text(addednames[index]))),
                                          DataCell(Center(
                                              child: Text(addedemails[index]))),
                                          // DataCell(Row(
                                          //   children: [
                                          //     IconButton(
                                          //       onPressed: () {
                                          //         editRow(index);
                                          //       },
                                          //       icon: const Icon(
                                          //         Icons.edit,
                                          //         color: Colors.lightBlue,
                                          //       ),
                                          //     ),
                                          //     const SizedBox(
                                          //       width: 5,
                                          //     ),
                                          //     IconButton(
                                          //         onPressed: () {},
                                          //         icon: const Icon(
                                          //           Icons.delete,
                                          //           color: Colors.red,
                                          //         ))
                                          //   ],
                                          // )
                                          // ),
                                        ]);
                                      })),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
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
        ),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
