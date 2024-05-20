// ignore_for_file: file_names

import 'dart:convert';

import 'package:get/get.dart';
import 'package:Tems/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:Tems/config/data.dart';

import '../model/data_model/user_role_model.dart';

class GetRoles extends GetxController {
  Future<void> getRoles() async {
    Data.Roles.clear();
    var response = await http.get(
      Uri.parse('${config.baseUrl}${config.allRole}'),
      headers: {
        'Content-Type': 'application/json',
        'apiKey': config.apiKey,
        'Authorization': config.bearer_token
      },
    );
    if (response.statusCode == 200) {
      // print(response.body);
      List<dynamic> data = jsonDecode(response.body)['roles'];
      List<UserRoles> roles = data.map((e) => UserRoles.fromJson(e)).toList();
      for (var role in roles) {
        final int id = role.id;
        final String name = role.roleName;

        Data.Roles.add({'name': name, 'id': id});
      }
    }
  }
}
