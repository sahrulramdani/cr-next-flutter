// ignore_for_file: must_call_super

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/pages/finance/widgets/kaspendapatan/formkaspendapatan.dart';
// import 'package:flutter_web_course/pages/inventory/widgets/satuan/form_satuan.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/finance/widgets/kaspendapatan/table_pendapatan.dart';
import 'package:flutter_web_course/pages/finance/widgets/kaspengeluaran/formkaspengeluaran.dart';
import 'package:flutter_web_course/pages/finance/widgets/kaspengeluaran/table_pengeluaran.dart';
// import 'package:flutter_web_course/pages/inventory/widgets/satuan/table_satuan.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;

class KasPengeluaran extends StatefulWidget {
  const KasPengeluaran({Key key}) : super(key: key);

  @override
  State<KasPengeluaran> createState() => _KasPengeluaranState();
}

class _KasPengeluaranState extends State<KasPengeluaran> {
  List<Map<String, dynamic>> listPengeluaran = [
    {
      "NOTRANSAKSI": "K001",
      "STATUSPOSTING": "BERHASIL",
    },
    {
      "NOTRANSAKSI": "K002",
      "STATUSPOSTING": "BERHASIL",
    },
    {
      "NOTRANSAKSI": "K003",
      "STATUSPOSTING": "GAGAL",
    },
  ];

  // void getData() async {
  //   var response =
  //       await http.get(Uri.parse("$urlAddress/inventory/satuan/getAllSatuan"));
  //   List<Map<String, dynamic>> data =
  //       List.from(json.decode(response.body) as List);

  //   setState(() {
  //     listSatuan = data;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // print(listSatuan);
    // getData();
  }

  bool enableFormL = false;
  Widget cmdTambah() {
    return ElevatedButton.icon(
      onPressed: () async {
        setState(() {
          enableFormL = !enableFormL;
        });
        // getList();
      },
      icon: const Icon(Icons.add),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
      label: const Text(
        'Tambah Data',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
    );
  }

  Widget cmdPrint() {
    return ElevatedButton.icon(
      onPressed: () {
        // print(listAgency);
      },
      icon: const Icon(Icons.print_outlined),
      label: const Text(
        'Print',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdExport() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.download_outlined),
      label: const Text(
        'Export',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  // Widget cmdBatal() {
  //   return ElevatedButton.icon(
  //     onPressed: () {
  //       setState(() {
  //         enableFormL = !enableFormL;
  //       });
  //     },
  //     icon: const Icon(Icons.cancel),
  //     label: const Text(
  //       'Batal',
  //       style: TextStyle(fontFamily: 'Gilroy'),
  //     ),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: myBlue,
  //       minimumSize: const Size(100, 40),
  //       shadowColor: Colors.grey,
  //       elevation: 5,
  //     ),
  //   );
  // }

  Widget spacePemisah() {
    return const SizedBox(
      height: 10,
      width: 10,
    );
  }

  Widget menuButton() => Container(
        height: !enableFormL ? 50 : 0,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Visibility(
                visible: !enableFormL,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    cmdTambah(),
                    //---------------------------------
                    spacePemisah(),
                    //---------------------------------
                    // cmdPrint(),
                    // //---------------------------------
                    // spacePemisah(),
                    //---------------------------------
                    // cmdExport(),
                    //---------------------------------
                    // spacePemisah(),
                  ],
                )),

            //---------------------------------
            // Visibility(
            //   visible: enableFormL,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       // cmdSimpan(),
            //       //---------------------------------
            //       // spacePemisah(),
            //       //---------------------------------
            //       cmdBatal()
            //     ],
            //   ),
            // ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: 'Finance - ${menuController.activeItem.value}',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          menuButton(),
          const SizedBox(
            height: 10,
          ),
          Visibility(
              visible: enableFormL,
              child: Container(
                  padding: const EdgeInsets.only(bottom: 20, right: 15),
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: const FormKasPengeluaran())),
          Visibility(
              visible: !enableFormL,
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Transaksi',
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: myBlue),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 50,
                                width: 250,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontFamily: 'Gilroy', fontSize: 14),
                                  decoration: const InputDecoration(
                                      hintText: 'Cari Kode Kas'),
                                  onChanged: (value) {
                                    // if (value == '') {
                                    //   listAgency = listAgency;
                                    //   getList();
                                    // } else {
                                    //   setState(() {
                                    //     listAgency = listAgency
                                    //         .where((element) =>
                                    //             element['NAMA_LGKP']
                                    //                 .contains(value))
                                    //         .toList();
                                    //   });
                                    // }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TablePengeluaran(listPengeluaran: listPengeluaran)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
