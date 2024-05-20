import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:Tems/config/config.dart';
import 'package:Tems/pages/auth/Login_page.dart';

class RefreshToken {
  Future<void> refreshToken() async {
    var response = await http
        .post(Uri.parse('${config.baseUrl}${config.refresh}'), headers: {
      'Content-Type': 'application/json',
      'Authorization': config.bearer_token
    }, body: {
      'refreshToken': config.refresh_token
    });
    if (response.statusCode == 200) {
      Get.to(() => const LoginPage());
    }
  }
}
