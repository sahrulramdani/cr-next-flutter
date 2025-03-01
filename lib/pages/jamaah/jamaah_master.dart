import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/header_title_menu.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/form_jamaah.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/table_master_jamaah.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_course/constants/style.dart';

class JamaahDataPage extends StatefulWidget {
  const JamaahDataPage({Key key}) : super(key: key);

  @override
  State<JamaahDataPage> createState() => _JamaahDataPageState();
}

class _JamaahDataPageState extends State<JamaahDataPage> {
  bool enableFormL = false;
  List<Map<String, dynamic>> listJamaah = [];
  List<Map<String, dynamic>> listCardCalonJamaah = [];

  // -------------------------------------------------------------------
  // ---------------------------- GET DATA -----------------------------
  // -------------------------------------------------------------------
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

  void getListCardCalonJamaah() async {
    var response = await http
        .get(Uri.parse("$urlAddress/info/dashboard/calon-jamaah"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    var dataList = {
      {
        "title": "Jamaah",
        "total": dataStatus[0]['TOTAL'].toString(),
      },
      {
        "title": "Konfirmasi",
        "total": dataStatus[0]['KONFIRMASI'].toString(),
      },
      {
        "title": "Belum Berangkat",
        "total": dataStatus[0]['BLM_BGKT'].toString(),
      },
      {
        "title": "Belum Lengkap",
        "total": dataStatus[0]['BLM_BGKT'].toString(),
      },
    };

    setState(() {
      listCardCalonJamaah = dataList.toList();
    });
  }

  void getJamaah() async {
    var response =
        await http.get(Uri.parse("$urlAddress/jamaah/all-jamaah"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listJamaah = dataStatus;
    });

    loadEnd();
  }

  @override
  void initState() {
    getAuth();
    getListCardCalonJamaah();
    getJamaah();
    super.initState();
  }

  // -------------------------------------------------------------------
  // ---------------------------- GET DATA -----------------------------
  // -------------------------------------------------------------------

  Widget cmdTambah() {
    return ElevatedButton.icon(
      onPressed: () async {
        authAddx == '1'
            ? setState(() {
                enableFormL = !enableFormL;
              })
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.add),
      style: fncButtonAuthStyle(authAddx, context),
      label: fncLabelButtonStyle('Tambah Data', context),
    );
  }

  Widget cmdPrint() {
    return ElevatedButton.icon(
      onPressed: () {
        authPrnt == '1'
            ? ''
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.print_outlined),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('Print', context),
    );
  }

  Widget cmdExport() {
    return ElevatedButton.icon(
      onPressed: () {
        authExpt == '1'
            ? ''
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.download_outlined),
      style: fncButtonAuthStyle(authExpt, context),
      label: fncLabelButtonStyle('Export', context),
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
                    cmdPrint(),
                    //---------------------------------
                    spacePemisah(),
                    //---------------------------------
                    cmdExport(),
                    //---------------------------------
                    spacePemisah(),
                  ],
                )),
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
        SizedBox(
          height: 120,
          width: screenWidth,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: listCardCalonJamaah.map((data) {
              return MyCardInfo(title: data['title'], total: data['total']);
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        menuButton(),
        const SizedBox(height: 10),
        Visibility(
            visible: enableFormL,
            child: Expanded(
              child: Container(
                  padding: const EdgeInsets.all(5),
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
                  child: const JamaahForm()),
            )),
        Visibility(
            visible: !enableFormL,
            child: Expanded(
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
                                'Informasi Data Jamaah',
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
                                      hintText: 'Cari Berdasarkan Nama'),
                                  onChanged: (value) {
                                    if (value == '') {
                                      getJamaah();
                                    } else {
                                      setState(() {
                                        listJamaah = listJamaah
                                            .where(((element) =>
                                                element['NAMA_LGKP']
                                                    .toString()
                                                    .toUpperCase()
                                                    .contains(
                                                        value.toUpperCase())))
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
                    Expanded(
                      child: TableMasterJamaah(dataJamaah: listJamaah),
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
