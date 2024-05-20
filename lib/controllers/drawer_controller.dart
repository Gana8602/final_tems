import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Tems/pages/Drawer_right/drawer_right.dart';

import '../pages/Drawer_right/add_station.dart';
import '../utils/string.dart';

class DataQADra extends StatefulWidget {
  const DataQADra({
    super.key,
  });

  @override
  State<DataQADra> createState() => _DataQADraState();
}

class _DataQADraState extends State<DataQADra> {
  final DrawerStrings _string = Get.put(DrawerStrings());
  @override
  Widget build(BuildContext context) {
    if (_string.drawervalue == 'addStation') {
      return const AddStation();
    } else if (_string.drawervalue == 'main') {
      return const DrawerRight();
      // } else if (_string.drawervalue == 'reportFilter') {
      //   return FilterDrawer();
      // } else if (_string.drawervalue == 'SataticFilter') {
      //   return StaticticDrawerFilter();
    }
    return Container();
  }
}
