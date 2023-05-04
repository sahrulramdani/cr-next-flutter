// ignore: undefined_prefixed_name
// ignore_for_file: unused_import, division_optimization, prefer_const_constructors

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/card_paket.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/not_find_widget.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/responsive_widget.dart';
import 'package:flutter_web_course/pages/overview/widgets/datatable_proyek.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class DetailProductPage extends StatefulWidget {
  String idPaket;
  DetailProductPage({Key key, @required this.idPaket}) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  List<Map<String, dynamic>> listDetJadwal = [];
  String judul;
  String keterangan;
  int harga;
  String mu;
  String pesawatBgkt;
  String pesawatPlng;
  String rute;
  String hotelMek;
  String hotelMad;
  String hotelTra;
  String hotelPls;
  int sisa;

  String foto = "";

  void getAllJadwal() async {
    var response = await http.get(Uri.parse(
        "$urlAddress/marketing/jadwal/getDetailDash/${widget.idPaket}"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listDetJadwal = data;
      judul = data[0]['jenisPaket'];
      keterangan = data[0]['KETERANGAN'];
      harga = data[0]['TARIF_PKET'];
      mu = data[0]['MATA_UANG'];
      pesawatBgkt = data[0]['PESAWAT_BERANGKAT'];
      pesawatPlng = data[0]['PESAWAT_PULANG'];
      rute = data[0]['KETX_RUTE'];
      hotelMek = data[0]['HOTEL_MEKKAH'];
      hotelMad = data[0]['HOTEL_MADINAH'];
      hotelTra = data[0]['HOTEL_PLUS'];
      hotelPls = data[0]['HOTEL_TAMBAH'];
      sisa = data[0]['SISA'];
      foto = data[0]['FOTO_PKET'];
    });
  }

  @override
  void initState() {
    getAllJadwal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: screenWidth < 500 ? 24 : screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: screenWidth,
              height: screenHeight * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: screenHeight * 0.75,
                    height: screenHeight * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: foto != ""
                              ? NetworkImage('$urlAddress/uploads/paket/$foto')
                              : const AssetImage('assets/images/NO_IMAGE.jpg')),
                    ),
                    child: const SizedBox(),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              judul ?? '-',
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 232, 174, 0),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              keterangan ?? '-',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${mu ?? 'IDR'}.${myFormat.format(harga ?? 0)}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Maskapai : ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Berangkat : ${pesawatBgkt ?? '-'}   -   Pulang : ${pesawatPlng ?? '-'}",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Rute : ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              rute ?? '',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Hotel : ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            hotelMek != null
                                ? const SizedBox(height: 5)
                                : Container(),
                            hotelMek != null
                                ? Text(
                                    "- $hotelMek",
                                    style: TextStyle(fontSize: 14),
                                  )
                                : Container(),
                            hotelMad != null
                                ? const SizedBox(height: 5)
                                : Container(),
                            hotelMad != null
                                ? Text(
                                    "- $hotelMad",
                                    style: TextStyle(fontSize: 14),
                                  )
                                : Container(),
                            hotelTra != null
                                ? const SizedBox(height: 5)
                                : Container(),
                            hotelTra != null
                                ? Text(
                                    "- $hotelTra",
                                    style: TextStyle(fontSize: 14),
                                  )
                                : Container(),
                            hotelPls != null
                                ? const SizedBox(height: 5)
                                : Container(),
                            hotelPls != null
                                ? Text(
                                    "- $hotelPls",
                                    style: TextStyle(fontSize: 14),
                                  )
                                : Container(),
                            const SizedBox(height: 10),
                            Text(
                              'Sisa Seat : ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              sisa.toString() ?? '',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Segera Daftarkan Diri Kamu Sebelum Seat Habis !!!",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
