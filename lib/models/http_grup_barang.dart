// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpGrupBarang {
  bool status;

  HttpGrupBarang({this.status});

  static Future<HttpGrupBarang> saveGrupBarangHeader(
      String namaGrupBarang, String Keterangan) async {
    Uri urlApi = Uri.parse("http://localhost:3000/inventory/grupbrg/save");
    var hasilResponse = await http.post(urlApi, body: {
      "NAMA_GRUP": namaGrupBarang,
      "KETERANGAN": Keterangan,
    });

    var data = json.decode(hasilResponse.body);
    return HttpGrupBarang(
      status: data["status"],
    );
  }

  static Future<HttpGrupBarang> saveGrupBarangDetail(
      String idGrupHeader, String idBarang, String quantity) async {
    Uri urlApi =
        Uri.parse("http://localhost:3000/inventory/grupbrg/saveDetail");
    var hasilResponse = await http.post(urlApi, body: {
      "KDXX_GRUP": idGrupHeader,
      "KDXX_BRGX": idBarang,
      "QTYX_BRGX": quantity,
    });

    var data = json.decode(hasilResponse.body);
    return HttpGrupBarang(
      status: data["status"],
    );
  }

  static Future<HttpGrupBarang> deleteGrupBarang(String idGrup) async {
    Uri urlApi =
        Uri.parse("http://localhost:3000/inventory/grupbrg/deleteGrupBarang");
    var hasilResponse = await http.post(urlApi, body: {
      "KDXX_GRUP": idGrup,
    });

    var data = json.decode(hasilResponse.body);
    return HttpGrupBarang(
      status: data["status"],
    );
  }

  static Future<HttpGrupBarang> deleteGrupBarangDetail(
      String idGrup, String idBarang) async {
    Uri urlApi = Uri.parse(
        "http://localhost:3000/inventory/grupbrg/deleteGrupBarangDetail");
    var hasilResponse = await http.post(urlApi, body: {
      "KDXX_GRUP": idGrup,
      "KDXX_BRGX": idBarang,
    });

    var data = json.decode(hasilResponse.body);
    return HttpGrupBarang(
      status: data["status"],
    );
  }
}
