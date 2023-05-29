// ignore_for_file: must_call_super, missing_return, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/header_title_menu.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/models/http_musim.dart';
import 'package:flutter_web_course/pages/pengaturan/widget/musim/table_musim.dart';
import 'package:get/get.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SettingMusim extends StatefulWidget {
  const SettingMusim({Key key}) : super(key: key);

  @override
  State<SettingMusim> createState() => _SettingMusimState();
}

class _SettingMusimState extends State<SettingMusim> {
  List<Map<String, dynamic>> listMusim = [];

  TextEditingController dateAwal = TextEditingController();
  TextEditingController dateAkhir = TextEditingController();

  TextEditingController musimAwal = new TextEditingController();
  TextEditingController musimAkhir = new TextEditingController();

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

  void getMusimBerjalan() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/musim-berjalan"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    if (data.isNotEmpty) {
      setState(() {
        musimAwal.text = fncGetTanggal(data[0]['AWAL_MUSM']);
        musimAkhir.text = fncGetTanggal(data[0]['AKHR_MUSM']);
      });
    }
  }

  void getMusimAll() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/all-musim"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    if (data.isNotEmpty) {
      setState(() {
        listMusim = data;
      });
    }
  }

  @override
  void initState() {
    getAuth();
    getMusimBerjalan();
    getMusimAll();
    super.initState();
  }

  Widget inputTglAwal() {
    return TextFormField(
      controller: dateAwal,
      decoration: const InputDecoration(
        label: Text('Tanggal Awal'),
        hintText: 'DD-MM-YYYY',
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateAwal.text = formattedDate;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tgl Awal masih kosong !";
        }
      },
    );
  }

  Widget inputTglAkhir() {
    return TextFormField(
      controller: dateAkhir,
      decoration: const InputDecoration(
        label: Text('Tanggal Akhir'),
        hintText: 'DD-MM-YYYY',
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateAkhir.text = formattedDate;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tgl Akhir masih kosong !";
        }
      },
    );
  }

  Widget cmdTambah() {
    return ElevatedButton.icon(
      onPressed: () async {
        if (dateAwal.text != '') {
          if (dateAkhir.text != '') {
            HttpMusim.saveMusim(
              fncTanggal(dateAwal.text),
              fncTanggal(dateAkhir.text),
            ).then(
              (value) {
                if (value.status == true) {
                  showDialog(
                      context: context,
                      builder: (context) => const ModalSaveSuccess());

                  menuController.changeActiveitemTo('Pengaturan Musim');
                  navigationController.navigateTo('/setting/pengaturan-musim');
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => const ModalSaveFail());
                }
              },
            );
          }
        }
      },
      icon: const Icon(Icons.add),
      style: fncButtonAuthStyle('1', context),
      label: fncLabelButtonStyle('Tambah Musim Baru', context),
    );
  }

  Widget inputMusimAwal() {
    return TextFormField(
      decoration: const InputDecoration(
        label: Text('Musim Awal'),
        hintText: 'DD-MM-YYYY',
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      controller: musimAwal,
      readOnly: true,
    );
  }

  Widget inputMusimAkhir() {
    return TextFormField(
      decoration: const InputDecoration(
        label: Text('Musim Akhir'),
        hintText: 'DD-MM-YYYY',
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      controller: musimAkhir,
      readOnly: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Obx(() => HeaderTitleMenu(menu: menuController.activeItem.value)),
        const SizedBox(height: 10),
        Container(
          width: screenWidth,
          padding: const EdgeInsets.all(15),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 220, child: inputTglAwal()),
                  const SizedBox(width: 10),
                  SizedBox(width: 220, child: inputTglAkhir()),
                  Expanded(child: Container()),
                  const SizedBox(width: 5),
                  cmdTambah(),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: screenWidth,
          padding: const EdgeInsets.all(15),
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
              Text(
                'Tanggal Musim Berjalan',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: myBlue),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: SizedBox(child: inputMusimAwal())),
                  const SizedBox(width: 10),
                  Expanded(child: SizedBox(child: inputMusimAkhir())),
                ],
              )
            ],
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
                            'Seluruh Musim',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: myBlue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(child: TableMusim(listMusim: listMusim)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
