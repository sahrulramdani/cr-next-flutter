// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class LainnyaKwitansi extends StatefulWidget {
  String idPelanggan;
  LainnyaKwitansi({Key key, @required this.idPelanggan}) : super(key: key);

  @override
  State<LainnyaKwitansi> createState() => _LainnyaKwitansiState();
}

class _LainnyaKwitansiState extends State<LainnyaKwitansi> {
  List<Map<String, dynamic>> detailKwitansi = [];
  List<Map<String, dynamic>> detailEst = [];

  void getEstimasi() async {
    var id = widget.idPelanggan;
    var response = await http
        .get(Uri.parse("$urlAddress/jamaah/jamaah/detail/info-estimasi/$id"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      detailEst = dataStatus;
    });
  }

  void getKwitansi() async {
    var id = widget.idPelanggan;
    var response = await http
        .get(Uri.parse("$urlAddress/jamaah/jamaah/lainnya/kwitansi/$id"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      detailKwitansi = dataStatus;
    });
  }

  @override
  void initState() {
    getKwitansi();
    getEstimasi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int x = 1;
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: DataTable(
                  border: TableBorder.all(color: Colors.grey),
                  columns: [
                    const DataColumn(label: Text('Uang Masuk : ')),
                    DataColumn(
                        label: Text(detailEst.isNotEmpty
                            ? myFormat.format(detailEst[0]['UANG_MASUK'] ?? 0)
                            : '0')),
                    const DataColumn(label: Text('Sisa Bayar : ')),
                    DataColumn(
                        label: Text(detailEst.isNotEmpty
                            ? myFormat.format(detailEst[0]['SISA_TAGIHAN'] ?? 0)
                            : '0')),
                    DataColumn(
                        label: Text(detailEst.isNotEmpty
                            ? detailEst[0]['STS_LUNAS']
                            : '-')),
                  ],
                  rows: const []),
            ),
            const SizedBox(height: 10),
            const Text('List Kwitansi',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DataTable(
              border: TableBorder.all(color: Colors.grey),
              columns: [
                DataColumn(
                    label: Text('No.',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Faktur',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Operasional',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Bayar',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Cara Bayar',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Bank',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Keterangan',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold)))
              ],
              rows: detailKwitansi.map((e) {
                return DataRow(cells: [
                  DataCell(Text((x++).toString())),
                  DataCell(Text(e['NOXX_FAKT'])),
                  DataCell(Text(e['CRTX_DATE'])),
                  DataCell(Text(myFormat.format(e['JMLH_BYAR'] ?? 0))),
                  DataCell(Text(e['CARA_BYAR'])),
                  DataCell(Text(e['NAME_BANK'])),
                  DataCell(Text(e['KETERANGAN'])),
                ]);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
