// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetRingAnimator(
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
                SizedBox(
                  height: 45,
                ),
                Text(
                  "Maharastra Maritime Board",
                  style: GoogleFonts.oswald(
                      color: Colors.brown,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Center(
                child: Text('poweredBy'),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage("assets/image/logo2.png"),
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'Tridel Technologies',
                        style: GoogleFonts.oswald(
                            fontSize: 25,
                            // fontWeight: FontWeight.bold,
                            color: const Color(0xFF000435)),
                      ),
                    ],
                  )),
                ]),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}

// class MovingContainer extends StatefulWidget {
//   @override
//   _MovingContainerState createState() => _MovingContainerState();
// }

// class _MovingContainerState extends State<MovingContainer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: false);

//     _animation = Tween<double>(begin: 1.0, end: -1.0).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 100,
//       color: Colors.lightGreen[200],
//       child: AnimatedBuilder(
//         animation: _animation,
//         builder: (context, child) {
//           return Align(
//             alignment: Alignment(_animation.value, 0.0),
//             child: Container(
//               width: 10,
//               height: 50,
//               color: Colors.red,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
