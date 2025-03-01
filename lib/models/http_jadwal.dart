// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpJadwal {
  bool status;
  String foto;

  HttpJadwal({this.status, this.foto});

  static Future<HttpJadwal> saveFotoJadwal(
    String tglBerangkat,
    String fotoJadwal,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/jadwal/save-foto");

    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "TGLX_BGKT": tglBerangkat,
        "FOTO_PKET": fotoJadwal,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpJadwal(
      status: data["status"],
      foto: data["foto"],
    );
  }

  static Future<HttpJadwal> saveJadwal(
    String idpaket,
    String idjenis,
    String tujuan,
    String idhotelMek,
    String idhotelMad,
    String idhotelJed,
    String idhotelTra,
    String jumlahHari,
    String pesawatBrgkt,
    String pesawatPulang,
    String rute,
    String rute2,
    String rute3,
    String ruteAwalPulg,
    String ruteTransitPlng,
    String ruteAkhirPlng,
    String tarif,
    String jumlahSeat,
    String idMataUang,
    String keterangan,
    String tglBerangkat,
    String tglPulang,
    String ketRute,
    String foto,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/jadwal/save");
    var Tarif = tarif.replaceAll(",", "").toString();
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "NAMA_PKET": idpaket,
        "JENS_PKET": idjenis,
        "TJAN_PKET": tujuan,
        "HOTL_MEKX": idhotelMek,
        "HOTL_MADX": idhotelMad,
        "HOTL_JEDX": idhotelJed,
        "HOTL_TRAX": idhotelTra,
        "TGLX_BGKT": fncTanggal(tglBerangkat),
        "TGLX_PLNG": fncTanggal(tglPulang),
        "JMLX_HARI": jumlahHari,
        "PSWT_BGKT": pesawatBrgkt,
        "PSWT_PLNG": pesawatPulang,
        "RUTE_AWAL_BRKT": rute,
        "RUTE_TRNS_BRKT": rute2,
        "RUTE_AKHR_BRKT": rute3,
        "RUTE_AWAL_PLNG": ruteAwalPulg,
        "RUTE_TRNS_PLNG": ruteTransitPlng,
        "RUTE_AKHR_PLNG": ruteAkhirPlng,
        "TARIF_PKET": Tarif,
        "JMLX_SEAT": jumlahSeat,
        "MATA_UANG": idMataUang,
        "KETERANGAN": keterangan,
        "KETX_RUTE": ketRute,
        "FOTO_PKET": foto,
      },
    );
    var data = json.decode(hasilResponse.body);
    return HttpJadwal(
      status: data["status"],
    );
  }

  static Future<HttpJadwal> updateFotoJadwal(
    String tglBerangkat,
    String fotoJadwal,
    String fotoLamaAgen,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/jadwal/update-foto");

    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "TGLX_BGKT": tglBerangkat,
        "FOTO_PKET": fotoJadwal,
        "FOTO_LAMA": fotoLamaAgen,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpJadwal(
      status: data["status"],
      foto: data["foto"],
    );
  }

  static Future<HttpJadwal> updateJadwal(
    String idJadwal,
    String idpaket,
    String idjenis,
    String tujuan,
    String idhotelMek,
    String idhotelMad,
    String idhotelJed,
    String idhotelTra,
    String jumlahHari,
    String pesawatBrgkt,
    String pesawatPulang,
    String rute,
    String rute2,
    String rute3,
    String ruteAwalPlng,
    String ruteTransitPlng,
    String ruteAkhirPlng,
    String tarif,
    String jumlahSeat,
    String idMataUang,
    String keterangan,
    String tglBerangkat,
    String tglPulang,
    String ketRute,
    String foto,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/jadwal/update");
    var Tarif = tarif.replaceAll(",", "").toString();
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "IDXX_JDWL": idJadwal,
        "NAMA_PKET": idpaket,
        "JENS_PKET": idjenis,
        "TJAN_PKET": tujuan,
        "HOTL_MEKX": idhotelMek,
        "HOTL_MADX": idhotelMad,
        "HOTL_JEDX": idhotelJed,
        "HOTL_TRAX": idhotelTra,
        "TGLX_BGKT": fncTanggal(tglBerangkat),
        "TGLX_PLNG": fncTanggal(tglPulang),
        "JMLX_HARI": jumlahHari,
        "PSWT_BGKT": pesawatBrgkt,
        "PSWT_PLNG": pesawatPulang,
        "RUTE_AWAL_BRKT": rute,
        "RUTE_TRNS_BRKT": rute2,
        "RUTE_AKHR_BRKT": rute3,
        "RUTE_AWAL_PLNG": ruteAwalPlng,
        "RUTE_TRNS_PLNG": ruteTransitPlng,
        "RUTE_AKHR_PLNG": ruteAkhirPlng,
        "TARIF_PKET": Tarif,
        "JMLX_SEAT": jumlahSeat,
        "MATA_UANG": idMataUang,
        "KETERANGAN": keterangan,
        "KETX_RUTE": ketRute,
        "FOTO_PKET": foto,
      },
    );
    var data = json.decode(hasilResponse.body);
    return HttpJadwal(
      status: data["status"],
    );
  }

  static Future<HttpJadwal> deleteJadwal(String idJadwal) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/jadwal/delete");

    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
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
