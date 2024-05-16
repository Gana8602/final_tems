// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:route_between_two_points/pages/widget/bar.dart';
import 'package:route_between_two_points/pages/widget/drawer_left/drawer_left.dart';

import '../../../utils/style.dart';

class MyDataTablePage extends StatefulWidget {
  const MyDataTablePage({super.key});

  @override
  _MyDataTablePageState createState() => _MyDataTablePageState();
}

class _MyDataTablePageState extends State<MyDataTablePage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  String searchData = '';

  // Sample data for the table
  final List<Map<String, dynamic>> _allData = List.generate(
    100, // Number of rows
    (index) => {
      'Module': index + 1,
      'User Action': 'Item ${index + 1}',
      'User Operation': (index + 1) * 10,
      'Performed At': 'Item ${index + 1}',
      'Performed By': 'Item ${index + 1}',
    },
  );

  List<Map<String, dynamic>> _filteredData = [];

  @override
  void initState() {
    _filteredData = List.from(_allData);
    super.initState();
  }

  void _filterData(String value) {
    setState(() {
      searchData = value;
      if (searchData.isEmpty) {
        _filteredData = List.from(_allData);
      } else {
        _filteredData = _allData
            .where((item) =>
                item['Module'].toString().contains(value) ||
                item['User Action']
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                item['Performed By']
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                item['Performed At']
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                item['User Operation']
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Head(context),
      drawer: const Drawerleft(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              PaginatedDataTable(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Search : ',
                      style: GoogleFonts.ubuntu(fontSize: 15),
                    ),
                    SizedBox(
                      height: 30,
                      width: 150,
                      child: Flexible(
                        child: TextField(
                          onChanged: _filterData,
                          decoration: InputDecoration(
                              labelText: '',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColor.Blue)),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                    ),
                  ],
                ),
                rowsPerPage: _rowsPerPage,
                availableRowsPerPage: const [5, 10, 20],
                onRowsPerPageChanged: (value) {
                  setState(() {
                    _rowsPerPage = value!;
                  });
                },
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                columns: [
                  DataColumn(
                    label: const Text('Module'),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = ascending;
                        if (ascending) {
                          _filteredData.sort(
                              (a, b) => a['Module'].compareTo(b['Module']));
                        } else {
                          _filteredData.sort(
                              (a, b) => b['Module'].compareTo(a['Module']));
                        }
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text('User Action'),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = ascending;
                        if (ascending) {
                          _filteredData.sort((a, b) =>
                              a['User Action'].compareTo(b['User Action']));
                        } else {
                          _filteredData.sort((a, b) =>
                              b['User Action'].compareTo(a['User Action']));
                        }
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text('User Operation'),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = ascending;
                        if (ascending) {
                          _filteredData.sort((a, b) => a['User Operation']
                              .compareTo(b['User Operation']));
                        } else {
                          _filteredData.sort((a, b) => b['User Operation']
                              .compareTo(a['User Operation']));
                        }
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text('Performed At'),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = ascending;
                        if (ascending) {
                          _filteredData.sort((a, b) =>
                              a['Performed At'].compareTo(b['Performed At']));
                        } else {
                          _filteredData.sort((a, b) =>
                              b['Performed At'].compareTo(a['Performed At']));
                        }
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text('Performed By'),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = ascending;
                        if (ascending) {
                          _filteredData.sort((a, b) =>
                              a['Performed By'].compareTo(b['Performed By']));
                        } else {
                          _filteredData.sort((a, b) =>
                              b['Performed By'].compareTo(a['Performed By']));
                        }
                      });
                    },
                  ),
                ],
                source: _MyDataTableSource(_filteredData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> _data;

  _MyDataTableSource(this._data);

  @override
  DataRow getRow(int index) {
    final rowData = _data[index];
    return DataRow(cells: [
      DataCell(Text(rowData['Module'].toString())),
      DataCell(Text(rowData['User Action'].toString())),
      DataCell(Text(rowData['User Operation'].toString())),
      DataCell(Text(rowData['Performed At'].toString())),
      DataCell(Text(rowData['Performed By'].toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
