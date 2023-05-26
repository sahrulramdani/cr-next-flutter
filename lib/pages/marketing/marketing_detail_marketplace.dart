// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/landing/paket/widgets/adversiting_box.dart';
import 'package:flutter_web_course/pages/landing/paket/widgets/description_box.dart';
import 'package:flutter_web_course/pages/landing/paket/widgets/rincian_box.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/card_paket.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/not_find_widget.dart';
import 'package:flutter_web_course/pages/marketing/widgets/marketplace/card_paket_marketplace.dart';
import 'package:flutter_web_course/pages/marketing/widgets/marketplace/description_box_market.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';

class MarketingDetailMarketplace extends StatefulWidget {
  const MarketingDetailMarketplace({Key key}) : super(key: key);

  @override
  State<MarketingDetailMarketplace> createState() =>
      _MarketingDetailMarketplaceState();
}

class _MarketingDetailMarketplaceState
    extends State<MarketingDetailMarketplace> {
  List<Map<String, dynamic>> listDetJadwal = [];
  List<Map<String, dynamic>> listJadwal = [];
  String idPaket;
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

  void getAuth() async {
    // loadStart();
    var response = await http.get(
        Uri.parse("$urlAddress/get-permission/$menuKode/$username"),
        headers: {
          'pte-token': kodeToken,
        });

    var auth = json.decode(response.body);
    setState(() {
      authAddx = auth['AUTH_ADDX'];
      authEdit = auth['AUTH_EDIT'];
      authDelt = auth['AUTH_DELT'];
      authInqu = auth['AUTH_INQU'];
      authPrnt = auth['AUTH_PRNT'];
      authExpt = auth['AUTH_EXPT'];
    });
  }

  void getDetJadwal() async {
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/jadwal/getDetailDash/$produkKode"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listDetJadwal = data;
      idPaket = data[0]['IDXX_JDWL'];
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

  void getJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/get-jadwal"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = data;
    });
  }

  @override
  void initState() {
    getAuth();
    getDetJadwal();
    getJadwal();
    super.initState();
  }

  Widget detailWeb() {
    final screenHeight = MediaQuery.of(context).size.height;
    int jmlRow = listJadwal.length ~/ 5 + 1;

    return Column(
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
                            ? NetworkImage('$urlAddress/uploads/paket/$foto')
                            : const AssetImage(
                                'assets/images/none-produk.png')),
                  ),
                  child: const SizedBox(),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: DescriptionBoxMarket(
                idPaket: idPaket,
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
                foto: foto,
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
          "LAINNYA UNTUK JAMAAH MU",
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
                            CardPaketMarketplace(
                              idPaket: listJadwal[j]['IDXX_JDWL'].toString(),
                              judul: listJadwal[j]['jenisPaket'],
                              keterangan: listJadwal[j]['KETERANGAN'],
                              harga: listJadwal[j]['TARIF_PKET'],
                              mu: listJadwal[j]['MATA_UANG'],
                              sisa: listJadwal[j]['SISA'],
                              foto: listJadwal[j]['FOTO_PKET'],
                              keberangkatan: listJadwal[j]['TGLX_BGKT'],
                              keberangkatanDi: listJadwal[j]['RUTE_AWAL_BRKT'],
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
    );
  }

  Widget detaiMobile() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
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
                            ? NetworkImage('$urlAddress/uploads/paket/$foto')
                            : const AssetImage('assets/images/NO_IMAGE.jpg')),
                  ),
                  child: const SizedBox(),
                ),
              ],
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: screenWidth,
              child: DescriptionBoxMarket(
                idPaket: idPaket,
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
                foto: foto,
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
                    return CardPaketMarketplace(
                      idPaket: e['IDXX_JDWL'].toString(),
                      judul: e['jenisPaket'],
                      keterangan: e['KETERANGAN'],
                      harga: e['TARIF_PKET'],
                      mu: e['MATA_UANG'],
                      sisa: e['SISA'],
                      foto: e['FOTO_PKET'],
                      keberangkatan: e['TGLX_BGKT'],
                      keberangkatanDi: e['RUTE_AWAL_BRKT'],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: 'Marketing - ${menuController.activeItem.value}',
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                )
              ],
            )),
        const SizedBox(height: 20),
        screenWidth > 550
            ? SizedBox(
                height: screenHeight * 0.8,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:
                        SizedBox(width: screenWidth * 0.8, child: detailWeb()),
                  ),
                ),
              )
            : SizedBox(
                height: screenHeight * 0.8,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                        width: screenWidth * 0.9, child: detaiMobile()),
                  ),
                ),
              ),
      ],
    );
  }
}
