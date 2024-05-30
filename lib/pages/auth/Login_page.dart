// ignore_for_file: file_names, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Tems/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool novisible = true;
  bool checked = false;

  @override
  void initState() {
    super.initState();
    GetData();
  }

  Future<void> GetData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String username = pref.getString('username') ?? "";
    String password = pref.getString('password') ?? "";
    bool check = pref.getBool('logged') ?? false;

    setState(() {
      _username.text = username;
      _pass.text = password;
      checked = check;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/back.jpg'),
                    fit: BoxFit.cover)),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/image/looogo.png'),
                                    fit: BoxFit.fill)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Welcome to \nEnvironmental Data Studio',
                            style: GoogleFonts.ubuntu(
                                color: AppColor.Blue, fontSize: 24),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Please use your credentials to login.',
                            style: GoogleFonts.ubuntu(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey.withOpacity(0.1),
                              ),
                              child: TextField(
                                controller: _username,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon:
                                      const Icon(Icons.person_2_outlined),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      // borderSide: BorderSide.none
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.1))),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: const BorderSide(
                                        color: Colors.lightBlue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey.withOpacity(0.1),
                              ),
                              child: TextField(
                                obscureText: novisible,
                                controller: _pass,
                                decoration: InputDecoration(
                                  suffixIcon: novisible
                                      ? IconButton(
                                          icon:
                                              const Icon(Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              novisible = !novisible;
                                            });
                                          },
                                        )
                                      : IconButton(
                                          icon: const Icon(Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              novisible = !novisible;
                                            });
                                          },
                                        ),
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock_open),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      // borderSide: BorderSide.none
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.1))),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: const BorderSide(
                                        color: Colors.lightBlue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: checked,
                                  onChanged: (value) {
                                    setState(() {
                                      checked = value!;
                                      print(checked);
                                    });
                                  }),
                              Text("Remember Password")
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (checked) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    bool logged =
                                        prefs.getBool('logged') ?? false;
                                    if (!logged) {
                                      prefs.setBool('logged', true);
                                      prefs.setString(
                                          'username', _username.text);
                                      prefs.setString('password', _pass.text);
                                      String? name =
                                          prefs.getString('username');
                                      String? pass =
                                          prefs.getString('password');
                                      print("$name, $pass");
                                    }
                                    // else{
                                    //   prefs.setBool('logged', false);
                                    // }
                                  }
                                  print("vs");
                                  await LoginService()
                                      .login(_username.text, _pass.text);
                                },
                                child: Container(
                                  height: 45,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: AppColor.Blue,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(14)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Log In',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
