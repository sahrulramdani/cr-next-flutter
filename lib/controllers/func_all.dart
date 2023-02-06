// ignore_for_file: unnecessary_new
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
  String ref = tahun.substring(3, 4).toString();
  String name = nama.substring(0, 3).toString().toUpperCase();
  String tanggal = tgl.replaceAll('-', '').toString().substring(2, 8);
  String id = '0$ref$name${tanggal}0001';

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
