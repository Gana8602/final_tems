// ignore_for_file: empty_catches

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../config/config.dart';
import '../../pages/auth/Login_page.dart';
import '../../pages/widget/toast.dart';

class LogoutService {
  Future<void> logout() async {
    Get.to(() => const LoginPage());
    try {
      var response = await http.post(
        Uri.parse("${config.baseUrl}${config.logout}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': config.bearer_token,
        },
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        toaster().showsToast(data['message'], Colors.green, Colors.white);
      } else {}
    } catch (e) {}
  }
}
