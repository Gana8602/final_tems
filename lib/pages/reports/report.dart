// ignore_for_file: unused_import, depend_on_referenced_packages, deprecated_member_use, empty_catches, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:share/share.dart';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
// import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Tems/services/refresh_service.dart';
import 'package:Tems/config/config.dart';
import 'package:Tems/controllers/drawer_controller.dart';
import 'package:Tems/controllers/key_controller.dart';
import 'package:Tems/pages/Drawer_right/drawer_right.dart';
import 'package:Tems/pages/Drawer_right/filter_drawer.dart';
import 'package:Tems/pages/widget/bar.dart';
import 'package:Tems/pages/widget/drawer_left/drawer_left.dart';
import 'package:Tems/pages/widget/float_Button.dart';
import 'package:Tems/utils/string.dart';
import 'package:http/http.dart' as http;
import '../../services/encrypt.dart';
import '../../services/reportsData_service.dart';
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
  final TextEditingController _search = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DrawerStrings _string = Get.put(DrawerStrings());
  String StationName = '';
  List<RsensorDataPoint> _users = [];
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
        setState(() {
          StationName = name;
        });
        int id = sensor.StationId;
        Data.stationNameswithId.add({'name': name, 'id': id});
        List<RSensorss> one = sensor.sensors;
        for (var param in one) {
          List<RSensorParameters> two = param.sensorParameters;
          for (var datas in two) {
            List<RsensorDataPoint> dataa = datas.datapoints;
            for (var data in dataa) {
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
              _users = dataa;
              filteredUsers = _users;
            });
          }

          setState(() {});
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
    } else {}
  }

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _setDate();
    _search.addListener(_filterUsers);
  }

  String start = "";
  String end = "";
  void _setDate() {
    DateTime now = DateTime.now();
    String selectedStaretDate =
        "${DateFormat('yyyy-MM-dd').format(now)}T00:01:02";
    String selectedendDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);
    setState(() {
      start = selectedStaretDate;
      end = selectedendDate;
    });
    dataEncrypt(1, start, end);
  }

  List<RsensorDataPoint> filteredUsers = [];
  void _filterUsers() {
    String query = _search.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredUsers = _users;
      } else {
        filteredUsers = _users.where((user) {
          return user.Data.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Future<void> generatePdf() async {
    try {
      final pdf = pw.Document();
      const int rowsPerPage = 50; // Number of rows per page (adjust as needed)
      const List<String> headers = [
        "stationName",
        "date",
        "time",
        "Water Level"
      ];

      // Split pdfrowData into chunks of rowsPerPage
      for (int i = 0; i < pdfrowData.length; i += rowsPerPage) {
        final List<List<String>> chunk = pdfrowData.sublist(
            i,
            i + rowsPerPage > pdfrowData.length
                ? pdfrowData.length
                : i + rowsPerPage);

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Table.fromTextArray(
                context: context,
                headers: headers,
                data: chunk,
              );
            },
          ),
        );
      }

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

      // Add all rows from pdfrowData to csvData
      for (var row in pdfrowData) {
        csvData.add(row);
      }

      // Get the directory for saving the file
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String filePath = '${appDocumentsDirectory.path}/data.csv';

      // Write CSV data to file
      File csvFile = File(filePath);
      String csvDataString = const ListToCsvConverter().convert(csvData);
      await csvFile.writeAsString(csvDataString);

      // Share the file
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
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
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
                                labelText: 'Search ',
                                hintText: 'Search Data here',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                prefixIcon: Icon(Icons.search),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightBlue),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
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
                              border:
                                  Border.all(color: AppColor.Blue, width: 0.5),
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
                  Expanded(
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PaginatedDataTable(
                            showFirstLastButtons: true,
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
                            source: _UserDataSource(
                                context, filteredUsers, StationName),
                            rowsPerPage: 9,
                            columnSpacing: 10, // Change as per your requirement
                          ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class _UserDataSource extends DataTableSource {
  final BuildContext context;
  final List<RsensorDataPoint> users;
  final String stationName;

  _UserDataSource(this.context, this.users, this.stationName);

  @override
  DataRow? getRow(int index) {
    if (index >= users.length) return null;

    final user = users[index];

    String date = user.Date;
    String time = user.Time;
    String data = user.Data;
    List<String> timeParts = time.split(':');
    String formattedTime = timeParts.sublist(0, 2).join(':');

    return DataRow(cells: [
      DataCell(Text(stationName)),
      DataCell(Text(date)),
      DataCell(Text(formattedTime)),
      DataCell(Center(child: Text(data))),
    ]);
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
