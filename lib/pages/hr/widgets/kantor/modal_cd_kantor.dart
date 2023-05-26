// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print, must_be_immutable, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter_web_course/models/http_hotel.dart';
import 'package:flutter_web_course/models/http_kantor.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalCdKantor extends StatefulWidget {
  final String idKantor;
  final bool tambah;

  const ModalCdKantor({Key key, @required this.idKantor, @required this.tambah})
      : super(key: key);

  @override
  State<ModalCdKantor> createState() => _ModalCdKantorState();
}

class _ModalCdKantorState extends State<ModalCdKantor> {
  String idKantor;
  String jenisKantor;
  String namaKantor;
  String alamat;
  String telp;

  void getDetailKantor() async {
    var id = widget.idKantor;
    var response =
        await http.get(Uri.parse("$urlAddress/hr/kantor/detail/$id"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      idKantor = data[0]['IDXX_HTLX'];
      jenisKantor = data[0]['JENS_KNTR'];
      namaKantor = data[0]['NAMA_KNTR'];
      alamat = data[0]['ALMT_KNTR'];
      telp = data[0]['TELP_KNTR'];
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.tambah != true) {
      getDetailKantor();
    }
  }

  Widget inputJenisKantor() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Jenis Kantor",
          mode: Mode.MENU,
          items: const [
            "Pusat",
            "Cabang",
            "Pos",
            "Gudang",
          ],
          onChanged: (value) {
            jenisKantor = value;
          },
          dropdownBuilder: (context, selectedItem) => Text(
              jenisKantor ?? "Jenis Kantor",
              style: TextStyle(
                  color: jenisKantor == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hoverColor: Colors.white,
          )),
    );
  }

  Widget inputNamaKantor() {
    return TextFormField(
      initialValue: namaKantor ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        namaKantor = value;
      }),
      decoration: const InputDecoration(
        label: Text('Nama Kantor', style: TextStyle(color: Colors.red)),
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Kantor masih kosong !";
        }
      },
    );
  }

  Widget inputAlamat() {
    return TextFormField(
      initialValue: alamat ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        alamat = value;
      }),
      decoration: const InputDecoration(
        labelText: 'Alamat Hotel',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
    );
  }

  Widget inputNoTelp() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Nomor Telepon',
        hintText: "08xxxxxxxxxxx",
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      onChanged: (value) {
        telp = value;
      },
      initialValue: telp,
    );
  }

  fncSaveData(context) {
    if (widget.tambah == true) {
      HttpKantor.saveKantor(
        jenisKantor,
        namaKantor,
        alamat ?? '',
        telp ?? '',
      ).then((value) {
        if (value.status == true) {
          Navigator.pop(context);

          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Master Kantor');
          navigationController.navigateTo('/hr/kantor');
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      });
    } else {
      HttpKantor.updateKantor(
        idKantor,
        jenisKantor,
        namaKantor,
        alamat ?? '',
        telp ?? '',
      ).then((value) {
        if (value.status == true) {
          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Master Kantor');
          navigationController.navigateTo('/hr/kantor');
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.5,
            height: 460,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text(
                          widget.tambah == true
                              ? "Tambah Data Kantor"
                              : "Ubah Data Kantor",
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      inputJenisKantor(),
                      const SizedBox(height: 8),
                      inputNamaKantor(),
                      const SizedBox(height: 8),
                      inputAlamat(),
                      const SizedBox(height: 8),
                      inputNoTelp(),
                    ],
                  ),
                )),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            fncSaveData(context);
                          } else {
                            return null;
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text(
                          'Simpan Data',
                          style: TextStyle(fontFamily: 'Gilroy'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myBlue,
                          shadowColor: Colors.grey,
                          elevation: 5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Kembali'))
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
