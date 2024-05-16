// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:route_between_two_points/bool/services/logout_service.dart';
import 'package:route_between_two_points/config/data.dart';
import 'package:route_between_two_points/pages/home.dart';
import 'package:route_between_two_points/pages/reports/report.dart';
import 'package:route_between_two_points/pages/widget/drawer_left/widget/item.dart';
import 'package:route_between_two_points/pages/widget/drawer_left/widget/notify.dart';

import '../../../utils/style.dart';
import '../../Statistics/statistics.dart';
import '../../dashboard/dashboard.dart';

class Drawerleft extends StatelessWidget {
  const Drawerleft({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.Blue,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // physics: NeverScrollableScrollPhysics(),
          // padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              children: [
                Text(
                  'T E M S',
                  style: GoogleFonts.ubuntu(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    final RenderBox overlay = Overlay.of(context)
                        .context
                        .findRenderObject() as RenderBox;
                    final RelativeRect position = RelativeRect.fromRect(
                      Rect.fromPoints(
                        Offset.zero,
                        overlay.size.bottomRight(Offset.zero),
                      ),
                      Offset.zero & overlay.size,
                    );

                    showMenu(
                      context: context,
                      position: position,
                      items: [
                        PopupMenuItem(
                          child: ListTile(
                            title: const Text('Powered by'),
                            subtitle: const Text('Tridel Technologies'),
                            trailing: const Icon(Icons.delete),
                            leading: Image.asset('assets/image/logo2.png'),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            title: TextButton(
                                onPressed: () {
                                  LogoutService().logout();
                                },
                                child: Text(
                                  'Log out',
                                  style: GoogleFonts.ubuntu(color: Colors.red),
                                )),
                          ),
                        ),
                      ],
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/image/admin.png'),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        'Admin',
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'ADMINISTRATOR',
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // const NotificationWidget(),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  DrawerItem(
                    key: UniqueKey(),
                    ontap: () {
                      Get.to(() => const HomePage());
                    },

                    // Get.back();

                    title: 'Home',
                    color: Colors.white,
                    ic: SvgPicture.asset(
                      'assets/svg/icons8-home.svg',
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                  ),
                  DrawerItem(
                    ontap: () {
                      // Get.toNamed('/dash');
                      Get.to(() => const DashBoard());
                    },
                    title: 'dashboard',
                    color: Colors.white,
                    ic: SvgPicture.asset(
                      'assets/svg/dash.svg',
                      color: Colors.white,
                    ),
                  ),
                  DrawerItem(
                    ontap: () {
                      Get.to(() => const ExpandableTableExample());
                    },
                    title: 'Reports',
                    color: Colors.white,
                    ic: SvgPicture.asset(
                      'assets/svg/report.svg',
                      color: Colors.white,
                    ),
                  ),
                  DrawerItem(
                    ontap: () {
                      Get.to(() => const StatisticsPage());
                    },
                    title: 'Statistics',
                    color: Colors.white,
                    ic: SvgPicture.asset(
                      'assets/svg/stat.svg',
                      color: Colors.white,
                    ),
                  ),
                  // ExpandItem1(
                  //     color: Colors.white,
                  //     ic: SvgPicture.asset(
                  //       'assets/svg/s_master_main.svg',
                  //       color: Colors.white,
                  //     ),
                  //     MainTitle: 'Station Master'),
                  if (Data.role == "ROLE_ADMIN")
                    ExpandItem2(
                        color: Colors.white,
                        ic: SvgPicture.asset(
                          'assets/svg/admin_setting.svg',
                          height: 30,
                          width: 30,
                          color: Colors.white,
                        ),
                        MainTitle: 'Admin Center'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
