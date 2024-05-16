import 'package:flutter/material.dart';
import 'package:route_between_two_points/pages/auth/Login_page.dart';
import 'package:route_between_two_points/pages/dashboard/dashboard.dart';
import 'package:route_between_two_points/pages/home.dart';
import 'package:route_between_two_points/router/routes.dart';

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
