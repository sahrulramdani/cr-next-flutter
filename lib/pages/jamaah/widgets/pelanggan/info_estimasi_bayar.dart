// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class InfoEstimasiBayar extends StatefulWidget {
  String idPelanggan;
  InfoEstimasiBayar({Key key, @required this.idPelanggan}) : super(key: key);

  @override
  State<InfoEstimasiBayar> createState() => _InfoEstimasiBayarState();
}

class _InfoEstimasiBayarState extends State<InfoEstimasiBayar> {
  List<Map<String, dynamic>> detailEst = [];

  void getEstimasi() async {
    var id = widget.idPelanggan;
    var response = await http.get(
        Uri.parse("$urlAddress/jamaah/jamaah/detail/info-estimasi/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      detailEst = dataStatus;
    });
  }

  @override
  void initState() {
    getEstimasi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataTable(columns: [
              const DataColumn(label: Text('Biaya Paket')),
              const DataColumn(label: Text(':')),
              DataColumn(
                  label: Text(detailEst.isNotEmpty
                      ? myFormat.format(detailEst[0]['BIAYA_PKET'] ?? 0)
                      : '-')),
            ], rows: [
              DataRow(cells: [
                const DataCell(Text('Biaya Paspor')),
                const DataCell(Text(':')),
                DataCell(Text(detailEst.isNotEmpty
                    ? myFormat.format(detailEst[0]['PASPOR'] ?? 0)
                    : '-')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Biaya Vaksin')),
                const DataCell(Text(':')),
                DataCell(Text(detailEst.isNotEmpty
                    ? myFormat.format(detailEst[0]['VAKSIN'] ?? 0)
                    : '-')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Jatuh Tempo')),
                const DataCell(Text(':')),
                DataCell(Text(detailEst.isNotEmpty
                    ? fncGetTanggal(detailEst[0]['JATUH_TEMP'] ??
                        DateFormat("dd-MM-yyyy").format(DateTime.now()))
                    : '-')),
                // DataCell(Text(
                //     detailEst.isNotEmpty ? (detailEst[0]['JATUH_TEMP'] ?? '-') : '-')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Status')),
                const DataCell(Text(':')),
                DataCell(Text(
                    detailEst.isNotEmpty ? detailEst[0]['STS_LUNAS'] : '-')),
              ]),
              // DataRow(cells: [
              //   DataCell(Text('Status Handling')),
              //   DataCell(Text(':')),
              //   DataCell(Text('Belum')),
              // ]),
            ]),
            const SizedBox(width: 10),
            DataTable(columns: [
              const DataColumn(label: Text('Handling')),
              const DataColumn(label: Text(':')),
              DataColumn(
                  label: Text(
                      detailEst.isNotEmpty ? detailEst[0]['HANDLING'] : '-')),
            ], rows: [
              DataRow(cells: [
                const DataCell(Text('Estimasi Total')),
                const DataCell(Text(':')),
                DataCell(Text(detailEst.isNotEmpty
                    ? myFormat.format(detailEst[0]['ESTX_TOTL'] ?? 0)
                    : '-')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Uang Masuk')),
                const DataCell(Text(':')),
                DataCell(Text(detailEst.isNotEmpty
                    ? myFormat.format(detailEst[0]['UANG_MASUK'] ?? 0)
                    : '-')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Sisa Tagihan')),
                const DataCell(Text(':')),
                DataCell(Text(detailEst.isNotEmpty
                    ? myFormat.format(detailEst[0]['SISA_TAGIHAN'] ?? 0)
                    : '-')),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
