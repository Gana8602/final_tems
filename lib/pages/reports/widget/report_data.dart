// import 'package:expandable_datatable/expandable_datatable.dart';

// import '../../../controllers/report_Controller.dart';

// class ReportData {
//   final List<ExpandableColumn<dynamic>> headers = [
//     ExpandableColumn<String>(columnTitle: "First name", columnFlex: 3),
//     ExpandableColumn<int>(columnTitle: "ID", columnFlex: 1),
//     ExpandableColumn<String>(columnTitle: "Lastname", columnFlex: 2),
//     ExpandableColumn<String>(columnTitle: "Maidenname", columnFlex: 4),
//     ExpandableColumn<int>(columnTitle: "Age", columnFlex: 4),
//     ExpandableColumn<String>(columnTitle: "Gender", columnFlex: 4),
//     ExpandableColumn<String>(columnTitle: "Email", columnFlex: 4),
//   ];

//   final List<ExpandableRow> rows = userList.map<ExpandableRow>((e) {
//     return ExpandableRow(cells: [
//       ExpandableCell<String>(columnTitle: "First name", value: e.firstName),
//       ExpandableCell<int>(columnTitle: "ID", value: e.id),
//       ExpandableCell<String>(columnTitle: "Lastname", value: e.lastName),
//       ExpandableCell<String>(columnTitle: "Maidenname", value: e.maidenName),
//       ExpandableCell<int>(columnTitle: "Age", value: e.age),
//       ExpandableCell<String>(columnTitle: "Gender", value: e.gender),
//       ExpandableCell<String>(columnTitle: "Email", value: e.email),
//     ]);
//   }).toList();

//   static get userList => ReportController().userList;
// }
