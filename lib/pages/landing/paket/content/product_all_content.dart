// ignore: undefined_prefixed_name
// ignore_for_file: unused_import

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/card_paket.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/not_find_widget.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/responsive_widget.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductAllContent extends ResponsiveWidget {
  const ProductAllContent({Key key}) : super(key: key);

  @override
  Widget buildDesktop(BuildContext context) => const DesktopProductAllContent();

  @override
  Widget buildMobile(BuildContext context) => const MobileProductAllContent();
}

class DesktopProductAllContent extends StatefulWidget {
  const DesktopProductAllContent({Key key}) : super(key: key);

  @override
  State<DesktopProductAllContent> createState() =>
      _DesktopProductAllContentState();
}

class _DesktopProductAllContentState extends State<DesktopProductAllContent> {
  List<Map<String, dynamic>> listJadwal = [];
  TextEditingController dateSearch = TextEditingController();

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
    int jmlRow = listJadwal.length ~/ 5 + 1;

    return SizedBox(
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 24, horizontal: screenWidth * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cari Paket Yang Tersedia',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const ui.Color.fromARGB(255, 204, 232, 255),
                              hintText: "Umroh Plus Yaman",
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.blue[900],
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue[900],
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue[900],
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              if (value == '') {
                                setState(() {
                                  getAllJadwal();
                                });
                              } else {
                                setState(() {
                                  listJadwal = listJadwal
                                      .where(((element) => element['KETERANGAN']
                                          .toString()
                                          .toUpperCase()
                                          .contains(value.toUpperCase())))
                                      .toList();
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: TextFormField(
                          controller: dateSearch,
                          decoration: InputDecoration(
                            hintText: ('DD-MM-YYYY'),
                            filled: true,
                            fillColor:
                                const ui.Color.fromARGB(255, 204, 232, 255),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.blue[900],
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.blue[900],
                                width: 2.0,
                              ),
                            ),
                            prefixIcon:
                                const Icon(Icons.calendar_today_outlined),
                            prefixIconColor: Colors.blue[900],
                          ),
                          // onTap: () async {
                          //   DateTime pickedDate = await showDatePicker(
                          //     context: context,
                          //     initialDate: DateTime.now(),
                          //     firstDate: DateTime(1900),
                          //     lastDate: DateTime(2100),
                          //   );
                          //   if (pickedDate != null) {
                          //     String formattedDate =
                          //         DateFormat('dd-MM-yyyy').format(pickedDate);
                          //     dateSearch.text = formattedDate;
                          //   }
                          // },
                          onChanged: ((value) {
                            if (value == '') {
                              setState(() {
                                getAllJadwal();
                              });
                            } else {
                              setState(() {
                                listJadwal = listJadwal
                                    .where(((element) => element['TGLX_BGKT']
                                        .toString()
                                        .toUpperCase()
                                        .contains(value.toUpperCase())))
                                    .toList();
                              });
                            }
                          }),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                        description: 'Data Tidak Ditemukan',
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class MobileProductAllContent extends StatefulWidget {
  const MobileProductAllContent({Key key}) : super(key: key);

  @override
  State<MobileProductAllContent> createState() =>
      _MobileProductAllContentState();
}

class _MobileProductAllContentState extends State<MobileProductAllContent> {
  List<Map<String, dynamic>> listJadwal = [];
  TextEditingController dateSearch = TextEditingController();

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
    // int jmlRow = listJadwal.length ~/ 5 + 1;

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cari Paket Yang Tersedia',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const ui.Color.fromARGB(255, 204, 232, 255),
                              hintText: "Umroh Plus Yaman",
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.blue[900],
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue[900],
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue[900],
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              if (value == '') {
                                setState(() {
                                  getAllJadwal();
                                });
                              } else {
                                setState(() {
                                  listJadwal = listJadwal
                                      .where(((element) => element['KETERANGAN']
                                          .toString()
                                          .toUpperCase()
                                          .contains(value.toUpperCase())))
                                      .toList();
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: screenWidth * 0.4,
                        child: TextFormField(
                          controller: dateSearch,
                          decoration: InputDecoration(
                            hintText: ('DD-MM-YYYY'),
                            filled: true,
                            fillColor:
                                const ui.Color.fromARGB(255, 204, 232, 255),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.blue[900],
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.blue[900],
                                width: 2.0,
                              ),
                            ),
                            prefixIcon:
                                const Icon(Icons.calendar_today_outlined),
                            prefixIconColor: Colors.blue[900],
                          ),
                          onChanged: ((value) {
                            if (value == '') {
                              setState(() {
                                getAllJadwal();
                              });
                            } else {
                              setState(() {
                                listJadwal = listJadwal
                                    .where(((element) => element['TGLX_BGKT']
                                        .toString()
                                        .toUpperCase()
                                        .contains(value.toUpperCase())))
                                    .toList();
                              });
                            }
                          }),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  listJadwal.isNotEmpty
                      ? Container(
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
                            // children: [
                            //   for (var i = 0; i < jmlRow; i++)
                            //     Row(
                            //       children: [
                            //         for (var j = (i * 4);
                            //             j <
                            //                 (i == (jmlRow - 1)
                            //                     ? listJadwal.length
                            //                     : ((i + 1) * 4));
                            //             j++)
                            //           CardPaketLanding(
                            //             idPaket: listJadwal[j]['IDXX_JDWL']
                            //                 .toString(),
                            //             judul: listJadwal[j]['jenisPaket'],
                            //             keterangan: listJadwal[j]['KETERANGAN'],
                            //             harga: listJadwal[j]['TARIF_PKET'],
                            //             mu: listJadwal[j]['MATA_UANG'],
                            //             sisa: listJadwal[j]['SISA'],
                            //             foto: listJadwal[j]['FOTO_PKET'],
                            //             keberangkatan: listJadwal[j]
                            //                 ['TGLX_BGKT'],
                            //           )
                            //       ],
                            //     )
                            // ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            NotFindWidget(
                              description: "Data Tidak Ditemukan",
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
