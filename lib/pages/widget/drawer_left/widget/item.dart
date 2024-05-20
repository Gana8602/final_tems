// ignore_for_file: camel_case_types, deprecated_member_use, non_constant_identifier_names, must_be_immutable, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Tems/pages/admin/user_managment/user_manage.dart';

import '../../../../utils/style.dart';

// ignore: must_be_immutable
class DrawerItem extends StatelessWidget {
  String title;
  Color color;
  SvgPicture ic;
  VoidCallback ontap;

  DrawerItem(
      {super.key,
      required this.title,
      required this.color,
      required this.ic,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: ListTile(
          title: Text(
            title,
            style: GoogleFonts.ubuntu(
              color: color,
              fontSize: 18,
            ),
          ),
          leading: ic),
    );
  }
}

// ignore: must_be_immutable
// class ExpandItem1 extends StatelessWidget {
//   // List<String> title;

//   String MainTitle;
//   Color color;
//   SvgPicture ic;
//   ExpandItem1(
//       {super.key,
//       // required this.title,
//       required this.color,
//       required this.ic,
//       required this.MainTitle});

//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       // childrenPadding: EdgeInsets.zero,
//       leading: ic,
//       title: Text(
//         MainTitle,
//         style: GoogleFonts.ubuntu(color: Colors.white),
//       ),
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.only(left: 22.0),
//           child: ListTile(
//             leading:
//                 SvgPicture.asset('assets/svg/com.svg', color: Colors.white),
//             title: Text(
//               'Communication Center',
//               style: GoogleFonts.ubuntu(color: Colors.white),
//             ),
//             onTap: () {
//               Get.to(() => const Communication());
//               // Handle submenu 1 tap
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 22.0),
//           child: ListTile(
//             leading: SvgPicture.asset('assets/svg/s_master.svg',
//                 color: Colors.white),
//             title: Text(
//               'Station Master',
//               style: GoogleFonts.ubuntu(color: Colors.white),
//             ),
//             onTap: () {
//               Get.to(() => const StationMaster());
//               // Handle submenu 2 tap
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 22.0),
//           child: ListTile(
//             leading: const Icon(Icons.settings_outlined, color: Colors.white),
//             title: Text(
//               'Configuration',
//               style: GoogleFonts.ubuntu(color: Colors.white),
//             ),
//             onTap: () {
//               Get.to(() => const ConfigurationsPage());
//               // Handle submenu 2 tap
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 22.0),
//           child: ListTile(
//             leading: SvgPicture.asset(
//               'assets/svg/data_manage.svg',
//               color: Colors.white,
//             ),
//             title: Text(
//               'Data Management',
//               style: GoogleFonts.ubuntu(color: Colors.white),
//             ),
//             onTap: () {
//               Get.to(() => DataManagementPage());
//               // Handle submenu 2 tap
//             },
//           ),
//         ),
//         Padding(
//             padding: const EdgeInsets.only(left: 22.0),
//             child: ExpandItem1_2(
//                 color: Colors.white,
//                 ic: SvgPicture.asset(
//                   'assets/svg/spanner.svg',
//                   color: Colors.white,
//                 ),
//                 MainTitle: 'Maintnance Manager')),
//       ],
//     );
//   }
// }

// // ignore: must_be_immutable
// class ExpandItem1_2 extends StatelessWidget {
//   // List<String> title;
//   String MainTitle;
//   Color color;
//   SvgPicture ic;
//   ExpandItem1_2(
//       {super.key,
//       // required this.title,
//       required this.color,
//       required this.ic,
//       required this.MainTitle});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(10),
//       color: AppColor.Blue,
//       child: ExpansionTile(
//         childrenPadding: EdgeInsets.zero,
//         leading: ic,
//         title: Text(
//           MainTitle,
//           style: GoogleFonts.ubuntu(color: Colors.white),
//         ),
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(left: 22.0),
//             child: ListTile(
//               leading: SvgPicture.asset('assets/svg/maintanance_settings.svg',
//                   color: Colors.white),
//               title: Text(
//                 'Maintenance Settings',
//                 style: GoogleFonts.ubuntu(color: Colors.white),
//               ),
//               onTap: () {
//                 Get.to(() => const MaintananceSettings());
//                 // Handle submenu 1 tap
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 22.0),
//             child: ListTile(
//               leading: SvgPicture.asset('assets/svg/maintanance_dash.svg',
//                   color: Colors.white),
//               title: Text(
//                 'Maintenance Dashboard',
//                 style: GoogleFonts.ubuntu(color: Colors.white),
//               ),
//               onTap: () {
//                 Get.to(() => const MaintenanceDashboardPage());
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
class ExpandItem2 extends StatelessWidget {
  // List<String> title;
  String MainTitle;
  Color color;
  SvgPicture ic;
  ExpandItem2(
      {super.key,
      // required this.title,
      required this.color,
      required this.ic,
      required this.MainTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: AppColor.Blue,
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.zero,
          leading: ic,
          title: Text(
            MainTitle,
            style: GoogleFonts.ubuntu(color: Colors.white),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: ListTile(
                leading: SvgPicture.asset('assets/svg/person.svg',
                    color: Colors.white),
                title: Text(
                  'User Management',
                  style: GoogleFonts.ubuntu(color: Colors.white),
                ),
                onTap: () {
                  Get.to(() => const UserManagment());
                  // Handle submenu 1 tap
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 22.0),
            //   child: ListTile(
            //     leading: SvgPicture.asset('assets/svg/notify.svg',
            //         color: Colors.white),
            //     title: Text(
            //       'Notification Settings',
            //       style: GoogleFonts.ubuntu(color: Colors.white),
            //     ),
            //     onTap: () {
            //       Get.to(() => const NotificationSettings());
            //       // Handle submenu 2 tap
            //     },
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 22.0),
            //   child: ListTile(
            //     leading: SvgPicture.asset('assets/svg/user_action_log.svg',
            //         color: Colors.white),
            //     title: Text(
            //       'User Action Log',
            //       style: GoogleFonts.ubuntu(color: Colors.white),
            //     ),
            //     onTap: () {
            //       Get.to(() => const MyDataTablePage());
            //       // Handle submenu 2 tap
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
