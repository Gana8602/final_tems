import 'package:flutter/material.dart';
import 'package:route_between_two_points/router/routes.dart';

import '../controllers/controller.dart';
import 'router.dart';

Navigator localNavigator() => Navigator(
    key: navigationController.navigatorKey,
    initialRoute: HomePageRoute,
    onGenerateRoute: generateRoute);
