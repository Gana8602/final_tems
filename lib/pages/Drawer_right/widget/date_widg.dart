import 'package:get/get.dart';

class DateDAta extends GetxController {
  final List<String> years = [
    '2022',
    '2023',
    '2024'
  ]; // Add more years if needed
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}


// class YearMonthDropdowns extends StatefulWidget {
//   @override
//   _YearMonthDropdownsState createState() => _YearMonthDropdownsState();
// }



//   String? selectedYear;
//   String? selectedMonth;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Year and Month Dropdowns')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             DropdownButton<String>(
//               value: selectedYear,
//               hint: Text('Select Year'),
//               onChanged: (newValue) {
//                 setState(() {
//                   selectedYear = newValue;
//                   // Reset the selected month when the year changes
//                   selectedMonth = null;
//                 });
//               },
//               items: years.map((year) {
//                 return DropdownMenuItem<String>(
//                   value: year,
//                   child: Text(year),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16),
//             DropdownButton<String>(
//               value: selectedMonth,
//               hint: Text('Select Month'),
//               onChanged: (newValue) {
//                 setState(() {
//                   selectedMonth = newValue;
//                 });
//               },
//               items: months.where((month) {
//                 // Show only months up to the current month if the selected year is the current year
//                 if (selectedYear == DateTime.now().year.toString()) {
//                   final currentMonth = DateTime.now().month;
//                   final monthIndex = months.indexOf(month) + 1;
//                   return monthIndex <= currentMonth;
//                 }
//                 return true; // Show all months for previous years
//               }).map((month) {
//                 return DropdownMenuItem<String>(
//                   value: month,
//                   child: Text(month),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
