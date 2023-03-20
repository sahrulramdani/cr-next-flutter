// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
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

  void getAuth() async {
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

  void getDataGrupBarang() async {
    var response = await http.get(
        Uri.parse("$urlAddress/inventory/grupbrg/getGrupBrgHeaderAll"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      dataGrupBarang = data;
    });
  }

  @override
  void initState() {
    getAuth();
    getDataGrupBarang();
    super.initState();
  }

  Widget cmdTambah() {
    return ElevatedButton.icon(
      onPressed: () {
        authAddx == '1'
            ? showDialog(
                context: context,
                builder: (context) => const ModalTambahBarangGrupHeader())
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.add),
      style: ElevatedButton.styleFrom(
        backgroundColor: authAddx == '1' ? myBlue : Colors.blue[200],
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
        authPrnt == '1'
            ? showDialog(
                context: context,
                builder: (context) => const ModalTambahBarangGrupHeader())
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.print_outlined),
      label: const Text(
        'Print',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: authPrnt == '1' ? myBlue : Colors.blue[200],
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

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
