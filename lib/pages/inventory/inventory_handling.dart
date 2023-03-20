// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
import 'package:flutter_web_course/pages/inventory/widgets/handling/table_handling.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;

class InventoryHandlingPage extends StatefulWidget {
  const InventoryHandlingPage({Key key}) : super(key: key);

  @override
  State<InventoryHandlingPage> createState() => _InventoryHandlingPageState();
}

class _InventoryHandlingPageState extends State<InventoryHandlingPage> {
  List<Map<String, dynamic>> listGrupHandling = [];
  List<Map<String, dynamic>> listGrupHandlingLaki = [];
  List<Map<String, dynamic>> listGrupHandlingPerempuan = [];
  bool enableFormL = false;
  bool onStok = false;

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

  void getDataGrupHandling() async {
    var response = await http.get(
        Uri.parse("$urlAddress/inventory/handling/grup-handling"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listGrupHandling = data;
    });
  }

  void getDataGrupHandlingLaki() async {
    var response = await http.get(
        Uri.parse("$urlAddress/inventory/handling/handling-detail/L"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listGrupHandlingLaki = data;
    });

    loadEnd();
  }

  void getDataGrupHandlingPerempuam() async {
    var response = await http.get(
        Uri.parse("$urlAddress/inventory/handling/handling-detail/P"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listGrupHandlingPerempuan = data;
    });
  }

  @override
  void initState() {
    getAuth();
    getDataGrupHandling();
    getDataGrupHandlingLaki();
    getDataGrupHandlingPerempuam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
          const SizedBox(height: 10),
          SizedBox(
            height: ResponsiveWidget.isSmallScreen(context)
                ? screenHeight * 0.87
                : 533,
            child: ResponsiveWidget.isSmallScreen(context)
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: TableGrupHandling(
                            idGrup: listGrupHandling.isEmpty
                                ? '-'
                                : listGrupHandling[0]['KDXX_GHAN'],
                            jenis: 'L',
                            listHandling: listGrupHandlingLaki,
                            judul: 'Barang Handling Laki Laki',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: TableGrupHandling(
                            idGrup: listGrupHandling.isEmpty
                                ? '-'
                                : listGrupHandling[1]['KDXX_GHAN'],
                            jenis: 'P',
                            listHandling: listGrupHandlingPerempuan,
                            judul: 'Barang Handling Perempuan',
                          ),
                        )
                      ],
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(5),
                        child: TableGrupHandling(
                          idGrup: listGrupHandling.isEmpty
                              ? '-'
                              : listGrupHandling[0]['KDXX_GHAN'],
                          jenis: 'L',
                          listHandling: listGrupHandlingLaki,
                          judul: 'Barang Handling Laki Laki',
                        ),
                      )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(5),
                        child: TableGrupHandling(
                          idGrup: listGrupHandling.isEmpty
                              ? '-'
                              : listGrupHandling[1]['KDXX_GHAN'],
                          jenis: 'P',
                          listHandling: listGrupHandlingPerempuan,
                          judul: 'Barang Handling Perempuan',
                        ),
                      ))
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
