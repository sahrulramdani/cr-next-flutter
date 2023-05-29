// ignore_for_file: must_call_super

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/header_title_menu.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'widgets/transit/table_transit.dart';
import 'package:get/get.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'widgets/transit/modal_cd_transit.dart';
import 'package:http/http.dart' as http;

class MarketingTransitPage extends StatefulWidget {
  const MarketingTransitPage({Key key}) : super(key: key);

  @override
  State<MarketingTransitPage> createState() => _MarketingTransitPageState();
}

class _MarketingTransitPageState extends State<MarketingTransitPage> {
  List<Map<String, dynamic>> listTransit = [];

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

  void getData() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getTransit"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listTransit = data;
    });
  }

  @override
  void initState() {
    getAuth();
    getData();
    super.initState();
  }

  bool enableFormL = false;
  Widget cmdTambah(context) {
    var idTransit = '';
    var tambah = true;
    return ElevatedButton.icon(
      onPressed: () async {
        authAddx == '1'
            ? showDialog(
                context: context,
                builder: (context) =>
                    ModalCdTransit(idTransit: idTransit, tambah: tambah))
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

    return Column(
      children: [
        Obx(() => HeaderTitleMenu(menu: menuController.activeItem.value)),
        const SizedBox(height: 10),
        menuButton(context),
        const SizedBox(height: 10),
        Expanded(
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
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Seluruh Satuan',
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
                                  hintText: 'Cari Nama Negara'),
                              onChanged: (value) {
                                if (value == '') {
                                  getData();
                                } else {
                                  setState(() {
                                    listTransit = listTransit
                                        .where(((element) =>
                                            element['NAMA_NEGR']
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
                Expanded(child: TableMasterTransit(listTransit: listTransit))
              ],
            ),
          ),
        )
      ],
    );
  }
}
