// ignore: unused_import
import 'package:TPMDriver/src/response/login.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
import 'package:TPMDriver/helper/paths.dart';
// ignore: unused_import
import 'package:TPMDriver/helper/rijndael.dart';
import 'dart:convert';

class UserApi {
  Client _client = new Client();
  Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  // ignore: missing_return
  Future<LoginResponse> login(String id, String pw) async {
    final response = await _client.post("${Paths.BASEURLTPM}${Paths.LOGINTPM}",
        body: {"username": "$id", "password": "$pw"});
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      if (res['status'] != false) {
        print(res['status']);
        LoginResponse loginResponse =
            LoginResponse.fromJson(json.decode(response.body));
        return loginResponse;
      } else {
        Future.error("${res['data']['message']}");
      }
    } else {
      Future.error("Yah, Internet kamu error!");
    }
  }
}
