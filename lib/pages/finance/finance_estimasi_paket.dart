// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/finance/widgets/estimasi-paket/table_estimasi_paket.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:flutter_web_course/constants/style.dart';

class FinanceEstimasiPaket extends StatefulWidget {
  const FinanceEstimasiPaket({Key key}) : super(key: key);

  @override
  State<FinanceEstimasiPaket> createState() => _FinanceEstimasiPaketState();
}

class _FinanceEstimasiPaketState extends State<FinanceEstimasiPaket> {
  bool enableFormL = false;
  List<Map<String, dynamic>> listJadwal = [];
  List<Map<String, dynamic>> listCardJadwal = [];

  void getAuth() async {
    loadStart();

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

  void getAllJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/all-estimasi-paket"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = data;
    });

    loadEnd();
  }

  @override
  void initState() {
    getAuth();
    getAllJadwal();
    super.initState();
  }

  // Widget cmdTambah() {
  //   return ElevatedButton.icon(
  //     onPressed: () async {
  //       authAddx == '1'
  //           ? setState(() {
  //               enableFormL = !enableFormL;
  //             })
  //           : showDialog(
  //               context: context,
  //               builder: (context) => const ModalInfo(
  //                     deskripsi: 'Anda Tidak Memiliki Akses',
  //                   ));
  //     },
  //     icon: const Icon(Icons.add),
  //     style: fncButtonAuthStyle(authAddx, context),
  //     label: fncLabelButtonStyle('Tambah Data', context),
  //   );
  // }

  // Widget cmdPrint() {
  //   return ElevatedButton.icon(
  //     onPressed: () {
  //       authPrnt == '1'
  //           ? ''
  //           : showDialog(
  //               context: context,
  //               builder: (context) => const ModalInfo(
  //                     deskripsi: 'Anda Tidak Memiliki Akses',
  //                   ));
  //     },
  //     icon: const Icon(Icons.print_outlined),
  //     style: fncButtonAuthStyle(authPrnt, context),
  //     label: fncLabelButtonStyle('Print', context),
  //   );
  // }

  // Widget cmdExport() {
  //   return ElevatedButton.icon(
  //     onPressed: () {
  //       authExpt == '1'
  //           ? ''
  //           : showDialog(
  //               context: context,
  //               builder: (context) => const ModalInfo(
  //                     deskripsi: 'Anda Tidak Memiliki Akses',
  //                   ));
  //     },
  //     icon: const Icon(Icons.download_outlined),
  //     style: fncButtonAuthStyle(authExpt, context),
  //     label: fncLabelButtonStyle('Export', context),
  //   );
  // }

  // Widget spacePemisah() {
  //   return const SizedBox(
  //     height: 10,
  //     width: 10,
  //   );
  // }

  // Widget menuButton() => Container(
  //       height: !enableFormL ? 50 : 0,
  //       alignment: Alignment.centerRight,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Visibility(
  //               visible: !enableFormL,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   cmdTambah(),
  //                   //---------------------------------
  //                   spacePemisah(),
  //                   //---------------------------------
  //                   cmdPrint(),
  //                   //---------------------------------
  //                   spacePemisah(),
  //                   //---------------------------------
  //                   cmdExport(),
  //                   //---------------------------------
  //                   spacePemisah(),
  //                 ],
  //               )),

  //           //---------------------------------
  //           // Visibility(
  //           //   visible: enableFormL,
  //           //   child: Row(
  //           //     mainAxisAlignment: MainAxisAlignment.end,
  //           //     children: [
  //           //       // cmdSimpan(),
  //           //       //---------------------------------
  //           //       // spacePemisah(),
  //           //       //---------------------------------
  //           //       cmdBatal()
  //           //     ],
  //           //   ),
  //           // ),
  //         ],
  //       ),
  //     );

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
          Container(
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
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Daftar Jadwal Paket',
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
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontFamily: 'Gilroy', fontSize: 14),
                              decoration: const InputDecoration(
                                  hintText: 'Cari Berdasarkan Paket'),
                              onChanged: (value) {
                                if (value == '') {
                                  setState(() {
                                    getAllJadwal();
                                  });
                                } else {
                                  setState(() {
                                    listJadwal = listJadwal
                                        .where(((element) =>
                                            element['jenisPaket']
                                                .toString()
                                                .toUpperCase()
                                                .contains(value.toUpperCase())))
                                        .toList();
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableEstimasiPaket(
                  dataJadwal: listJadwal,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
