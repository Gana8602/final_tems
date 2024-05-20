import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Tems/pages/admin/user_managment/tabs/user_create.dart';

import '../../widget/bar.dart';
import '../../widget/drawer_left/drawer_left.dart';

class UserManagment extends StatefulWidget {
  const UserManagment({super.key});

  @override
  State<UserManagment> createState() => _UserManagmentState();
}

class _UserManagmentState extends State<UserManagment>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Head(context),
      drawer: const Drawerleft(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'User Management',
            style: GoogleFonts.ubuntu(fontSize: 20),
          ),
          const Expanded(
            child: UserCreation(),
          )
        ]),
      ),
    );
  }
}
