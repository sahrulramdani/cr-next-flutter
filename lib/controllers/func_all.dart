// ignore_for_file: unnecessary_new, unused_local_variable
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';

fncGetID(nama, tgl) {
  String name = nama.substring(0, 3).toString().toUpperCase();
  String tanggal = tgl.replaceAll('-', '').toString().substring(2, 8);
  String id = '01$name${tanggal}0001';

  return id;
}

fncGetIDAgensi(nama, tgl) {
  String tahun = new DateTime.now().year.toString();
  String ref = tahun.substring(2, 4).toString();
  String name = nama.substring(0, 3).toString().toUpperCase();
  String tanggal = tgl.replaceAll('-', '').toString().substring(2, 8);
  String id = '$ref$name${tanggal}0001';

  return id;
}

fncGetIDJadwal(tgl) {
  String tanggal = tgl.replaceAll('-', '').toString();
  String id = 'J${tanggal}001';

  return id;
}

fncGetTanggal(tgl) {
  String tanggalAll = tgl.replaceAll('-', '');
  String tanggal = tanggalAll.substring(0, 2);
  String bulan = tanggalAll.substring(2, 4);
  String tahun = tanggalAll.substring(4, 8);
  String namaBulan;

  if (bulan == '01') {
    namaBulan = 'Januari';
  } else if (bulan == '02') {
    namaBulan = 'Februari';
  } else if (bulan == '03') {
    namaBulan = 'Maret';
  } else if (bulan == '04') {
    namaBulan = 'April';
  } else if (bulan == '05') {
    namaBulan = 'Mei';
  } else if (bulan == '06') {
    namaBulan = 'Juni';
  } else if (bulan == '07') {
    namaBulan = 'Juli';
  } else if (bulan == '08') {
    namaBulan = 'Agustus';
  } else if (bulan == '09') {
    namaBulan = 'September';
  } else if (bulan == '10') {
    namaBulan = 'Oktober';
  } else if (bulan == '11') {
    namaBulan = 'November';
  } else if (bulan == '12') {
    namaBulan = 'Desember';
  }

  return '$tanggal $namaBulan $tahun';
}

fncRandomId(int length) {
  const characters =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
}

fncTanggal(String tgl) {
  String tanggalAll = tgl.replaceAll('-', '');
  String tanggal = tanggalAll.substring(0, 2);
  String bulan = tanggalAll.substring(2, 4);
  String tahun = tanggalAll.substring(4, 8);
  String date = "$tahun-$bulan-$tanggal";

  return date;
}

fncTukarTanggal(String tgl) {
  String tanggalAll = tgl.replaceAll('-', '');
  String tahun = tanggalAll.substring(0, 4);
  String bulan = tanggalAll.substring(4, 6);
  String tanggal = tanggalAll.substring(6, 8);
  String date = "$tanggal-$bulan-$tahun";

  return date;
}

fncTelp(String telp) {
  String reguler = telp.substring(1);
  String noAkhir = '62$reguler';

  return noAkhir;
}

fncJatuhTempo(tgl) {
  String tanggalAll = tgl.replaceAll('-', '');
  String tanggal = tanggalAll.substring(0, 2);
  String bulan = tanggalAll.substring(2, 4);
  String tahun = tanggalAll.substring(4, 8);

  int tempoHari = 30;
  final tanggalDapat = DateTime.parse('$tahun-$bulan-$tanggal');
  final jatuhTempo = tanggalDapat.subtract(Duration(days: tempoHari));

  return jatuhTempo;
}

fncInfoPeriode(tglAwal, tglAkhir) {
  String tanggalAwalAll = tglAwal.replaceAll('-', '');
  String tanggalAwal = tanggalAwalAll.substring(0, 2);
  String bulanAwal = tanggalAwalAll.substring(2, 4);
  String tahunAwal = tanggalAwalAll.substring(4, 8);
  String namaBulanAwal;

  String tanggalAkhirAll = tglAkhir.replaceAll('-', '');
  String tanggalAkhir = tanggalAkhirAll.substring(0, 2);
  String bulanAkhir = tanggalAkhirAll.substring(2, 4);
  String tahunAkhir = tanggalAkhirAll.substring(4, 8);
  String namaBulanAkhir;

  if (bulanAwal == '01') {
    namaBulanAwal = 'JAN';
  } else if (bulanAwal == '02') {
    namaBulanAwal = 'FEB';
  } else if (bulanAwal == '03') {
    namaBulanAwal = 'MAR';
  } else if (bulanAwal == '04') {
    namaBulanAwal = 'APR';
  } else if (bulanAwal == '05') {
    namaBulanAwal = 'MEI';
  } else if (bulanAwal == '06') {
    namaBulanAwal = 'JUN';
  } else if (bulanAwal == '07') {
    namaBulanAwal = 'JUL';
  } else if (bulanAwal == '08') {
    namaBulanAwal = 'AGU';
  } else if (bulanAwal == '09') {
    namaBulanAwal = 'SEP';
  } else if (bulanAwal == '10') {
    namaBulanAwal = 'OKT';
  } else if (bulanAwal == '11') {
    namaBulanAwal = 'NOV';
  } else if (bulanAwal == '12') {
    namaBulanAwal = 'DES';
  }

  if (bulanAkhir == '01') {
    namaBulanAkhir = 'JAN';
  } else if (bulanAkhir == '02') {
    namaBulanAkhir = 'FEB';
  } else if (bulanAkhir == '03') {
    namaBulanAkhir = 'MAR';
  } else if (bulanAkhir == '04') {
    namaBulanAkhir = 'APR';
  } else if (bulanAkhir == '05') {
    namaBulanAkhir = 'MEI';
  } else if (bulanAkhir == '06') {
    namaBulanAkhir = 'JUN';
  } else if (bulanAkhir == '07') {
    namaBulanAkhir = 'JUL';
  } else if (bulanAkhir == '08') {
    namaBulanAkhir = 'AGU';
  } else if (bulanAkhir == '09') {
    namaBulanAkhir = 'SEP';
  } else if (bulanAkhir == '10') {
    namaBulanAkhir = 'OKT';
  } else if (bulanAkhir == '11') {
    namaBulanAkhir = 'NOV';
  } else if (bulanAkhir == '12') {
    namaBulanAkhir = 'DES';
  }

  var hasil =
      '$tanggalAwal $namaBulanAwal ${tahunAwal == tahunAkhir ? '' : tahunAwal} s/d $tanggalAkhir $namaBulanAkhir $tahunAkhir';
  return hasil;
}

fncKeteranganRute(rute1, rute2, rute3, rute4, rute5, rute6) {
  var ketr1 = rute1 != null ? "$rute1 - " : "";
  var ketr2 = rute2 != null ? "$rute2 - " : "";
  var ketr3 = rute3 != null ? "$rute3" : "";
  var ketr4 = rute4 != null ? "$rute4 - " : "";
  var ketr5 = rute5 != null ? "$rute5 - " : "";
  var ketr6 = rute6 != null ? "$rute6" : "";

  var keterangan = "$ketr1$ketr2$ketr3 # $ketr4$ketr5$ketr6";

  return keterangan;
}
