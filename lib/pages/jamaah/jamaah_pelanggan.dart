import 'package:flutter_web_course/comp/header_title_menu.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/table_pelanggan.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JamaahPelangganPage extends StatefulWidget {
  const JamaahPelangganPage({Key key}) : super(key: key);

  @override
  State<JamaahPelangganPage> createState() => _JamaahPelangganPageState();
}

class _JamaahPelangganPageState extends State<JamaahPelangganPage> {
  List<Map<String, dynamic>> listCardPelanggan = [];
  List<Map<String, dynamic>> listPelanggan = [];

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

  void getListCardDaftarJamaah() async {
    var response = await http
        .get(Uri.parse("$urlAddress/info/dashboard/daftar-jamaah"), headers: {
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
        "title": "Paspor",
        "total": dataStatus[0]['PASPOR'].toString(),
      },
      {
        "title": "Sudah Handling",
        "total": dataStatus[0]['HANDLING'].toString(),
      },
      {
        "title": "Belum Handling",
        "total": dataStatus[0]['BLM_HAND'].toString(),
      },
    };

    setState(() {
      listCardPelanggan = dataList.toList();
    });
  }

  void getPelanggan() async {
    var response =
        await http.get(Uri.parse("$urlAddress/jamaah/all-pelanggan"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listPelanggan = dataStatus;
    });

    loadEnd();
  }

  @override
  void initState() {
    getAuth();
    getListCardDaftarJamaah();
    getPelanggan();
    super.initState();
  }

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
            children: listCardPelanggan.map((data) {
              return MyCardInfo(title: data['title'], total: data['total']);
            }).toList(),
          ),
        ),
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
                            'Daftar Jamaah',
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ResponsiveWidget.isSmallScreen(context)
                              ? const SizedBox(
                                  width: 0,
                                )
                              : SizedBox(
                                  height: 40,
                                  width: 230,
                                  child: DropdownSearch(
                                    mode: Mode.MENU,
                                    items: const [
                                      "Filter",
                                      "Evaluasi Pembayaran",
                                      "Jadwal Pasporan",
                                      "Belum Handling",
                                      "Belum Persyaratan",
                                      "Belum Pasporan",
                                    ],
                                    onChanged: print,
                                    selectedItem: "Filter",
                                  ),
                                ),
                          const SizedBox(width: 10),
                          ResponsiveWidget.isSmallScreen(context)
                              ? const SizedBox(
                                  width: 0,
                                )
                              : SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: DropdownSearch(
                                    mode: Mode.MENU,
                                    items: const [
                                      "Semua",
                                      "Pusat",
                                      "Turangga",
                                      "Tasikmalaya",
                                      "KPRK Garut",
                                      "KPRK Tasikmalaya",
                                      "KPRK Karawang",
                                      "KPRK Purwakarta",
                                      "KPRK Cirebon",
                                    ],
                                    onChanged: print,
                                    selectedItem: "Semua",
                                  ),
                                ),
                          Container(
                            height: 50,
                            width: fncWidthSearchBox(context),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontFamily: 'Gilroy', fontSize: 14),
                              decoration: const InputDecoration(
                                  hintText: 'Cari Berdasarkan Nama'),
                              onChanged: (value) {
                                if (value == '') {
                                  getPelanggan();
                                } else {
                                  setState(() {
                                    listPelanggan = listPelanggan
                                        .where(((element) =>
                                            element['NAMA_LGKP']
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
                Expanded(child: TablePelanggan(dataPelanggan: listPelanggan)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
