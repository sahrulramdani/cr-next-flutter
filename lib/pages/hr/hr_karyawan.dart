import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/dummy_karyawan.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/hr/widgets/karyawan/form_karyawan.dart';
import 'package:flutter_web_course/pages/hr/widgets/karyawan/table_karyawan.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/print_agency.dart';

class HrKaryawanPage extends StatefulWidget {
  const HrKaryawanPage({Key key}) : super(key: key);

  @override
  State<HrKaryawanPage> createState() => _HrKaryawanPageState();
}

class _HrKaryawanPageState extends State<HrKaryawanPage> {
  bool enableFormL = false;
  List<Map<String, dynamic>> listKaryawan = dummyKaryawanTable;
  List<Map<String, dynamic>> listProvinsi = [];

  void getProvinsi() async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listProvinsi = dataStatus;
    });
  }

  @override
  void initState() {
    getProvinsi();
    super.initState();
  }

  Widget cmdTambah() {
    return ElevatedButton.icon(
      onPressed: () async {
        setState(() {
          enableFormL = !enableFormL;
        });
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

  Widget cmdPrint() {
    return PrintAgency(
        // listKaryawan: listKaryawan,
        );
  }

  Widget cmdExport() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.download_outlined),
      label: const Text(
        'Export',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
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
                      text: 'HR - ${menuController.activeItem.value}',
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
              children: listCardKaryawan.map((data) {
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
                child: KaryawanForm(
                  listProvinsi: listProvinsi,
                ),
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
                                'Daftar Karyawan',
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
                                        listKaryawan = dummyKaryawanTable;
                                      });
                                    } else {
                                      setState(() {
                                        listKaryawan = dummyKaryawanTable
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
                    TableKaryawan(
                      dataKaryawan: listKaryawan,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
