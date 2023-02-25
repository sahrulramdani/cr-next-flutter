import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpAgency {
  bool status;
  String foto;
  String ktpx;

  HttpAgency({this.status, this.foto, this.ktpx});

  static Future<HttpAgency> saveFotoAgency(
    String nik,
    String fotoAgen,
    String fotoKtpAgen,
    String fotoDriJmah,
    String ktpDriJmah,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/agency/save-foto");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "NOXX_IDNT": nik,
        "FOTO_AGEN": fotoAgen,
        "FOTO_KTPX": fotoKtpAgen,
        "FOTO_LMAX": fotoDriJmah,
        "KTPX_LMAX": ktpDriJmah,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpAgency(
      status: data["status"],
      foto: data["foto"],
      ktpx: data["ktpx"],
    );
  }

  static Future<HttpAgency> saveAgency(
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
    String katMarketing,
    String namaPenanggungJawab,
    String telpPenanggungJawab,
    String namaAyah,
    String noTelp,
    String menikah,
    String pendidikan,
    String pekerjaan,
    String noPaspor,
    String dikeluarkanDi,
    String tglKeluar,
    String tglExpire,
    String namaFoto,
    String namaKtp,
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
        "KATX_MRKT": katMarketing,
        "NAMA_PJWB": namaPenanggungJawab,
        "TELP_PJWB": telpPenanggungJawab ?? '',
        "NAMA_AYAH": namaAyah ?? '-',
        "NOXX_TELP": noTelp ?? '',
        "JENS_MNKH": menikah,
        "JENS_PEND": pendidikan,
        "JENS_PKRJ": pekerjaan,
        "NOXX_PSPR": noPaspor ?? '',
        "KLUR_DIXX": dikeluarkanDi ?? '',
        "TGLX_KLUR": tglKeluar ?? '',
        "TGLX_EXPX": tglExpire ?? '',
        "NAMA_FOTO": namaFoto,
        "NAMA_KTPX": namaKtp,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpAgency(
      status: data["status"],
    );
  }

  static Future<HttpAgency> updateAgencyBank(
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
    return HttpAgency(
      status: data["status"],
    );
  }

  static Future<HttpAgency> updateFotoAgency(
    String nik,
    String fotoAgen,
    String fotoKtpAgen,
    String fotoLamaAgen,
    String fotoLamaKtpAgen,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/agency/update-foto");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "NOXX_IDNT": nik,
        "FOTO_AGEN": fotoAgen,
        "FOTO_KTPX": fotoKtpAgen,
        "FOTO_LAMA": fotoLamaAgen,
        "KTPX_LAMA": fotoLamaKtpAgen,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpAgency(
      status: data["status"],
      foto: data["foto"],
      ktpx: data["ktpx"],
    );
  }

  static Future<HttpAgency> updateAgency(
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
    String katMarketing,
    String namaPenanggungJawab,
    String telpPenanggungJawab,
    String namaAyah,
    String noTelp,
    String menikah,
    String pendidikan,
    String pekerjaan,
    String noPaspor,
    String dikeluarkanDi,
    String tglKeluar,
    String tglExpire,
    String status,
    String namaFoto,
    String namaKtp,
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
        "KATX_MRKT": katMarketing,
        "NAMA_PJWB": namaPenanggungJawab,
        "TELP_PJWB": telpPenanggungJawab ?? '',
        "NAMA_AYAH": namaAyah,
        "NOXX_TELP": noTelp,
        "JENS_MNKH": menikah,
        "JENS_PEND": pendidikan,
        "JENS_PKRJ": pekerjaan,
        "NOXX_PSPR": noPaspor ?? '',
        "KLUR_DIXX": dikeluarkanDi ?? '',
        "TGLX_KLUR": tglKeluar ?? '',
        "TGLX_EXPX": tglExpire ?? '',
        "STAS_AGEN": status,
        "NAMA_FOTO": namaFoto,
        "NAMA_KTPX": namaKtp,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpAgency(
      status: data["status"],
    );
  }

  static Future<HttpAgency> deleteAgency(String kodeAgen) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/agency/delete");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "KDXX_AGEN": kodeAgen,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpAgency(
      status: data["status"],
    );
  }
}
