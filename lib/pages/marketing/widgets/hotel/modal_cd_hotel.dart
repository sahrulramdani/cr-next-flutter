// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print, must_be_immutable, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter_web_course/models/http_hotel.dart';
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

class ModalCdHotel extends StatefulWidget {
  final String idHotel;
  final bool tambah;
  String bintang;

  ModalCdHotel(
      {Key key,
      @required this.idHotel,
      @required this.tambah,
      @required this.bintang})
      : super(key: key);

  @override
  State<ModalCdHotel> createState() => _ModalCdHotelState();
}

class _ModalCdHotelState extends State<ModalCdHotel> {
  String idHotel;
  String namaHotel;
  String lokasi;
  String alamat;
  String bintang;
  String idBintang;
  String idKategori;
  String namaKategori;

  List<Map<String, dynamic>> listBintgHtl = [];
  List<Map<String, dynamic>> listKategori = [];

  void getDetailHotel() async {
    var id = widget.idHotel;
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/hotel/getDetailHotel/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      idHotel = data[0]['IDXX_HTLX'];
      namaHotel = data[0]['NAMA_HTLX'];
      lokasi = data[0]['LOKX_HTLX'];
      alamat = data[0]['ALMT_HTLX'];
      namaHotel = data[0]['NAMA_HTLX'];
      bintang = data[0]['CODD_DESC'].toString();
      idBintang = data[0]['BINTG_HTLX'].toString();
      idKategori = data[0]['KTGR_HTLX'].toString();
      namaKategori = data[0]['NAMA_KTGR'].toString();
    });
  }

  void getBintangHtl() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/hotel/getBintangHtl"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listBintgHtl = data;
    });
  }

  void getKategori() async {
    var response = await http
        .get(Uri.parse('$urlAddress/marketing/hotel/getKategori'), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKategori = data;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.tambah != true) {
      getDetailHotel();
    }

    getBintangHtl();
    getKategori();
  }

  Widget inputNamaHotel() {
    return TextFormField(
      initialValue: namaHotel ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        namaHotel = value;
      }),
      decoration: const InputDecoration(
        label: Text('Nama Hotel', style: TextStyle(color: Colors.red)),
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Hotel masih kosong !";
        }
      },
    );
  }

  Widget inputLokasi() {
    return TextFormField(
      initialValue: lokasi ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        lokasi = value;
      }),
      decoration: const InputDecoration(
        hintText: 'Mekkah / Madinah / Jeddah',
        label: Text('Lokasi Hotel', style: TextStyle(color: Colors.red)),
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Lokasi masih kosong !";
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

  Widget inputBintangHotel() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Bintang Hotel",
        mode: Mode.MENU,
        items: listBintgHtl,
        onChanged: (value) {
          bintang = value["CODD_DESC"];
          idBintang = value["CODD_VALU"];
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            bintang ?? "Pilih Bintang",
            style:
                TextStyle(color: bintang == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
        validator: (value) {
          if (value == "Pilih Bintang") {
            return "Bintang Hotel kosong !";
          }
        },
      ),
    );
  }

  Widget inputKategori() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Kategori",
        mode: Mode.MENU,
        items: listKategori,
        onChanged: (value) {
          namaKategori = value["CODD_DESC"];
          idKategori = value["CODD_VALU"];
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            namaKategori ?? "Pilih Kategori",
            style: TextStyle(
                color: namaKategori == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
        validator: (value) {
          if (value == "Pilih Kategori") {
            return "Kategori kosong !";
          }
        },
      ),
    );
  }

  fncSaveData(context) {
    if (widget.tambah == true) {
      HttpHotel.saveHotel(
        namaHotel,
        idBintang,
        lokasi,
        alamat ?? '',
        idKategori,
      ).then((value) {
        if (value.status == true) {
          Navigator.pop(context);

          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Master Hotel');
          navigationController.navigateTo('/mrkt/hotel');
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      });
    } else {
      HttpHotel.updateHotel(
        idHotel,
        namaHotel,
        idBintang,
        lokasi,
        alamat ?? '',
        idKategori,
      ).then((value) {
        if (value.status == true) {
          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Master Hotel');
          navigationController.navigateTo('/mrkt/hotel');
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
                              ? "Tambah Data Hotel"
                              : "Ubah Data Hotel",
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
                      inputNamaHotel(),
                      const SizedBox(height: 8),
                      inputBintangHotel(),
                      const SizedBox(height: 8),
                      inputLokasi(),
                      const SizedBox(height: 8),
                      inputAlamat(),
                      const SizedBox(height: 8),
                      inputKategori(),
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
