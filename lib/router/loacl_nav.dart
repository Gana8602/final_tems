import 'package:flutter/material.dart';
import 'package:Tems/router/routes.dart';

import '../controllers/controller.dart';
import 'router.dart';

Navigator localNavigator() => Navigator(
    key: navigationController.navigatorKey,
    initialRoute: HomePageRoute,
    onGenerateRoute: generateRoute);
