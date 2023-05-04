// ignore: undefined_prefixed_name
// ignore_for_file: unused_import, prefer_typing_uninitialized_variables

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/landing/paket/widgets/adversiting_box.dart';
import 'package:flutter_web_course/pages/landing/paket/widgets/description_box.dart';
import 'package:flutter_web_course/pages/landing/paket/widgets/rincian_box.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/card_paket.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/not_find_widget.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/responsive_widget.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailContent extends ResponsiveWidget {
  final idPaket;
  const ProductDetailContent({Key key, @required this.idPaket})
      : super(key: key);

  @override
  Widget buildDesktop(BuildContext context) =>
      DesktopProductDetailContent(idPaket: idPaket);

  @override
  Widget buildMobile(BuildContext context) => MobileProductDetailContent(
        idPaket: idPaket,
      );
}

class DesktopProductDetailContent extends StatefulWidget {
  final idPaket;
  const DesktopProductDetailContent({Key key, @required this.idPaket})
      : super(key: key);

  @override
  State<DesktopProductDetailContent> createState() =>
      _DesktopProductDetailContentState();
}

class _DesktopProductDetailContentState
    extends State<DesktopProductDetailContent> {
  List<Map<String, dynamic>> listDetJadwal = [];
  List<Map<String, dynamic>> listJadwal = [];
  String judul;
  String keterangan;
  int harga;
  String mu;
  String pesawatBgkt = "";
  String pesawatPlng = "";
  String rute;
  String hotelMek;
  String hotelMad;
  String hotelTra;
  String hotelPls;
  int sisa;
  String berangkat;
  String pulang;
  int durasi;

  String foto = "";

  void getAllJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getAllJadwalDash"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = data;
    });
  }

  void getDetJadwal() async {
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
      durasi = data[0]['JMLX_HARI'];
      berangkat = data[0]['TGLX_BGKT'];
      pulang = data[0]['TGLX_PLNG'];
      foto = data[0]['FOTO_PKET'];
    });
  }

  @override
  void initState() {
    getAllJadwal();
    getDetJadwal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int jmlRow = listJadwal.length ~/ 5 + 1;

    return SizedBox(
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 24, horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
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
                                ? NetworkImage(
                                    '$urlAddress/uploads/paket/$foto')
                                : const AssetImage(
                                    'assets/images/NO_IMAGE.jpg')),
                      ),
                      child: const SizedBox(),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: DescriptionBoxWidget(
                    judul: judul,
                    keterangan: keterangan,
                    harga: harga,
                    mu: mu,
                    pesawatBgkt: pesawatBgkt,
                    pesawatPlng: pesawatPlng,
                    rute: rute,
                    hotelMek: hotelMek,
                    hotelMad: hotelMad,
                    hotelTra: hotelTra,
                    hotelPls: hotelPls,
                    sisa: sisa,
                    berangkat: berangkat,
                    pulang: pulang,
                    durasi: durasi,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            const AdversitingBoxWidget(),
            const SizedBox(height: 30),
            const Text(
              "RINCIAN TAMBAHAN",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const RincianBoxWidget(),
            const SizedBox(height: 30),
            const Text(
              "LAINNYA UNTUK KAMU",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            listJadwal.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < jmlRow; i++)
                          Row(
                            children: [
                              for (var j = (i * 4);
                                  j <
                                      (i == (jmlRow - 1)
                                          ? listJadwal.length
                                          : ((i + 1) * 4));
                                  j++)
                                CardPaketLanding(
                                  idPaket:
                                      listJadwal[j]['IDXX_JDWL'].toString(),
                                  judul: listJadwal[j]['jenisPaket'],
                                  keterangan: listJadwal[j]['KETERANGAN'],
                                  harga: listJadwal[j]['TARIF_PKET'],
                                  mu: listJadwal[j]['MATA_UANG'],
                                  sisa: listJadwal[j]['SISA'],
                                  foto: listJadwal[j]['FOTO_PKET'],
                                  keberangkatan: listJadwal[j]['TGLX_BGKT'],
                                )
                            ],
                          )
                      ],
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      NotFindWidget(
                        description: 'Tidak Ada Rekomendasi Paket',
                      ),
                    ],
                  ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class MobileProductDetailContent extends StatefulWidget {
  final idPaket;
  const MobileProductDetailContent({Key key, @required this.idPaket})
      : super(key: key);

  @override
  State<MobileProductDetailContent> createState() =>
      _MobileProductDetailContentState();
}

class _MobileProductDetailContentState
    extends State<MobileProductDetailContent> {
  List<Map<String, dynamic>> listDetJadwal = [];
  List<Map<String, dynamic>> listJadwal = [];
  String judul;
  String keterangan;
  int harga;
  String mu;
  String pesawatBgkt = "";
  String pesawatPlng = "";
  String rute;
  String hotelMek;
  String hotelMad;
  String hotelTra;
  String hotelPls;
  int sisa;
  String berangkat;
  String pulang;
  int durasi;

  String foto = "";

  void getAllJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getAllJadwalDash"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = data;
    });
  }

  void getDetJadwal() async {
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
      durasi = data[0]['JMLX_HARI'];
      berangkat = data[0]['TGLX_BGKT'];
      pulang = data[0]['TGLX_PLNG'];
      foto = data[0]['FOTO_PKET'];
    });
  }

  @override
  void initState() {
    getAllJadwal();
    getDetJadwal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: screenWidth * 0.9,
                      height: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: foto != ""
                                ? NetworkImage(
                                    '$urlAddress/uploads/paket/$foto')
                                : const AssetImage(
                                    'assets/images/NO_IMAGE.jpg')),
                      ),
                      child: const SizedBox(),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: screenWidth,
                  child: DescriptionBoxWidget(
                    judul: judul,
                    keterangan: keterangan,
                    harga: harga,
                    mu: mu,
                    pesawatBgkt: pesawatBgkt,
                    pesawatPlng: pesawatPlng,
                    rute: rute,
                    hotelMek: hotelMek,
                    hotelMad: hotelMad,
                    hotelTra: hotelTra,
                    hotelPls: hotelPls,
                    sisa: sisa,
                    berangkat: berangkat,
                    pulang: pulang,
                    durasi: durasi,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            const AdversitingBoxWidget(),
            const SizedBox(height: 30),
            const Text(
              "RINCIAN TAMBAHAN",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const RincianBoxWidget(),
            const SizedBox(height: 30),
            const Text(
              "LAINNYA UNTUK KAMU",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            listJadwal.isNotEmpty
                ? SizedBox(
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: listJadwal.map((e) {
                        return CardPaketLanding(
                          idPaket: e['IDXX_JDWL'].toString(),
                          judul: e['jenisPaket'],
                          keterangan: e['KETERANGAN'],
                          harga: e['TARIF_PKET'],
                          mu: e['MATA_UANG'],
                          sisa: e['SISA'],
                          foto: e['FOTO_PKET'],
                          keberangkatan: e['TGLX_BGKT'],
                        );
                      }).toList(),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      NotFindWidget(
                        description: "Tidak Ada Rekomendasi Paket",
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
