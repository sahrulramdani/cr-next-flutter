// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class DetailUplineAgency extends StatefulWidget {
  String idAgency;
  DetailUplineAgency({Key key, @required this.idAgency}) : super(key: key);

  @override
  State<DetailUplineAgency> createState() => _DetailUplineAgencyState();
}

class _DetailUplineAgencyState extends State<DetailUplineAgency> {
  List<Map<String, dynamic>> listUpline = [];

  void getDetailUpline() async {
    String id = widget.idAgency;
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/agency/detail/upline/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      if (dataStatus[0]['KDXX_MRKT'] != null) {
        listUpline = dataStatus;
      }
    });
  }

  @override
  void initState() {
    getDetailUpline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int x = 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          padding: const EdgeInsets.all(10),
          child: listUpline.isEmpty
              ? SizedBox(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      const Image(
                        width: 200,
                        fit: BoxFit.cover,
                        image: AssetImage('images/hero-alert-fail.png'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Agensi Tidak Memiliki Upline :(')
                    ],
                  ),
                )
              : Column(children: [
                  DataTable(
                      columns: [
                        DataColumn(
                            label: Text('No.',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('ID Agency',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Nama',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Level',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Periode',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Total',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Poin',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Status',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('HP',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Kantor',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                      ],
                      rows: listUpline.map((data) {
                        if (data['KDXX_MRKT'] != null) {
                          return DataRow(cells: [
                            DataCell(Text((x++).toString())),
                            DataCell(Text(data['KDXX_MRKT'] ?? '-')),
                            DataCell(Text(data['NAMA_LGKP'] ?? '-')),
                            DataCell(Text(data['FEE'] ?? '-')),
                            DataCell(Text(data['PERD_JMAH'].toString())),
                            DataCell(Text(data['TOTL_JMAH'].toString())),
                            DataCell(Text(data['TOTL_POIN'].toString())),
                            DataCell(Text(data['STAS_AGEN'] == 1
                                ? 'Aktif'
                                : 'Non Aktif')),
                            DataCell(Text(data['NOXX_TELP'] ?? '-')),
                            DataCell(Text(data['NAMA_KNTR'] ?? '-')),
                          ]);
                        }
                      }).toList()),
                ])),
    );
  }
}
