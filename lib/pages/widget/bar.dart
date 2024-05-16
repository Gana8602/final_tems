// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/style.dart';

PreferredSize Head(BuildContext context) => PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 15),
      child: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColor.Blue, // Change color as needed
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30), // Adjust radius as needed
              bottomRight: Radius.circular(30), // Adjust radius as needed
            ),
          ),
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 8.0),
          //   child: Container(
          //     height: 60,
          //     width: 70,
          //     decoration: BoxDecoration(
          //         image: DecorationImage(
          //             image: AssetImage('assets/image/logo-1.png'),
          //             fit: BoxFit.cover)),
          //   ),
          // ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 70,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/logo2.png'),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                width: 4,
              ),
              Text('T E M S',
                  style: GoogleFonts.ubuntu(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)
                  // GoogleFonts.ubuntu(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
            ],
          ),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Open the drawer
                  },
                );
              },
            ),
          ]),
    );
