import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpController {
  bool status;

  HttpController({this.status});

  static Future<HttpController> saveAgency(
    String nik,
    String namaAgen,
    String jenisKelamin,
    String tempatLahir,
    String tanggalLahir,
    String alamat,
    String namaKantor,
    String provinsi,
    String kota,
    String kecamatan,
    String kelurahan,
    String kodePos,
    String leader,
    String feeLevel,
    String namaAyah,
    String noTelp,
    String menikah,
    String pendidikan,
    String pekerjaan,
    String fotoAgen,
    String fotoKtpAgen,
    String noPaspor,
    String dikeluarkanDi,
    String tglKeluar,
    String tglExpire,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/agency/save");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "KDXX_AGEN": fncGetIDAgensi(namaAgen, tanggalLahir),
        "NOXX_IDNT": nik,
        "NAMA_LGKP": namaAgen,
        "JENS_KLMN": jenisKelamin,
        "TMPT_LHIR": tempatLahir,
        "TGLX_LHIR": tanggalLahir,
        "ALAMAT": alamat,
        "KDXX_KNTR": namaKantor,
        "KDXX_PROV": provinsi,
        "KDXX_KOTA": kota,
        "KDXX_KECX": kecamatan,
        "KDXX_KELX": kelurahan,
        "KDXX_POSX": kodePos,
        "KDXX_LEAD": leader ?? '',
        "FEEX_LVEL": feeLevel,
        "NAMA_AYAH": namaAyah,
        "NOXX_TELP": noTelp,
        "JENS_MNKH": menikah,
        "JENS_PEND": pendidikan,
        "JENS_PKRJ": pekerjaan,
        "FOTO_AGEN": fotoAgen,
        "FOTO_KTPX": fotoKtpAgen,
        "NOXX_PSPR": noPaspor ?? '',
        "KLUR_DIXX": dikeluarkanDi ?? '',
        "TGLX_KLUR": tglKeluar ?? '',
        "TGLX_EXPX": tglExpire ?? '',
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpController(
      status: data["status"],
    );
  }

  static Future<HttpController> updateAgencyBank(
    String kodeMarketing,
    String kodeBank,
    String nomorRekening,
    String namaRekening,
    String statusRekening,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/agency/bank/save");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "KDXX_MRKT": kodeMarketing,
        "NOXX_REKX": nomorRekening,
        "NAMA_REKX": namaRekening,
        "KDXX_BANK": kodeBank,
        "STAS_REKX": statusRekening,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpController(
      status: data["status"],
    );
  }

  static Future<HttpController> updateAgency(
    String id,
    String nik,
    String namaAgen,
    String jenisKelamin,
    String tempatLahir,
    String tanggalLahir,
    String alamat,
    String namaKantor,
    String provinsi,
    String kota,
    String kecamatan,
    String kelurahan,
    String kodePos,
    String leader,
    String feeLevel,
    String namaAyah,
    String noTelp,
    String menikah,
    String pendidikan,
    String pekerjaan,
    String fotoAgen,
    String fotoKtpAgen,
    String noPaspor,
    String dikeluarkanDi,
    String tglKeluar,
    String tglExpire,
    String status,
    String fotoLamaAgen,
    String fotoLamaKtpAgen,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/agency/update");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "KDXX_AGEN": id,
        "NOXX_IDNT": nik,
        "NAMA_LGKP": namaAgen,
        "JENS_KLMN": jenisKelamin,
        "TMPT_LHIR": tempatLahir,
        "TGLX_LHIR": tanggalLahir,
        "ALAMAT": alamat,
        "KDXX_KNTR": namaKantor,
        "KDXX_PROV": provinsi,
        "KDXX_KOTA": kota,
        "KDXX_KECX": kecamatan,
        "KDXX_KELX": kelurahan,
        "KDXX_POSX": kodePos,
        "KDXX_LEAD": leader ?? '',
        "FEEX_LVEL": feeLevel,
        "NAMA_AYAH": namaAyah,
        "NOXX_TELP": noTelp,
        "JENS_MNKH": menikah,
        "JENS_PEND": pendidikan,
        "JENS_PKRJ": pekerjaan,
        "FOTO_AGEN": fotoAgen,
        "FOTO_KTPX": fotoKtpAgen,
        "NOXX_PSPR": noPaspor ?? '',
        "KLUR_DIXX": dikeluarkanDi ?? '',
        "TGLX_KLUR": tglKeluar ?? '',
        "TGLX_EXPX": tglExpire ?? '',
        "STAS_AGEN": status,
        "FOTO_LAMA": fotoLamaAgen,
        "KTPX_LAMA": fotoLamaKtpAgen,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpController(
      status: data["status"],
    );
  }

  static Future<HttpController> deleteAgency(String kodeAgen) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/agency/delete");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "KDXX_AGEN": kodeAgen,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpController(
      status: data["status"],
    );
  }

  // JAMAAH
  static Future<HttpController> saveJamaah(
    String nik,
    String namaJamaah,
    String jenisKelamin,
    String tempatLahir,
    String tanggalLahir,
    String alamat,
    String provinsi,
    String kota,
    String kecamatan,
    String kelurahan,
    String kodePos,
    String namaAyah,
    String noTelp,
    String menikah,
    String pendidikan,
    String pekerjaan,
    String fotoJamaah,
    String fotoKtpJamaah,
    String noPaspor,
    String dikeluarkanDi,
    String tglKeluar,
    String tglExpire,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/jamaah/jamaah/save");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "NOXX_IDNT": nik,
        "NAMA_LGKP": namaJamaah,
        "JENS_KLMN": jenisKelamin,
        "TMPT_LHIR": tempatLahir,
        "TGLX_LHIR": tanggalLahir,
        "ALAMAT": alamat,
        "KDXX_PROV": provinsi,
        "KDXX_KOTA": kota,
        "KDXX_KECX": kecamatan,
        "KDXX_KELX": kelurahan,
        "KDXX_POSX": kodePos,
        "NAMA_AYAH": namaAyah,
        "NOXX_TELP": noTelp,
        "JENS_MNKH": menikah,
        "JENS_PEND": pendidikan,
        "JENS_PKRJ": pekerjaan,
        "FOTO_JMAH": fotoJamaah,
        "FOTO_KTPX": fotoKtpJamaah,
        "NOXX_PSPR": noPaspor ?? '',
        "KLUR_DIXX": dikeluarkanDi ?? '',
        "TGLX_KLUR": tglKeluar ?? '',
        "TGLX_EXPX": tglExpire ?? '',
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpController(
      status: data["status"],
    );
  }
}
