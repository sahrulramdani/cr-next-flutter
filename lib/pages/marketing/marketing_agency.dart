import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/constants/dummy.dart';
// import 'package:flutter_web_course/constants/dummy_marketing.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/export_agency.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/table_agency.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/form_agency.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/print_agency.dart';

class MarketingAgencyPage extends StatefulWidget {
  const MarketingAgencyPage({Key key}) : super(key: key);

  @override
  State<MarketingAgencyPage> createState() => _MarketingAgencyPageState();
}

class _MarketingAgencyPageState extends State<MarketingAgencyPage> {
  dynamic namaAgen;
  dynamic namaKantor;
  dynamic namaLeader;
  dynamic feeLevel;

  bool enableFormL = false;
  List<Map<String, dynamic>> listAgency = [];
  List<Map<String, dynamic>> listCardAgency = [];

  // -------------------------------------------------------------------
  // ---------------------------- GET DATA -----------------------------
  // -------------------------------------------------------------------

  void getAuth() async {
    var kode = 'MKT05';
    var response = await http
        .get(Uri.parse("$urlAddress/get-permission/$kode/$username"), headers: {
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

  void getAgency() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/all-agency"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataAgency =
        List.from(json.decode(response.body) as List);
    setState(() {
      listAgency = dataAgency;
    });
  }

  void getListCardAgency() async {
    var response =
        await http.get(Uri.parse("$urlAddress/info/dashboard/agency"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    var dataList = {
      {
        "title": "Agensi",
        "total": dataStatus[0]['TOTAL_MRKT'].toString(),
      },
      {
        "title": "Agen",
        "total": dataStatus[0]['TTL_AGEN'].toString(),
      },
      {
        "title": "Cabang",
        "total": dataStatus[0]['TTL_CABANG'].toString(),
      },
      {
        "title": "Tour Leader",
        "total": dataStatus[0]['TTL_TOURLEAD'].toString(),
      },
    };

    setState(() {
      listCardAgency = dataList.toList();
    });
  }

  @override
  void initState() {
    getAuth();
    getAgency();
    getListCardAgency();

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
    return PrintAgency(listAgency: listAgency);
  }

  Widget cmdExport() {
    return ExportAgency(listAgency: listAgency);
  }

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
        height: enableFormL != true ? 50 : 0,
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
              children: listCardAgency.map((data) {
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
                child: const AgencyForm(),
              )),
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
                                'Daftar Agency',
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
                                      setState(() {
                                        getAgency();
                                      });
                                    } else {
                                      setState(() {
                                        listAgency = listAgency
                                            .where(((element) =>
                                                element['nama_lengkap']
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
                    TableAgency(
                      dataAgency: listAgency,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
