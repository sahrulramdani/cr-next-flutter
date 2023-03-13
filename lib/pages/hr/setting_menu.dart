// ignore_for_file: must_call_super

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/modal_tambah_menu.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/table_daftar_menu.dart';
import 'package:flutter_web_course/pages/marketing/widgets/hotel/modal_cd_hotel.dart';
import 'package:flutter_web_course/pages/marketing/widgets/hotel/table_hotel.dart';
import 'package:flutter_web_course/pages/marketing/widgets/maskapai/modal_cd_maskapai.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;

class SettingMenu extends StatefulWidget {
  const SettingMenu({Key key}) : super(key: key);

  @override
  State<SettingMenu> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  bool enableFormL = false;
  List<Map<String, dynamic>> listModule = [];

  void getModuleAll() async {
    var response =
        await http.get(Uri.parse("$urlAddress/menu/daftar-menu/module-all"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listModule = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getModuleAll();
  }

  Widget cmdTambah(context) {
    // var idHotel = '';
    // var tambah = true;
    return ElevatedButton.icon(
      onPressed: () async {
        // setState(() {
        //   enableFormL = !enableFormL;
        // });
        showDialog(context: context, builder: (context) => ModalTambahMenu());
        // getList();
      },
      icon: const Icon(Icons.add),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
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
                      text: 'Pengaturan - ${menuController.activeItem.value}',
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
                                'Daftar Menu',
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
                                      hintText: 'Cari Nama Satuan'),
                                  onChanged: (value) {
                                    // if (value == '') {
                                    //   listAgency = listAgency;
                                    //   getList();
                                    // } else {
                                    //   setState(() {
                                    //     listAgency = listAgency
                                    //         .where((element) =>
                                    //             element['NAMA_LGKP']
                                    //                 .contains(value))
                                    //         .toList();
                                    //   });
                                    // }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TableMenu(listMenu: listModule),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
