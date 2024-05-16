// ignore_for_file: unused_import, depend_on_referenced_packages, deprecated_member_use, empty_catches, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:share/share.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:route_between_two_points/bool/bool_values.dart';
import 'package:route_between_two_points/bool/services/refresh_service.dart';
import 'package:route_between_two_points/config/config.dart';
import 'package:route_between_two_points/controllers/drawer_controller.dart';
import 'package:route_between_two_points/controllers/key_controller.dart';
import 'package:route_between_two_points/pages/Drawer_right/drawer_right.dart';
import 'package:route_between_two_points/pages/Drawer_right/filter_drawer.dart';
import 'package:route_between_two_points/pages/reports/widget/report_data.dart';
import 'package:route_between_two_points/pages/widget/bar.dart';
import 'package:route_between_two_points/pages/widget/drawer_left/drawer_left.dart';
import 'package:route_between_two_points/pages/widget/float_Button.dart';
import 'package:route_between_two_points/utils/string.dart';
import 'package:http/http.dart' as http;
import '../../bool/services/encrypt.dart';
import '../../bool/services/reportsData_service.dart';
import '../../config/data.dart';
import '../../model/chart_model.dart';
import '../../model/data_model/report_static_model.dart';
import '../../utils/style.dart';

class ExpandableTableExample extends StatefulWidget {
  const ExpandableTableExample({super.key});

  @override
  State<ExpandableTableExample> createState() => _ExpandableTableExampleState();
}

class _ExpandableTableExampleState extends State<ExpandableTableExample> {
  // final ReportController controller = Get.put(ReportController());
  TextEditingController _search = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DrawerStrings _string = Get.put(DrawerStrings());
  // late List<RSensorParameters> _list = [];
  List<RSensorParameters> _users = [];
  List<dynamic> rowData = [];
  List<List<String>> pdfrowData = [];

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
    setState(() {
      isLoading = true;
    });
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
        String name = sensor.StationName;

        int id = sensor.StationId;
        Data.stationNameswithId.add({'name': name, 'id': id});
        List<RSensorss> one = sensor.sensors;
        for (var param in one) {
          List<RSensorParameters> two = param.sensorParameters;
          for (var data in two) {
            String date = data.Date;
            String time = data.Time;
            String level = data.Data;

            rowData = [
              name,
              date,
              time,
              level,
              // data.Data,
            ];
            pdfrowData.add([
              name,
              date,
              time,
              level,
              // data.Data,
            ]);
          }

          setState(() {
            _users = two;
          });
        }
      }

      // setState(() {
      //   _users = list;
      // });

      setState(() {
        isLoading = false;
      });
    } else if (response.statusCode == 401) {
      RefreshToken().refreshToken();
    }
  }

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    dataEncrypt(1, '2024-03-03T12:12:50', '2024-04-25T12:12:50');
  }

  Future<void> generatePdf() async {
    try {
      final pdf = pw.Document();

      // Add PDF content
      // List<dynamic> tableData = rowData.map((row) => row.split(',')).toList();

      // Add PDF content
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Table.fromTextArray(
              context: context,
              data: <List<String>>[
                <String>["stationName", "date", "time", "Water Level"],
                ...pdfrowData, // Add the table data
              ],
            );
          },
        ),
      );

      // Get the directory for saving the file
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String filePath = '${appDocumentsDirectory.path}/data.pdf';

      // Save PDF to file
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      // Share the file
      Share.shareFiles([filePath]);
    } catch (e) {}
  }

  Future<void> convertJsonToCsv() async {
    try {
      List<List<dynamic>> csvData = [];

      // Add CSV headers
      csvData.add(["stationName", "date", "time", "Water Level"]);
      csvData.add(rowData);
      // print(csvData);

      // Extract data from JSON response and add to CSV

      // Get the directory for saving the file
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String filePath = '${appDocumentsDirectory.path}/data.csv';

      // Write CSV data to file
      File csvFile = File(filePath);
      String csvDataString = const ListToCsvConverter().convert(csvData);
      csvFile.writeAsString(csvDataString);
      Share.shareFiles([filePath]);
    } catch (e) {}
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

  // final DrawerStrings _string = Get.put(DrawerStrings());
  Widget DrawerNav() {
    String data = _string.drawervalue;
    if (data == 'reportFilter') {
      return FilterDrawer(
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
      key: _scaffoldKey,
      appBar: Head(context),
      floatingActionButton: Stack(children: [
        Positioned(
          bottom: 50,
          right: 0, // Adjust 50.0 as needed
          child: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _string.drawervalue = 'main';
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
      endDrawer: DrawerNav(),
      drawer: const Drawerleft(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // padding: const EdgeInsets.all(8.0),
            children: [
              Text('Reports', style: GoogleFonts.ubuntu(fontSize: 20)),

              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _search,
                          decoration: const InputDecoration(
                            labelText: 'Search',
                            hintText: 'Search',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            prefixIcon: Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.lightBlue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        _string.drawervalue = 'reportFilter';
                      });

                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.Blue, width: 0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
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
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tide',
                    style: GoogleFonts.ubuntu(fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: AppColor.Blue)),
                      child: Center(
                          child: PopupMenuButton(
                        icon: Icon(
                          Icons.file_download_outlined,
                          color: AppColor.Blue,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () {
                                convertJsonToCsv();
                              },
                              child: const Text("csv")),
                          PopupMenuItem(
                              onTap: () {
                                generatePdf();
                              },
                              child: const Text("Pdf"))
                        ],
                      )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                width: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   // crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //       height: 40,
              //       width: 40,
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           boxShadow: [
              //             BoxShadow(
              //               offset: const Offset(0, 3),
              //               color: Colors.grey.withOpacity(0.3),
              //               blurRadius: 4,
              //             )
              //           ],
              //           borderRadius: const BorderRadius.all(Radius.circular(10))),
              //       child: const Center(
              //           child: Icon(
              //         Icons.filter_alt_outlined,
              //         size: 17,
              //       )),
              //     ),
              //     const SizedBox(width: 10),
              //     Container(
              //       height: 40,
              //       width: 40,
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           boxShadow: [
              //             BoxShadow(
              //               offset: const Offset(0, 3),
              //               color: Colors.grey.withOpacity(0.3),
              //               blurRadius: 4,
              //             )
              //           ],
              //           borderRadius: const BorderRadius.all(Radius.circular(10))),
              //       child: const Center(
              //           child: Icon(
              //         Icons.file_download_outlined,
              //         size: 17,
              //       )),
              //     ),
              //     const SizedBox(width: 10),
              //     Container(
              //       height: 30,
              //       width: 80,
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           boxShadow: [
              //             BoxShadow(
              //               offset: const Offset(0, 3),
              //               color: Colors.grey.withOpacity(0.3),
              //               blurRadius: 4,
              //             )
              //           ],
              //           borderRadius: const BorderRadius.all(Radius.circular(10))),
              //       child: const Center(
              //         child: Text('10 items >'),
              //       ),
              //     ),
              //     const SizedBox(width: 10),
              //   ],
              // ),
              Expanded(
                child: Container(
                  height: 600,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 3),
                            blurRadius: 3,
                            color: Colors.grey.withOpacity(0.5))
                      ]),
                  width: MediaQuery.of(context).size.width,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : PaginatedDataTable(
                          header: const Text('Report Data'),
                          columns: const [
                            DataColumn(
                                label: Text(
                              'Station Name',
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(
                                label: Text(
                              'Date',
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(label: Text('Time')),
                            DataColumn(label: Text('Water Level(m)')),
                          ],
                          source: _UserDataSource(context, _users),
                          rowsPerPage: 8,
                          columnSpacing: 10, // Change as per your requirement
                        ),
                ),
              )
            ]),
      ),
    );
  }
}

class _UserDataSource extends DataTableSource {
  final BuildContext context;
  final List<RSensorParameters> users;

  _UserDataSource(this.context, this.users);

  @override
  DataRow? getRow(int index) {
    if (index >= users.length) return null;

    // / Access sensors directly

    // Iterate through each sensor and extract sensor parameters
    List<DataCell> sensorCells = [];
    for (var sensor in users) {
      //  Access specific sensor parameter data (replace 0 with desired index)
      String date = sensor.Date;
      String time = sensor.Time;
      String data = sensor.Data;
      List<String> timeParts = time.split(':');
      String formattedTime = timeParts.sublist(0, 2).join(':');

      // Create DataCell objects for sensor parameters
      sensorCells.add(const DataCell(Text('Station 1')));
      sensorCells.add(DataCell(Text(date)));
      sensorCells.add(DataCell(Text(formattedTime)));
      sensorCells.add(DataCell(Center(child: Text(data))));
    }

    return DataRow(cells: sensorCells); // Only sensor data cells
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }
}
