// ignore_for_file: missing_return, deprecated_member_use, avoid_print
import 'dart:convert';

import 'package:flutter_web_course/models/http_barang.dart';
import 'package:flutter_web_course/models/http_kasbank.dart';
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

class CaraBayarForm extends StatefulWidget {
  const CaraBayarForm({Key key}) : super(key: key);

  @override
  State<CaraBayarForm> createState() => _CaraBayarFormState();
}

class _CaraBayarFormState extends State<CaraBayarForm> {
  List<Map<String, dynamic>> listAccount = [];
  List<Map<String, dynamic>> listMataUang = [];

  String namaBank;
  String alamat;
  String idAkun;
  String descIdAkun;
  String nomorRekening;
  String mataUang;
  String idMataUang;
  String noTelp;
  String noFax;
  String idJenis;
  String descIdJenis;

  getAllAccount() async {
    var response =
        await http.get(Uri.parse("$urlAddress/finance/all-account"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listAccount = dataStatus;
    });
  }

  void getMataUang() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getmatauang"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listMataUang = data;
    });
  }

  @override
  void initState() {
    getAllAccount();
    getMataUang();
    super.initState();
  }

  Widget inputKodeBayar() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Kode Bayar',
      ),
      initialValue: "Auto Generate",
    );
  }

  Widget inputNamaBayar() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text('Cara Bayar', style: TextStyle(color: Colors.red))),
      onChanged: ((value) {
        namaBank = value;
      }),
      initialValue: namaBank,
      validator: (value) {
        if (value.isEmpty) {
          return "Cara Bayar masih kosong !";
        }
      },
    );
  }

  Widget inputJenisPembayaran() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Jenis Pembayaran",
        mode: Mode.MENU,
        items: const ["Tunai", "Bank"],
        onChanged: (value) {
          if (value == "Tunai") {
            idJenis = '0';
            descIdJenis = value;
          } else {
            idJenis = '1';
            descIdJenis = value;
          }
        },
        dropdownBuilder: (context, selectedItem) => Text(
            descIdJenis ?? "Pilih Jenis Pembayaran",
            style: TextStyle(
                color: descIdJenis == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Jenis Pembayaran") {
            return "Jenis Kas/Bank masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputAlamat() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Alamat',
      ),
      onChanged: ((value) {
        alamat = value;
      }),
    );
  }

  Widget inputAccount() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Induk Account",
        items: listAccount,
        onChanged: (value) {
          idAkun = value['KDXX_COAX'];
          descIdAkun = value['COAX_LBEL'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['COAX_LBEL'].toString() ?? '-'),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            descIdAkun ?? "Pilih Account",
            style: TextStyle(
                color: descIdAkun == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Account") {
            return "Account masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputNomorRekening() {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(label: Text('Nomor Rekening')),
      onChanged: (value) {
        nomorRekening = value;
      },
    );
  }

  Widget inputMataUang() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Mata Uang",
        mode: Mode.MENU,
        items: listMataUang,
        onChanged: (value) {
          mataUang = value["CODD_DESC"];
          idMataUang = value["CODD_VALU"];
        },
        selectedItem: "Pilih Mata Uang",
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
          mataUang ?? "Pilih Mata Uang",
          style: TextStyle(color: mataUang == null ? Colors.red : Colors.black),
        ),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Mata Uang") {
            return "Mata Uang masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputNoTelp() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Nomor Telp', hintText: '08XXXXXXXXXX'),
      onChanged: ((value) {
        noTelp = value;
      }),
    );
  }

  Widget inputNoFax() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Nomor Fax', hintText: '021-XXXXXXXXX'),
      onChanged: ((value) {
        noTelp = value;
      }),
    );
  }

  fncSaveData() async {
    // GET NOMOR FAKTUR
    var response1 = await http.get(
        Uri.parse("$urlAddress/finance/all-carabayar/generate-number"),
        headers: {
          'pte-token': kodeToken,
        });
    dynamic body1 = json.decode(response1.body);
    String noBank = body1['idKasBank'];

    HttpKasBank.saveKasBank(
      'TYPE_BYRX',
      noBank,
      namaBank,
      idJenis,
      idAkun,
      idMataUang,
      nomorRekening ?? '',
      alamat ?? '',
      noTelp ?? '',
      noFax ?? '',
    ).then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());

        menuController.changeActiveitemTo('Pembuatan Cara Bayar');
        navigationController.navigateTo('/finance/pembuatan-carabayar');
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
                  if (formKey.currentState.validate()) {
                    fncSaveData();
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
                  minimumSize: const Size(100, 40),
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  menuController.changeActiveitemTo('Pembuatan Kas dan Bank');
                  navigationController.navigateTo('/finance/pembuatan-kasbank');
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
                            inputKodeBayar(),
                            const SizedBox(height: 8),
                            inputNamaBayar(),
                            const SizedBox(height: 8),
                            inputJenisPembayaran(),
                            const SizedBox(height: 8),
                            inputAccount(),
                            const SizedBox(height: 8),
                            inputNomorRekening(),
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
                            inputAlamat(),
                            const SizedBox(height: 8),
                            inputMataUang(),
                            const SizedBox(height: 8),
                            inputNoTelp(),
                            const SizedBox(height: 8),
                            inputNoFax(),
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
