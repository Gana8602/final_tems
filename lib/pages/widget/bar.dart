// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/looogo.png'),
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
          ],
          systemOverlayStyle: SystemUiOverlayStyle.light),
    );
