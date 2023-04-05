import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpAccount {
  bool status;

  HttpAccount({this.status});

  static Future<HttpAccount> saveAccount(
    String idAccount,
    String namaAccount,
    String indukAccount,
    String kategoriAccount,
    String mataUang,
    String budget,
    String debetKredit,
    String tipeAccount,
    String dk,
    String level,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/master-account/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_COAX": idAccount,
        "DESKRIPSI": namaAccount,
        "KDXX_PARENT": indukAccount,
        "KATX_COAX": kategoriAccount,
        "MATA_UANG": mataUang,
        "BUDGET": budget,
        "STAS_DKXX": debetKredit,
        "TYPE_COAX": tipeAccount,
        "COAX_DKXX": dk,
        "COAX_LVEL": level,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpAccount(
      status: data["status"],
    );
  }

  static Future<HttpAccount> updateAccount(
    String idAccount,
    String namaAccount,
    String indukAccount,
    String kategoriAccount,
    String mataUang,
    String budget,
    String debetKredit,
    String tipeAccount,
    String dk,
    String level,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/master-account/update");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_COAX": idAccount,
        "DESKRIPSI": namaAccount,
        "KDXX_PARENT": indukAccount,
        "KATX_COAX": kategoriAccount,
        "MATA_UANG": mataUang,
        "BUDGET": budget,
        "STAS_DKXX": debetKredit,
        "TYPE_COAX": tipeAccount,
        "COAX_DKXX": dk,
        "COAX_LVEL": level,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpAccount(
      status: data["status"],
    );
  }

  static Future<HttpAccount> deleteAccount(String idAccount) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/master-account/delete");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_COAX": idAccount,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpAccount(
      status: data["status"],
    );
  }
}
