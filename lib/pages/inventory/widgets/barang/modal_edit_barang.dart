// ignore_for_file: deprecated_member_use, missing_return, must_be_immutable, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/models/http_barang.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

import '../../../../comp/modal_save_fail.dart';

class ModalEditBarang extends StatefulWidget {
  String idBarang;
  ModalEditBarang({Key key, @required this.idBarang}) : super(key: key);

  @override
  State<ModalEditBarang> createState() => _ModalEditBarangState();
}

class _ModalEditBarangState extends State<ModalEditBarang> {
  NumberFormat myformat = NumberFormat.decimalPattern('en_us');
  String kodeBarang;
  String namaBarang;
  String idSatuan;
  String namaSatuan;
  String stokAwal;
  String status;
  String hargaBeli;
  String hargaJual;
  String keterangan;

  List<Map<String, dynamic>> listSatuan = [];

  void getSatuan() async {
    var response =
        await http.get(Uri.parse("$urlAddress/inventory/satuan/getAllSatuan"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listSatuan = data;
    });
  }

  void getDetailBarang() async {
    var id = widget.idBarang;
    var response =
        await http.get(Uri.parse("$urlAddress/inventory/barang/getdetail/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      kodeBarang = data[0]['KDXX_BRGX'];
      namaBarang = data[0]['NAMA_BRGX'];
      idSatuan = data[0]['JENS_STUA'];
      namaSatuan = data[0]['NAMA_STAN'];
      stokAwal = data[0]['STOK_BRGX'].toString();
      status = data[0]['STAT_BRG'].toString();
      hargaBeli = myformat.format(data[0]['HRGX_BELI']);
      hargaJual = myformat.format(data[0]['HRGX_JUAL']);
      keterangan = data[0]['KETERANGAN'].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getDetailBarang();
    getSatuan();
  }

  Widget inputKodeBarang() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Kode Barang',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: kodeBarang,
    );
  }

  Widget inputNamaBarang() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Nama Barang',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        namaBarang = value;
      },
      initialValue: namaBarang,
    );
  }

  Widget inputSatuan() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Satuan",
        mode: Mode.MENU,
        items: listSatuan,
        onChanged: (value) {
          idSatuan = value['IDXX_STAN'];
          namaSatuan = value['NAMA_STAN'];
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_STAN'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaSatuan ?? "Pilih Satuan"),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
        // validator: (value) {
        //   if (value == "Pilih Status Barang") {
        //     return "Status Barang masih kosong !";
        //   }
        // },
      ),
    );
  }

  Widget inputStokBarang() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Stok Awal Barang',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: stokAwal,
      onChanged: (value) {
        stokAwal = value;
      },
    );
  }

  Widget inputStatusBarang() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Status Barang",
        mode: Mode.MENU,
        items: const ["Aktif", "Nonaktif"],
        onChanged: (value) {
          if (value == "Aktif") {
            status = '1';
          } else {
            status = '0';
          }
        },
        dropdownBuilder: (context, selectedItem) =>
            Text(status == '1' ? 'Aktif' : 'Nonaktif' ?? "Pilih Mata Uang"),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
    );
  }

  Widget inputHargaBeli() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Harga Beli',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: hargaBeli,
      onChanged: (value) {
        hargaBeli = value;
      },
    );
  }

  Widget inputHargaJual() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Harga Jual',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: hargaJual,
      onChanged: (value) {
        hargaJual = value;
      },
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Keterangan',
          fillColor: Colors.white,
          filled: true,
          hoverColor: Colors.white),
      initialValue: keterangan,
      onChanged: (value) {
        keterangan = value;
      },
    );
  }

  fncSaveData() {
    // print("KODE BARANG : $kodeBarang");
    // print("NAMA BARANG : $namaBarang");
    // print("ID SATUAN : $idSatuan");
    // print("STOK AWAL : $stokAwal");
    // print("STATUS : $status");
    // print("HARGA BELI : $hargaBeli");
    // print("HARGA JUAL : $hargaJual");
    // print("KETERANGAN : $keterangan");
    HttpBarang.updateBarang(kodeBarang, namaBarang, idSatuan, stokAwal,
            hargaBeli, hargaJual, status, keterangan)
        .then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());

        menuController.changeActiveitemTo('Barang');
        navigationController.navigateTo('/inventory/barang');
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
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
            width: screenWidth * 0.81,
            height: 400,
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
                      Text('Ubah Barang $namaBarang',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 525,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                inputKodeBarang(),
                                const SizedBox(height: 8),
                                inputNamaBarang(),
                                const SizedBox(height: 8),
                                inputSatuan(),
                                const SizedBox(height: 8),
                                inputStokBarang(),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            width: 525,
                            child: Column(
                              children: [
                                inputStatusBarang(),
                                const SizedBox(height: 8),
                                inputHargaBeli(),
                                const SizedBox(height: 8),
                                inputHargaJual(),
                                const SizedBox(height: 8),
                                inputKeterangan(),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          fncSaveData();
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
