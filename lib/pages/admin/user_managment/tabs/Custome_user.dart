// ignore_for_file: file_names
// // ignore_for_file: file_names, non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';
// import 'package:route_between_two_points/pages/admin/user_managment/widget.dart';

// import '../../../../utils/style.dart';

// class CustomUserRole extends StatefulWidget {
//   const CustomUserRole({super.key});

//   @override
//   State<CustomUserRole> createState() => _CustomUserRoleState();
// }

// class _CustomUserRoleState extends State<CustomUserRole> {
//   final TextEditingController _role = TextEditingController();
//   final TextEditingController _desc = TextEditingController();
//   final MultiSelectController _controller = MultiSelectController();
//   String selectedModule = 'one';
//   List<String> Module = ['one', 'two'];
//   List<ValueItem> items = [
//     const ValueItem(label: 'view', value: '1'),
//   ];
//   List<String> Roles = [];
//   List<String> selectedValue = [];
//   List<String> listModule = [];
//   List<String> listoperation = [];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   offset: const Offset(0, 2),
//                   blurRadius: 6.0)
//             ],
//             borderRadius: const BorderRadius.all(Radius.circular(10))),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListView(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'User Role',
//                   style: GoogleFonts.ubuntu(fontSize: 20),
//                 ),
//               ),
//               const Divider(),
//               const SizedBox(
//                 height: 10,
//               ),
//               Custome(Controller: _role, Title: 'Role Name*'),
//               const SizedBox(
//                 height: 10,
//               ),
//               Custome(Controller: _desc, Title: 'Role Description*'),
//               const SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                       columnSpacing: 5,
//                       headingRowHeight: 80,
//                       columns: [
//                         DataColumn(
//                             label: SizedBox(
//                                 width: 150,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text('Module*'),
//                                     CaliDetaDrop(
//                                         valuee: selectedModule, list: Module),
//                                   ],
//                                 ))),
//                         DataColumn(
//                             label: SizedBox(
//                           width: 150,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text('operation*'),
//                               MultiSelectDropDown(
//                                 showClearIcon: true,
//                                 controller: _controller,
//                                 onOptionSelected: (options) {
//                                   setState(() {
//                                     selectedValue = options
//                                         .map((item) => item.label)
//                                         .toList();
//                                   });
//                                 },
//                                 options: items,
//                                 selectionType: SelectionType.multi,
//                                 chipConfig:
//                                     const ChipConfig(wrapType: WrapType.wrap),
//                                 dropdownHeight: 300,
//                                 optionTextStyle: const TextStyle(fontSize: 16),
//                                 showChipInSingleSelectMode: true,
//                                 selectedOptionIcon:
//                                     const Icon(Icons.check_circle),
//                               ),
//                             ],
//                           ),
//                         )),
//                         DataColumn(
//                             label: InkWell(
//                           onTap: () {
//                             setState(() {
//                               listModule.add(selectedModule);
//                               listoperation.add(selectedValue.toString());
//                             });
//                           },
//                           child: Container(
//                             height: 30,
//                             width: 30,
//                             color: AppColor.Blue,
//                             child: const Center(
//                                 child: Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             )),
//                           ),
//                         )),
//                       ],
//                       rows: List.generate(listModule.length, (index) {
//                         return DataRow(cells: [
//                           // DataCell(Text(name ?? "")),
//                           DataCell(Text(listModule[index])),
//                           DataCell(Center(child: Text(listoperation[index]))),

//                           DataCell(IconButton(
//                             onPressed: () {},
//                             icon: const Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             ),
//                           )),
//                         ]);
//                       })),
//                 ),
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Roles.add(_role.text);
//                     },
//                     child: Container(
//                       height: 40,
//                       width: 80,
//                       decoration: const BoxDecoration(
//                           color: Colors.lightBlue,
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       child: const Center(
//                         child: Text(
//                           'Add',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   InkWell(
//                     onTap: () {},
//                     child: Container(
//                       height: 40,
//                       width: 80,
//                       decoration: BoxDecoration(
//                           color: Colors.lightBlueAccent.withOpacity(0.8),
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(10))),
//                       child: const Center(
//                         child: Text(
//                           'Clear',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               DataTable(
//                   columnSpacing: 5,
//                   columns: const [
//                     DataColumn(label: Text('Role Name')),
//                     DataColumn(label: Text('Action')),
//                   ],
//                   rows: List.generate(Roles.length, (index) {
//                     return DataRow(cells: [
//                       // DataCell(Text(name ?? "")),
//                       DataCell(Text(Roles[index])),
//                       DataCell(Center(
//                           child: IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.edit,
//                           color: AppColor.Blue,
//                         ),
//                       ))),
//                     ]);
//                   })),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Custome extends StatelessWidget {
//   final String Title;
//   // final String lableText;
//   final TextEditingController Controller;

//   const Custome({
//     required this.Controller,
//     // required this.lableText,
//     required this.Title,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(width: 130, child: Text(Title)),
//           const SizedBox(
//             width: 3,
//           ),
//           Flexible(
//             child: Container(
//               height: 40,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.withOpacity(0.3)),
//                 borderRadius: const BorderRadius.all(Radius.circular(15)),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: Controller,
//                   decoration: const InputDecoration(
//                     // labelText: lableText,
//                     // hintText: hint,
//                     contentPadding: EdgeInsets.symmetric(vertical: 10.0),
//                     border: InputBorder.none,
//                     // OutlineInputBorder(
//                     //     borderRadius: BorderRadius.all(Radius.circular(20)))
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
