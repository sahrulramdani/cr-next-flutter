// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/card_icon_widget.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/card_paket.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/responsive_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScreenshotsContent extends ResponsiveWidget {
  const ScreenshotsContent({Key key}) : super(key: key);

  @override
  Widget buildDesktop(BuildContext context) =>
      const ScreenshotsContentResponsive(200);

  @override
  Widget buildMobile(BuildContext context) =>
      const ScreenshotsContentResponsive(24);
}

class ScreenshotsContentResponsive extends StatefulWidget {
  final horizontalPadding;

  const ScreenshotsContentResponsive(this.horizontalPadding, {Key key})
      : super(key: key);

  @override
  State<ScreenshotsContentResponsive> createState() =>
      _ScreenshotsContentResponsiveState();
}

class _ScreenshotsContentResponsiveState
    extends State<ScreenshotsContentResponsive> {
  List<Map<String, dynamic>> listJadwal = [];

  void getAllJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getAllJadwalDash"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = data;
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

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Layanan ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth < 500 ? 17 : 30),
                ),
                Text(
                  " Dan Produk Yang",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth < 500 ? 17 : 30,
                      color: Colors.red),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    "Kami Tawarkan Kepada ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth < 500 ? 17 : 30),
                  ),
                ),
                FittedBox(
                  child: Text(
                    "Anda",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth < 500 ? 17 : 30,
                        color: myBlue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CardIconLanding(
                  judul: "Umrah Reguler",
                  deskripsi:
                      "Umroh reguler merupakan perjalanan ibadah yang bertujuan langsung untuk menjalani ibadah Umroh di Tanah Suci. Program umroh regular kami biasanya dalam waktu 9 atau 11 hari disertai dengan wisata disekitaran makkah dan madinah.",
                  icon: "0xee5e",
                ),
                SizedBox(width: 20),
                CardIconLanding(
                  judul: "Umrah Plus",
                  deskripsi:
                      "Umroh plus merupakan paket perjalanan ibadah umroh ditambah wisata religi ke berbagai tempat tujuan. Melalui program ini anda tidak hanya melaksanakan ibadah umroh tetapi juga akan diajak berwisata religi untuk mentafakuri dan mempelajari budaya-budaya Islam di negara-negara lain.",
                  icon: "0xee5e",
                ),
                SizedBox(width: 20),
                CardIconLanding(
                  judul: "Haji Khusus",
                  deskripsi:
                      "Haji Khusus merupakan program haji resmi yang termasuk kuota haji pemerintah RI. Program ini juga diatur dalam Pasal 8 Undang-Undang (UU) Nomor 8 Tahun 2019 tentang Penyelenggaraan Ibadah Haji dan Umrah.",
                  icon: "0xee5e",
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CardIconLanding(
                  judul: "Haji Furoda",
                  deskripsi:
                      "Haji furoda adalah program haji dengan menggunakan Visa Haji Furoda atau Visa Haji Mujamalah (undangan) yang resmi dari pemerintah Kerajaan Arab Saudi. Program ini dilaksanakan secara mandiri oleh asosiasi travel yang bekerja sama dengan PIHK.",
                  icon: "0xee5e",
                ),
                SizedBox(width: 20),
                CardIconLanding(
                  judul: "Wisata Halal Dunia",
                  deskripsi:
                      "Rencanakan perjalanan wisata anda ke tempat yang ingin anda kunjungi bersama kami. Insya Allah melalui jaringan kami yang luas di berbagai negara kami akan menyediakan fasilitas dan terbaik untuk menemani perjalanan anda sesuai syariat islam.",
                  icon: "0xee5e",
                ),
                SizedBox(width: 20),
                CardIconLanding(
                  judul: "Provider Visa Umrah",
                  deskripsi:
                      "Sebagai komitmen kami untuk membantu masyarakat muslim indonesia berangkat umroh, dan melalui perizinan melaui kemenag, Embassy Arab Saudi di Indonesia dan Muasasah di Arab Saudi maka dari itu kami juga menyediakan layanan visa umroh.",
                  icon: "0xee5e",
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.arrow_left_outlined, color: myBlue),
                const SizedBox(width: 10),
                const FittedBox(
                    child: Text("Geser kekanan dan kekiri untuk melihat")),
                const SizedBox(width: 10),
                Icon(Icons.arrow_right_outlined, color: myBlue),
              ],
            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: listJadwal.map((e) {
                      return CardPaketLanding(
                        id: e['IDXX_PKET'].toString(),
                        judul: e['jenisPaket'],
                        keterangan: e['KETERANGAN'],
                        harga: e['TARIF_PKET'],
                        mu: e['MATA_UANG'],
                        sisa: e['SISA'],
                      );
                    }).toList()),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// class _Image extends StatelessWidget {
//   final String image;

//   const _Image({Key key, @required this.image}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const SizedBox(width: 16),
//         Image.asset(image),
//         const SizedBox(width: 16),
//       ],
//     );
//   }
// }

// class ScreenShotsContent extends StatelessWidget {
//   const ScreenShotsContent({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.green,
//       height: 250,
//     );
//   }
// }
