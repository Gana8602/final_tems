import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Tems/pages/widget/style.dart';

import '../../utils/style.dart';

class DrawerRight extends StatelessWidget {
  const DrawerRight({super.key});

  @override
  Widget build(BuildContext context) {
    final MapStyle controller = Get.find<MapStyle>();
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Theme Settings'),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            const Divider(),
            SizedBox(
              height: 120,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Map Layers'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.changeStyle('dark');
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                width: 70,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/image/darkmap.png'),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Text(
                              'Dark Map',
                              style: GoogleFonts.ubuntu(color: AppColor.Blue),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                _changeStyle(context, 'white');
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                width: 70,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/image/whitemap.png'),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Text(
                              'White Map',
                              style: GoogleFonts.ubuntu(color: AppColor.Blue),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                _changeStyle(context, 'standard');
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                width: 70,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/image/satellitemap.png'),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Text(
                              'Satellite',
                              style: GoogleFonts.ubuntu(color: AppColor.Blue),
                            )
                          ],
                        ),
                      ],
                    )
                  ]),
            ),
            // SizedBox(
            //   height: 200,
            //   child: Center(
            //     child: Column(
            //       children: [
            //         ElevatedButton(
            //             onPressed: () {
            //               StyleController().ChangeColor('red');
            //               Get.back();
            //             },
            //             child: Text('Red')),
            //         ElevatedButton(
            //             onPressed: () {
            //               StyleController().ChangeColor('green');
            //             },
            //             child: Text('green')),
            //         ElevatedButton(
            //             onPressed: () {
            //               StyleController().ChangeColor('yellow');
            //             },
            //             child: Text('yellow')),
            //         ElevatedButton(
            //             onPressed: () {
            //               StyleController().ChangeColor('blue');
            //             },
            //             child: Text('blue')),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void _changeStyle(BuildContext context, String color) {
    final controller = Get.find<MapStyle>();
    controller.changeStyle(color);
  }
}
