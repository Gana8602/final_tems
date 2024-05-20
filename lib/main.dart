// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:Tems/pages/auth/Login_page.dart';

import 'pages/widget/splash_anim.dart';
import 'utils/style.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColor.Blue, // Change the color as needed
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OKToast(
      child: GetMaterialApp(
        home: Splash(),
        // initialRoute: AuthPageRoute,
        debugShowCheckedModeBanner: false,
        // getPages: [
        //   GetPage(name: HomePageRoute, page: () => const HomePage()),
        //   GetPage(name: AuthPageRoute, page: () => const LoginPage()),
        // ],
      ),
    );
  }
}

class initial extends GetxController {}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Nav();
  }

  Future<void> Nav() async {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginPage(),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: <Widget>[
          Center(
            child: WidgetRingAnimator(
              size: 150,
              ringIcons: const [
                'assets/link.png',
                'assets/water.png',
                'assets/cruise.png',
                'assets/fish.png',
                'assets/boat.png',
              ],
              ringIconsSize: 3,
              ringIconsColor: Colors.transparent,
              ringAnimation: Curves.linear,
              ringColor: Colors.blue,
              reverse: false,
              ringAnimationInSeconds: 10,
              child: AvatarGlow(
                glowColor: Colors.lightBlue,
                // endRadius: 200.0,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                animate: true,
                glowShape: BoxShape.circle,
                // showTwoGlows: true,
                startDelay: const Duration(milliseconds: 100),
                child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: Container(
                    height: 110,
                    width: 110,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(55)),
                        image: DecorationImage(
                            image: AssetImage('assets/image/logooo.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text('By'),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                'T R I D E L',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
              SizedBox(
                height: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}
