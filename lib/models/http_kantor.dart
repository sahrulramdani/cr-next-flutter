import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpKantor {
  bool status;

  HttpKantor({this.status});

  static Future<HttpKantor> saveKantor(
    String jenisKantor,
    String namaKantor,
    String alamat,
    String telp,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/hr/kantor/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "JENS_KNTR": jenisKantor,
        "NAMA_KNTR": namaKantor,
        "ALMT_KNTR": alamat,
        "TELP_KNTR": telp,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpKantor(
      status: data["status"],
    );
  }

  static Future<HttpKantor> updateKantor(
    String idKantor,
    String jenisKantor,
    String namaKantor,
    String alamat,
    String telp,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/hr/kantor/update");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_KNTR": idKantor,
        "JENS_KNTR": jenisKantor,
        "NAMA_KNTR": namaKantor,
        "ALMT_KNTR": alamat,
        "TELP_KNTR": telp,
      },
    );
    var data = json.decode(hasilResponse.body);
    return HttpKantor(
      status: data["status"],
    );
  }

  static Future<HttpKantor> deleteKantor(String idKantor) async {
    Uri urlApi = Uri.parse("$urlAddress/hr/kantor/delete");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_KNTR": idKantor,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpKantor(
      status: data["status"],
    );
  }
}
