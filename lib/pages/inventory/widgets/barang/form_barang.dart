// ignore_for_file: missing_return, deprecated_member_use
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';

class BarangForm extends StatefulWidget {
  const BarangForm({Key key}) : super(key: key);

  @override
  State<BarangForm> createState() => _BarangFormState();
}

class _BarangFormState extends State<BarangForm> {
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
        items: const ["BOX", "BUAH", "LUSIN", "METER", "PAX", "PCS"],
        onChanged: print,
        selectedItem: "Pilih Satuan",
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
        onChanged: print,
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
    );
  }

  fncSaveData() {
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Barang');
    navigationController.navigateTo('/inventory/barang');
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
