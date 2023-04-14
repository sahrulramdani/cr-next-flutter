// ignore_for_file: must_call_super

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/hotel/modal_cd_hotel.dart';
import 'package:flutter_web_course/pages/marketing/widgets/hotel/table_hotel.dart';
import 'package:flutter_web_course/pages/marketing/widgets/maskapai/modal_cd_maskapai.dart';
import 'widgets/maskapai/table_maskapai.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'widgets/transit/modal_cd_transit.dart';
import 'package:http/http.dart' as http;

class MarketingHotel extends StatefulWidget {
  const MarketingHotel({Key key}) : super(key: key);

  @override
  State<MarketingHotel> createState() => _MarketingHotelState();
}

class _MarketingHotelState extends State<MarketingHotel> {
  List<Map<String, dynamic>> listHotel = [];

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
        .get(Uri.parse("$urlAddress/marketing/jadwal/getHotel"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listHotel = data;
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
    var idHotel = '';
    var tambah = true;
    return ElevatedButton.icon(
      onPressed: () async {
        authInqu == '1'
            ? showDialog(
                context: context,
                builder: (context) =>
                    ModalCdHotel(idHotel: idHotel, tambah: tambah))
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

  // Widget cmdPrint() {
  //   return ElevatedButton.icon(
  //     onPressed: () {
  //       // print(listAgency);
  //     },
  //     icon: const Icon(Icons.print_outlined),
  //     label: const Text(
  //       'Print',
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

  // Widget cmdExport() {
  //   return ElevatedButton.icon(
  //     onPressed: () {},
  //     icon: const Icon(Icons.download_outlined),
  //     label: const Text(
  //       'Export',
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

  Widget menuButton(context) => Container(
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
                    cmdTambah(context),
                    //---------------------------------
                    // spacePemisah(),
                    // //---------------------------------
                    // cmdPrint(),
                    // //---------------------------------
                    // spacePemisah(),
                    // //---------------------------------
                    // cmdExport(),
                    // //---------------------------------
                    // spacePemisah(),
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
          menuButton(context),
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
                // child: const SatuanForm(),
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
                                'Seluruh Hotel',
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
                                      hintText: 'Cari Nama Hotel'),
                                  onChanged: (value) {
                                    if (value == '') {
                                      getData();
                                    } else {
                                      setState(() {
                                        listHotel = listHotel
                                            .where(((element) =>
                                                element['NAMA_HTLX']
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
                    TableHotel(listHotel: listHotel),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
