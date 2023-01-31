import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';
import 'dart:convert';

class DetailBankAgency extends StatefulWidget {
  // final String idAgen;
  const DetailBankAgency({Key key}) : super(key: key);

  @override
  State<DetailBankAgency> createState() => _DetailBankAgencyState();
}

class _DetailBankAgencyState extends State<DetailBankAgency> {
  // List<Map<String, dynamic>> bankAgency = [];

  // void getBankAgen() async {
  //   var id = widget.idAgen;
  //   var response = await http.get(
  //       Uri.parse("$urlAddress/marketing/agency/detail/bank/$id"),
  //       headers: {
  //         'pte-token': kodeToken,
  //       });
  //   List<Map<String, dynamic>> bank =
  //       List.from(json.decode(response.body) as List);
  //   setState(() {
  //     bankAgency = bank;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getBankAgen();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 400,
      child: Column(children: [
        SizedBox(
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                initialValue: 'BANK BNI',
                style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nama Bank Agen'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                initialValue: '001888271288190',
                style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nomor Rekening'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                initialValue: 'Rekening Fulan',
                style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nama Rekening'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                initialValue: 'Aktif',
                style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nama Rekening'),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
