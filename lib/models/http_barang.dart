// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpBarang {
  bool status;

  HttpBarang({this.status});

  static Future<HttpBarang> saveBarang(
    String KDXX_BRGX,
    String NAMA_BRGX,
    String JENS_STUA,
    String STOK_BRGX,
    String HRGX_BELI,
    String HRGX_JUAL,
    String KETERANGAN,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/inventory/barang/save");
    var hargaBeli = HRGX_BELI.replaceAll(",", "").toString();
    var hargaJual = HRGX_JUAL.replaceAll(",", "").toString();
    var hasilResponse = await http.post(urlApi, body: {
      "KDXX_BRGX": KDXX_BRGX,
      "NAMA_BRGX": NAMA_BRGX,
      "JENS_STUA": JENS_STUA,
      "STOK_BRGX": STOK_BRGX,
      "HRGX_BELI": hargaBeli,
      "HRGX_JUAL": hargaJual,
      "KETERANGAN": KETERANGAN,
    });

    var data = json.decode(hasilResponse.body);
    return HttpBarang(
      status: data["status"],
    );
  }

  static Future<HttpBarang> updateBarang(
    String KDXX_BRGX,
    String NAMA_BRGX,
    String JENS_STUA,
    String STOK_BRGX,
    String HRGX_BELI,
    String HRGX_JUAL,
    String STAT_BRG,
    String KETERANGAN,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/inventory/barang/update");
    var hargaBeli = HRGX_BELI.replaceAll(",", "").toString();
    var hargaJual = HRGX_JUAL.replaceAll(",", "").toString();
    var hasilResponse = await http.post(urlApi, body: {
      "KDXX_BRGX": KDXX_BRGX,
      "NAMA_BRGX": NAMA_BRGX,
      "JENS_STUA": JENS_STUA,
      "STOK_BRGX": STOK_BRGX,
      "HRGX_BELI": hargaBeli,
      "HRGX_JUAL": hargaJual,
      "STAT_BRG": STAT_BRG,
      "KETERANGAN": KETERANGAN,
    });

    var data = json.decode(hasilResponse.body);
    return HttpBarang(
      status: data["status"],
    );
  }

  static Future<HttpBarang> updateStokBarang(
      String idBarang, String stokBarang, String stokAwal) async {
    Uri urlApi = Uri.parse("$urlAddress/inventory/barang/updateStok");
    var hasilResponse = await http.post(urlApi, body: {
      "KDXX_BRGX": idBarang,
      "STOK_TABH": stokBarang,
      "STOK_AWAL": stokAwal,
    });

    var data = json.decode(hasilResponse.body);
    return HttpBarang(
      status: data["status"],
    );
  }

  static Future<HttpBarang> deleteBarang(String idBarang) async {
    Uri urlApi = Uri.parse("$urlAddress/inventory/barang/delete");
    var hasilResponse = await http.post(
      urlApi,
      body: {
        "KDXX_BRGX": idBarang,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpBarang(
      status: data["status"],
    );
  }
}
