// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:Tems/pages/widget/bar.dart';
import 'package:Tems/pages/Drawer_right/drawer_right.dart';
import 'package:Tems/pages/widget/float_Button.dart';
import 'package:Tems/pages/widget/map.dart';
import '../services/sensors_name_service.dart';
import 'widget/drawer_left/drawer_left.dart';
import 'widget/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MapStyle controller = Get.put(MapStyle());
  DateTime time = DateTime.now();
  bool _isDisposed = false;
  @override
  void initState() {
    super.initState();
    SensorsNames().SensorName();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
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
}
