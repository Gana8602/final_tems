// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:route_between_two_points/pages/widget/bar.dart';
import 'package:route_between_two_points/pages/Drawer_right/drawer_right.dart';
import 'package:route_between_two_points/pages/widget/float_Button.dart';
import 'package:route_between_two_points/pages/widget/map.dart';
import '../bool/services/sensors_name_service.dart';
import 'widget/drawer_left/drawer_left.dart';
import 'widget/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MapStyle controller = Get.put(MapStyle());
  DateTime time = DateTime.parse('2024-05-03 18:40:48.435635');
  @override
  void initState() {
    super.initState();
    SensorsNames().SensorName();
    Future.delayed(const Duration(milliseconds: 300), timer);
  }

  Future<void> timer() async {
    if (time.hour >= 6) {
      controller.changeStyle('white');
    } else if (time.hour < 18) {
      controller.changeStyle('dark');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await SystemChannels.platform
            .invokeMethod('SystemNavigator.pop');
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: Head(context),
        drawer: const Drawerleft(),
        body: _buildMapView(),
        endDrawer: const DrawerRight(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: const FloatButton(),
      ),
    );
  }

  Widget _buildMapView() {
    return GetBuilder<MapStyle>(
      init: MapStyle(), // Initialize MapStyle controller
      builder: (controller) {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const MapView();
      },
    );
  }

  // Widget _DetailSheet(){
  //   return BottomSheet(onClosing: onClosing, builder: builder)
  // }
}