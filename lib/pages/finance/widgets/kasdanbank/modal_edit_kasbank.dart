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
import 'package:flutter_web_course/models/http_kasbank.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

import '../../../../comp/modal_save_fail.dart';

class ModalEditKasBank extends StatefulWidget {
  String idKasBank;
  ModalEditKasBank({Key key, @required this.idKasBank}) : super(key: key);

  @override
  State<ModalEditKasBank> createState() => _ModalEditKasBankState();
}

class _ModalEditKasBankState extends State<ModalEditKasBank> {
  List<Map<String, dynamic>> listAccount = [];
  List<Map<String, dynamic>> listMataUang = [];

  String kodeBank;
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

  List<Map<String, dynamic>> listSatuan = [];

  void getDetailKasBank() async {
    var id = widget.idKasBank;
    var response = await http.get(
        Uri.parse("$urlAddress/finance/kas-bank/detail/$id/KASX_BANK"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      kodeBank = data[0]['KODE_BANK'];
      namaBank = data[0]['NAMA_BANK'];
      alamat = data[0]['ALMT_BANK'];
      idAkun = data[0]['ACCT_CODE'];
      descIdAkun = data[0]['DESKRIPSI'];
      nomorRekening = data[0]['NOXX_REKX'];
      mataUang = data[0]['CODD_DESC'];
      idMataUang = data[0]['CURR_MNYX'];
      noTelp = data[0]['NOXX_TELP'];
      noFax = data[0]['NOXX_FAXX'];
      idJenis = data[0]['CHKX_BANK'];
      descIdJenis = data[0]['CHKX_BANK'] == '1' ? 'Bank' : 'Kas';
    });
  }

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
    super.initState();
    getDetailKasBank();
    getAllAccount();
    getMataUang();
  }

  Widget inputKodeBank() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Kode Bank',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: kodeBank ?? "Auto Generate",
    );
  }

  Widget inputNamaBank() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text('Nama Bank', style: TextStyle(color: Colors.red)),
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: ((value) {
        namaBank = value;
      }),
      initialValue: namaBank,
      validator: (value) {
        if (value.isEmpty) {
          return "Nama Bank masih kosong !";
        }
      },
    );
  }

  Widget inputJenisBank() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Jenis Kas/Bank",
        mode: Mode.MENU,
        items: const ["Kas", "Bank"],
        onChanged: (value) {
          if (value == "Kas") {
            idJenis = '0';
            descIdJenis = value;
          } else {
            idJenis = '1';
            descIdJenis = value;
          }
        },
        dropdownBuilder: (context, selectedItem) => Text(
            descIdJenis ?? "Pilih Jenis Kas/Bank",
            style: TextStyle(
                color: descIdJenis == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
        validator: (value) {
          if (value == "Pilih Jenis Kas/Bank") {
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
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
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
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
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
      decoration: const InputDecoration(
          label: Text('Nomor Rekening'),
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        nomorRekening = value;
      },
      initialValue: nomorRekening ?? 's',
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
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            mataUang ?? "Pilih Mata Uang",
            style:
                TextStyle(color: mataUang == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
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
          labelText: 'Nomor Telp',
          hintText: '08XXXXXXXXXX',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: ((value) {
        noTelp = value;
      }),
    );
  }

  Widget inputNoFax() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Nomor Fax',
          hintText: '021-XXXXXXXXX',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: ((value) {
        noTelp = value;
      }),
    );
  }

  fncSaveData() {
    HttpKasBank.updateKasBank(
      'KASX_BANK',
      kodeBank,
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

        menuController.changeActiveitemTo('Pembuatan Kas dan Bank');
        navigationController.navigateTo('/finance/pembuatan-kasbank');
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
                      Text('Ubah $descIdJenis $namaBank',
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
                                inputKodeBank(),
                                const SizedBox(height: 8),
                                inputNamaBank(),
                                const SizedBox(height: 8),
                                inputJenisBank(),
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
                                const SizedBox(height: 65),
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
