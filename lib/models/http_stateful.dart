import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;

class HttpStateful {
  bool status;
  String userToken;

  HttpStateful({this.status, this.userToken});

  static Future<HttpStateful> connectAPI(
      String user, String pass, String company) async {
    Uri urlApi = Uri.parse("http://localhost:3000/signin");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "USER_LOGN": user,
        "BUSS_CODE": company,
        "PASS_IDXX": pass,
      },
    );

    var data = json.decode(hasilResponse.body);
    // ignore: avoid_print
    // print(data);
    // print(hasilResponse.body);
    return HttpStateful(
      status: data["status"],
      userToken: data["token"],
    );
  }
}
