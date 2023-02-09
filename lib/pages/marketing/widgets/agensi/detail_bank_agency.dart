// ignore_for_file: missing_return, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/models/http_agency.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';

class DetailBankAgency extends StatefulWidget {
  final String idAgency;
  const DetailBankAgency({Key key, @required this.idAgency}) : super(key: key);

  @override
  State<DetailBankAgency> createState() => _DetailBankAgencyState();
}

class _DetailBankAgencyState extends State<DetailBankAgency> {
  String idBank;
  String namaBank;
  String nomorRekening;
  String namaRekening;
  String statusRekening;
  String kodeStatus;

  List<Map<String, dynamic>> bankAgency = [];
  List<Map<String, dynamic>> listBank = [];

  void getBankAgen() async {
    var id = widget.idAgency;
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/agency/detail/bank/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> bank =
        List.from(json.decode(response.body) as List);
    setState(() {
      bankAgency = bank;
      idBank = bank[0]['KDXX_BANK'];
      namaBank = bank[0]['NAMA_BANK'];
      nomorRekening = bank[0]['NOXX_REKX'];
      namaRekening = bank[0]['NAMA_REKX'];
      kodeStatus = bank[0]['STAS_REKX'].toString();
      if (bank[0]['STAS_REKX'] == 1) {
        statusRekening = 'Aktif';
      } else {
        statusRekening = 'Non Aktif';
      }
    });
  }

  getBank() async {
    var response = await http.get(Uri.parse("$urlAddress/setup/banks"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listBank = dataStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    getBankAgen();
    getBank();
  }

  Widget inputNamaBank() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Nama Bank Agen",
        items: listBank,
        onChanged: (value) {
          idBank = value['CODD_VALU'];
          namaBank = value['CODD_DESC'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaBank ?? "Bank Belum dipilih"),
        validator: (value) {
          if (value == "Bank Belum dipilih") {
            return "Bank masih kosong !";
          }
        },
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
      ),
    );
  }

  Widget inputNomorRekening() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      initialValue: nomorRekening ?? '',
      decoration: const InputDecoration(
          labelText: 'Nomor Rekening',
          hintText: 'Nomor',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        nomorRekening = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Nomor Rekening !";
        }
      },
    );
  }

  Widget inputNamaRekening() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      initialValue: namaRekening ?? '',
      decoration: const InputDecoration(
          labelText: 'Atas Nama Rekening',
          hintText: 'Nama',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        namaRekening = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Nama Rekening !";
        }
      },
    );
  }

  Widget inputStatusRekening() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Status Rekening",
        mode: Mode.MENU,
        items: const ["Aktif", "Non Aktif"],
        onChanged: (value) {
          if (value == "Aktif") {
            kodeStatus = '1';
            statusRekening = 'Aktif';
          } else {
            kodeStatus = '0';
            statusRekening = 'Non Aktif';
          }
        },
        selectedItem: statusRekening ?? "Status Rekening",
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
        validator: (value) {
          if (value == "Status Rekening") {
            return "Status Rekening Belum Dipilih";
          }
        },
      ),
    );
  }

  fncSaveData() {
    HttpAgency.updateAgencyBank(
            widget.idAgency, idBank, nomorRekening, namaRekening, kodeStatus)
        .then(
      (value) {
        if (value.status == true) {
          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.all(20),
      width: 450,
      child: Column(children: [
        SizedBox(
          height: 400,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                inputNamaBank(),
                const SizedBox(height: 10),
                inputNomorRekening(),
                const SizedBox(height: 10),
                inputNamaRekening(),
                const SizedBox(height: 10),
                inputStatusRekening(),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        fncSaveData();
                      } else {
                        return null;
                      }
                    },
                    child: const Text('Simpan Data Bank')),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
