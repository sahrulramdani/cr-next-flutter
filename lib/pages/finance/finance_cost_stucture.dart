// ignore_for_file: must_call_super, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/finance/widgets/cost-structure/modal_cd_coststructure.dart';
import 'package:flutter_web_course/pages/finance/widgets/cost-structure/modal_hapus_cost.dart';
import 'package:flutter_web_course/pages/finance/widgets/pendaparan-biaya/modal_cd_pendapatanbiaya.dart';
import 'package:flutter_web_course/pages/finance/widgets/pendaparan-biaya/table_pendapatan_biaya.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;

class FinanceCostStructure extends StatefulWidget {
  const FinanceCostStructure({Key key}) : super(key: key);

  @override
  State<FinanceCostStructure> createState() => _FinanceCostStructureState();
}

class _FinanceCostStructureState extends State<FinanceCostStructure> {
  // List<Map<String, dynamic>> listPendapatan = [];
  List<Map<String, dynamic>> listCostStructure = [];

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

  void getCostStructure() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/all-cost-structure"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    if (data.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        var pushData = {
          "NOXX_CSXX": "${(i + 1)}",
          "KDXX_CSXX": "${data[i]['KDXX_CSXX']}",
          "KDXX_SUMB": "${data[i]['SUMB_DANA']}",
          "NAMA_SUMB":
              "${data[i]['NAMA_SUMBD'] != data[i == 0 ? 0 : i - 1]['NAMA_SUMBD'] ? data[i]['NAMA_SUMBD'] : (i == 0 ? data[i]['NAMA_SUMBD'] : '')}",
          "KDXX_BIAYA": "${data[i]['NAMA_BIAYA']}",
          "NAMA_BIAYA": "${data[i]['NAMA_BIAYAC']}",
        };

        listCostStructure.add(pushData);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    getAuth();
    getCostStructure();
    super.initState();
  }

  bool enableFormL = false;
  Widget cmdTambah(context) {
    return ElevatedButton.icon(
      onPressed: () async {
        authInqu == '1'
            ? showDialog(
                context: context,
                builder: (context) => const ModalCdCostStructure())
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

  Widget spacePemisah() {
    return const SizedBox(
      height: 10,
      width: 10,
    );
  }

  Widget menuButton(context) => Container(
        height: !enableFormL ? 50 : 0,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            cmdTambah(context),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    int x = 1;

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
          menuButton(context),
          const SizedBox(
            height: 10,
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
                            'Cost Structure Paket',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: myBlue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: screenHeight * 0.62,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(children: [
                        DataTable(
                            columnSpacing: 240,
                            dataRowHeight: 35,
                            columns: const [
                              DataColumn(
                                  label: Text('No.', style: styleColumn)),
                              DataColumn(
                                  label:
                                      Text('Sumber Dana', style: styleColumn)),
                              DataColumn(
                                  label:
                                      Text('Nama Biaya', style: styleColumn)),
                              DataColumn(
                                  label: Text('Aksi', style: styleColumn)),
                            ],
                            rows: listCostStructure.map((e) {
                              return DataRow(cells: [
                                DataCell(Text((x++).toString(),
                                    style: styleRowReguler)),
                                DataCell(Text(e['NAMA_SUMB'] ?? '',
                                    style: styleRowReguler)),
                                DataCell(Text(e['NAMA_BIAYA'] ?? '',
                                    style: styleRowReguler)),
                                DataCell(IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: authDelt == '1'
                                        ? myBlue
                                        : Colors.blue[200],
                                  ),
                                  onPressed: () {
                                    authDelt == '1'
                                        ? showDialog(
                                            context: context,
                                            builder: (context) =>
                                                ModalHapusCostStructure(
                                                    idBiaya: e['KDXX_CSXX']),
                                          )
                                        : showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const ModalInfo(
                                                  deskripsi:
                                                      'Anda Tidak Memiliki Akses',
                                                ));
                                  },
                                )),
                              ]);
                            }).toList())
                      ]),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
