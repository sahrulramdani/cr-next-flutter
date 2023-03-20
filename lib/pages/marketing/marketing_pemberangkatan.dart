import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/constants/dummy.dart';
// import 'package:flutter_web_course/constants/dummy_jadwal.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/pemberangkatan/table_pemberangkatan.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_course/constants/style.dart';

class MarketingBerangkatPage extends StatefulWidget {
  const MarketingBerangkatPage({Key key}) : super(key: key);

  @override
  State<MarketingBerangkatPage> createState() => _MarketingBerangkatPageState();
}

class _MarketingBerangkatPageState extends State<MarketingBerangkatPage> {
  List<Map<String, dynamic>> listPemberangkatan = [];
  List<Map<String, dynamic>> listCardPemberangkatan = [];

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

  void getListCardPemberangkatan() async {
    var response = await http
        .get(Uri.parse("$urlAddress/info/dashboard/pemberangkatan"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    var dataList = {
      {
        "title": "Berangkat",
        "total": dataStatus[0]['TOTAL_PEMBERANGKATAN'].toString(),
      },
      {
        "title": "Bulan Ini",
        "total": dataStatus[0]['BULAN_INI'].toString(),
      },
      {
        "title": "Bulan Depan",
        "total": dataStatus[0]['BULAN_DEPAN'].toString(),
      },
      {
        "title": "Sudah full",
        "total": dataStatus[0]['SUDAH_FULL'].toString(),
      },
    };

    setState(() {
      listCardPemberangkatan = dataList.toList();
    });
  }

  void getAllPemberangkatan() async {
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/pemberangkatan/all-pemberangkatan"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listPemberangkatan = data;
    });

    loadEnd();
  }

  @override
  void initState() {
    getAuth();
    getListCardPemberangkatan();
    getAllPemberangkatan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(children: [
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
            children: listCardPemberangkatan.map((data) {
              return MyCardInfo(title: data['title'], total: data['total']);
            }).toList(),
          ),
        ),
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
                          'Daftar Pemberangkatan',
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
                                hintText: 'Cari Berdasarkan Jenis Paket'),
                            onChanged: (value) {
                              if (value == '') {
                                getAllPemberangkatan();
                              } else {
                                setState(() {
                                  listPemberangkatan = listPemberangkatan
                                      .where(((element) => element['jenisPaket']
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
              TablePemberangkatan(dataPemberangkatan: listPemberangkatan),
            ],
          ),
        )
      ]),
    );
  }
}
