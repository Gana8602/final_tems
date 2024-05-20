import 'package:flutter/material.dart';
import 'package:Tems/pages/auth/Login_page.dart';
import 'package:Tems/pages/dashboard/dashboard.dart';
import 'package:Tems/pages/home.dart';
import 'package:Tems/router/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePageRoute:
      return getPageRoute(const HomePage());
    case AuthPageRoute:
      return getPageRoute(const LoginPage());
    case DashboardPageRoute:
      return getPageRoute(const DashBoard());
    default:
      return getPageRoute(const HomePage());
  }
}

PageRoute getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
