// ignore_for_file: missing_return, deprecated_member_use, avoid_print
import 'dart:convert';

import 'package:flutter_web_course/models/http_barang.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';

class BarangForm extends StatefulWidget {
  const BarangForm({Key key}) : super(key: key);

  @override
  State<BarangForm> createState() => _BarangFormState();
}

class _BarangFormState extends State<BarangForm> {
  String namaBarang;
  String idSatuan;
  String namaSatuan;
  String stokAwal;
  String statusBrg;
  String hargaBeli;
  String hargaJual;
  String keterangan;

  List<Map<String, dynamic>> listSatuan = [];

  void getSatuan() async {
    var response = await http
        .get(Uri.parse("$urlAddress/inventory/satuan/getAllSatuan"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listSatuan = data;
    });
  }

  @override
  void initState() {
    getSatuan();
    super.initState();
  }

  Widget inputKodeBarang() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Kode Barang',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      initialValue: "Auto Generate",
    );
  }

  Widget inputNamaBarang() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Nama Barang',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      onChanged: ((value) {
        namaBarang = value;
      }),
      // onChanged: (value) {

      // },
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
        selectedItem: "Pilih Satuan",
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_STAN'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaSatuan ?? "Pilih Paket"),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
        validator: (value) {
          if (value == "Pilih Jenis Kelamin") {
            return "Jenis Kelamin masih kosong !";
          }
        },
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
        hoverColor: Colors.white,
      ),
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
            statusBrg = '1';
          } else {
            statusBrg = '0';
          }
        },
        selectedItem: "Pilih Status Barang",
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
        validator: (value) {
          if (value == "Pilih Status Barang") {
            return "Status Barang masih kosong !";
          }
        },
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
        hoverColor: Colors.white,
      ),
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
        hoverColor: Colors.white,
      ),
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
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      onChanged: (value) {
        keterangan = value;
      },
    );
  }

  fncSaveData() async {
    var response1 = await http
        .get(Uri.parse("$urlAddress/inventory/barang/get-id"), headers: {
      'pte-token': kodeToken,
    });
    dynamic body1 = json.decode(response1.body);
    String noBarang = body1['idBarang'];

    HttpBarang.saveBarang(noBarang, namaBarang, idSatuan, stokAwal, hargaBeli,
            hargaJual, keterangan)
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
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tambah Data Baru',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: myBlue),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox(width: 20)),
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
                  minimumSize: const Size(100, 40),
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  menuController.changeActiveitemTo('Barang');
                  navigationController.navigateTo('/inventory/barang');
                },
                icon: const Icon(Icons.cancel),
                label: const Text(
                  'Batal',
                  style: TextStyle(fontFamily: 'Gilroy'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: myBlue,
                  minimumSize: const Size(100, 40),
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
