// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/pages/inventory/widgets/barang/form_barang.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/inventory/widgets/barang/table_barang.dart';
import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/modal_tambah_barang_grup.dart';
import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/modal_tambah_grup_header.dart';
import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/table_grup_barang.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;

class InventoryGrupBarangPage extends StatefulWidget {
  const InventoryGrupBarangPage({Key key}) : super(key: key);

  @override
  State<InventoryGrupBarangPage> createState() =>
      _InventoryGrupBarangPageState();
}

class _InventoryGrupBarangPageState extends State<InventoryGrupBarangPage> {
  List<Map<String, dynamic>> dataGrupBarang = [];
  bool enableFormL = false;
  bool onStok = false;

  void getDataGrupBarang() async {
    var response = await http
        .get(Uri.parse("$urlAddress/inventory/grupbrg/getGrupBrgHeaderAll"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      dataGrupBarang = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataGrupBarang();
  }

  Widget cmdTambah() {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => const ModalTambahBarangGrupHeader());
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

  // Widget cmdStok() {
  //   return ElevatedButton.icon(
  //     onPressed: () {
  //       if (onStok == false) {
  //         setState(() {
  //           dataBarang = dataBarang
  //               .where((element) => int.parse(element['stok']) < 10)
  //               .toList();
  //           onStok = true;
  //         });
  //       } else {
  //         setState(() {
  //           dataBarang = listBarang;
  //           onStok = false;
  //         });
  //       }
  //     },
  //     icon: const Icon(Icons.compress_rounded),
  //     label: const Text(
  //       'Stok < 10',
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
                    //---------------------------------
                    spacePemisah(),
                    //---------------------------------
                    // cmdStok(),
                    //---------------------------------
                    spacePemisah(),
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
                      text: 'Inventory - ${menuController.activeItem.value}',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          menuButton(),
          const SizedBox(
            height: 10,
          ),
          // Visibility(
          //     visible: enableFormL,
          //     child: Container(
          //         padding: const EdgeInsets.only(bottom: 20, right: 15),
          //         width: screenWidth,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(5),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.2),
          //               spreadRadius: 2,
          //               blurRadius: 7,
          //             ),
          //           ],
          //         ),
          //         child: const BarangForm())),
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
                                'Seluruh Data Barang',
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
                                      hintText: 'Cari Nama Barang'),
                                  // onChanged: (value) {
                                  //   if (value == '') {
                                  //     setState(() {
                                  //       dataBarang = listBarang;
                                  //     });
                                  //   } else {
                                  //     setState(() {
                                  //       dataBarang = listBarang
                                  //           .where((element) =>
                                  //               element['nama'].contains(value))
                                  //           .toList();
                                  //     });
                                  //   }
                                  // },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TableGrupBarang(listData: dataGrupBarang),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
