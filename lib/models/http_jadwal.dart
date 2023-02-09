import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpJadwal {
  bool status;

  HttpJadwal({this.status});

  static Future<HttpJadwal> saveJadwal(
    String idpaket,
    String idjenis,
    String tujuan,
    String jumlahHari,
    String pesawat,
    String rute,
    String rute2,
    String rute3,
    String tarif,
    String jumlahSeat,
    String idMataUang,
    String keterangan,
    String tglBerangkat,
    String tglPulang,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/jadwal/save");
    var Tarif = tarif.replaceAll(",", "").toString();
    var hasilResponse = await http.post(urlApi, body: {
      "KDXX_JDWL": fncRandomId(15),
      "NAMA_PKET": idpaket,
      "JENS_PKET": idjenis,
      "TJAN_PKET": tujuan,
      "TGLX_BGKT": fncTanggal(tglBerangkat),
      "TGLX_PLNG": fncTanggal(tglPulang),
      "JMLX_HARI": jumlahHari,
      "JENS_PSWT": pesawat,
      "RUTE_AWAL": rute,
      "RUTE_TRNS": rute2,
      "RUTE_AKHR": rute3,
      "TARIF_PKET": Tarif,
      "JMLX_SEAT": jumlahSeat,
      "MATA_UANG": idMataUang,
      "KETERANGAN": keterangan,
    });
    var data = json.decode(hasilResponse.body);
    return HttpJadwal(
      status: data["status"],
    );
  }

  static Future<HttpJadwal> updateJadwal(
    String idJadwal,
    String idpaket,
    String idjenis,
    String tujuan,
    String jumlahHari,
    String pesawat,
    String rute,
    String rute2,
    String rute3,
    String tarif,
    String jumlahSeat,
    String idMataUang,
    String keterangan,
    String tglBerangkat,
    String tglPulang,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/jadwal/update");
    var Tarif = tarif.replaceAll(",", "").toString();
    var hasilResponse = await http.post(urlApi, body: {
      "IDXX_JDWL": idJadwal,
      "NAMA_PKET": idpaket,
      "JENS_PKET": idjenis,
      "TJAN_PKET": tujuan,
      "TGLX_BGKT": fncTanggal(tglBerangkat),
      "TGLX_PLNG": fncTanggal(tglPulang),
      "JMLX_HARI": jumlahHari,
      "JENS_PSWT": pesawat,
      "RUTE_AWAL": rute,
      "RUTE_TRNS": rute2,
      "RUTE_AKHR": rute3,
      "TARIF_PKET": Tarif,
      "JMLX_SEAT": jumlahSeat,
      "MATA_UANG": idMataUang,
      "KETERANGAN": keterangan,
    });
    var data = json.decode(hasilResponse.body);
    return HttpJadwal(
      status: data["status"],
    );
  }

  static Future<HttpJadwal> deleteJadwal(String idJadwal) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/jadwal/delete");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "IDXX_JDWL": idJadwal,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpJadwal(
      status: data["status"],
    );
  }
}
