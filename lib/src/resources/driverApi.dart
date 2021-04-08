// ignore: unused_import
import 'package:TPMDriver/src/resources/session.dart';
import 'package:TPMDriver/src/response/driverResponse.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
// ignore: unused_import
import 'package:TPMDriver/helper/paths.dart';
import 'dart:convert';

class DriverActivityApi {
  // ignore: missing_return
  Client _client = new Client();

  // ignore: missing_return
  Future<DriverResponse> getDriver(String idDriver) async {
    final response =
        await _client.get("${Paths.BASEURLTPM}${Paths.DRIVERTPM}?id=$idDriver");
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['status']) {
        DriverResponse driverResponse =
            DriverResponse.fromJson(json.decode(response.body));
        return driverResponse;
      } else {
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet Kamu error!");
    }
  }
}
