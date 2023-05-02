// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/export_jadwal.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/form_jadwal.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_jadwal.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/table_jadwal_jamaah.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/pages/marketing/widgets/table_agency.dart';
// import 'package:flutter_web_course/pages/marketing/widgets/form_agency.dart';
// import 'package:flutter_web_course/pages/marketing/widgets/print_agency.dart';

class MarketingJadwalPage extends StatefulWidget {
  const MarketingJadwalPage({Key key}) : super(key: key);

  @override
  State<MarketingJadwalPage> createState() => _MarketingJadwalPageState();
}

class _MarketingJadwalPageState extends State<MarketingJadwalPage> {
  bool enableFormL = false;
  List<Map<String, dynamic>> listJadwal = [];
  List<Map<String, dynamic>> listJadwalAktif = [];
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

  void getListCardJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/info/dashboard/jadwal"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    var dataList = {
      {
        "title": "Umroh Reguler",
        "total": dataStatus[0]['UMROH_REGULER'].toString(),
      },
      {
        "title": "Umroh Plus",
        "total": dataStatus[0]['UMROH_PLUS'].toString(),
      },
      {
        "title": "Haji Furoda",
        "total": dataStatus[0]['HAJI_FURODA'].toString(),
      },
      {
        "title": "Haji Plus",
        "total": dataStatus[0]['HAJI_PLUS'].toString(),
      },
    };

    setState(() {
      listCardJadwal = dataList.toList();
    });
  }

  void getAllJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getAllJadwal"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = data;
      listJadwalAktif =
          data.where(((element) => element['STATUS'] == 0)).toList();
    });

    loadEnd();
  }

  @override
  void initState() {
    getAuth();
    getListCardJadwal();
    getAllJadwal();
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
    return PrintJadwal(listJadwal: listJadwalAktif);
  }

  Widget cmdExport() {
    return ExportJadwal(listJadwal: listJadwal);
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: 'Marketing - ${menuController.activeItem.value}',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 120,
            width: screenWidth,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: listCardJadwal.map((data) {
                return MyCardInfo(title: data['title'], total: data['total']);
              }).toList(),
            ),
          ),
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
                  child: const JadwalForm())),
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
                                'Seluruh Jadwal',
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
                    TableJadwalJamaah(dataJadwal: listJadwal),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
