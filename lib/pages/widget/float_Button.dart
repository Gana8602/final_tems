// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';

import '../../utils/string.dart';
import '../../utils/style.dart';

class FloatButton extends StatefulWidget {
  const FloatButton({super.key});

  @override
  State<FloatButton> createState() => _FloatButtonState();
}

class _FloatButtonState extends State<FloatButton> {
  final DrawerStrings _string = Get.put(DrawerStrings());

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        bottom: 20,
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
    ]);
  }
}
