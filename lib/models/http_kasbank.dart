// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpKasBank {
  bool status;

  HttpKasBank({this.status});

  static Future<HttpKasBank> saveKasBank(
    String KODE_FLNM,
    String KODE_BANK,
    String NAMA_BANK,
    String CHKX_BANK,
    String ACCT_CODE,
    String CURR_MNYX,
    String NOXX_REKX,
    String ALMT_BANK,
    String NOXX_TELP,
    String NOXX_FAXX,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/kas-bank/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KODE_FLNM": KODE_FLNM,
        "KODE_BANK": KODE_BANK,
        "NAMA_BANK": NAMA_BANK,
        "CHKX_BANK": CHKX_BANK,
        "ACCT_CODE": ACCT_CODE,
        "CURR_MNYX": CURR_MNYX,
        "NOXX_REKX": NOXX_REKX,
        "ALMT_BANK": ALMT_BANK,
        "NOXX_TELP": NOXX_TELP,
        "NOXX_FAXX": NOXX_FAXX,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpKasBank(
      status: data["status"],
    );
  }

  static Future<HttpKasBank> updateKasBank(
    String KODE_FLNM,
    String KODE_BANK,
    String NAMA_BANK,
    String CHKX_BANK,
    String ACCT_CODE,
    String CURR_MNYX,
    String NOXX_REKX,
    String ALMT_BANK,
    String NOXX_TELP,
    String NOXX_FAXX,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/kas-bank/update");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KODE_FLNM": KODE_FLNM,
        "KODE_BANK": KODE_BANK,
        "NAMA_BANK": NAMA_BANK,
        "CHKX_BANK": CHKX_BANK,
        "ACCT_CODE": ACCT_CODE,
        "CURR_MNYX": CURR_MNYX,
        "NOXX_REKX": NOXX_REKX,
        "ALMT_BANK": ALMT_BANK,
        "NOXX_TELP": NOXX_TELP,
        "NOXX_FAXX": NOXX_FAXX,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpKasBank(
      status: data["status"],
    );
  }

  static Future<HttpKasBank> deleteKasBank(
    String KODE_FLNM,
    String idKasBank,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/kas-bank/delete");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KODE_FLNM": KODE_FLNM,
        "KODE_BANK": idKasBank,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpKasBank(
      status: data["status"],
    );
  }
}
