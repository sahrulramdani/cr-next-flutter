// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class InfoPaket extends StatefulWidget {
  String idPelanggan;
  InfoPaket({Key key, @required this.idPelanggan}) : super(key: key);

  @override
  State<InfoPaket> createState() => _InfoPaketState();
}

class _InfoPaketState extends State<InfoPaket> {
  List<Map<String, dynamic>> detailPaketPelanggan = [];

  void paketPelanggan() async {
    var id = widget.idPelanggan;
    var response = await http
        .get(Uri.parse("$urlAddress/jamaah/jamaah/detail/info-paket/$id"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      detailPaketPelanggan = dataStatus;
    });
  }

  @override
  void initState() {
    paketPelanggan();
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
              const DataColumn(label: Text('ID Jadwal')),
              const DataColumn(label: Text(':')),
              DataColumn(
                  label: Text(detailPaketPelanggan.isNotEmpty
                      ? detailPaketPelanggan[0]['IDXX_JDWL']
                      : '')),
            ], rows: [
              DataRow(cells: [
                const DataCell(Text('Berangkat')),
                const DataCell(Text(':')),
                DataCell(Text(detailPaketPelanggan.isNotEmpty
                    ? fncGetTanggal(detailPaketPelanggan[0]['TGLX_BGKT'])
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Pulang')),
                const DataCell(Text(':')),
                DataCell(Text(detailPaketPelanggan.isNotEmpty
                    ? fncGetTanggal(detailPaketPelanggan[0]['TGLX_PLNG'])
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Paket')),
                const DataCell(Text(':')),
                DataCell(Text(detailPaketPelanggan.isNotEmpty
                    ? detailPaketPelanggan[0]['namaPaket'] +
                        ' ' +
                        detailPaketPelanggan[0]['jenisPaket']
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Biaya')),
                const DataCell(Text(':')),
                DataCell(Text(detailPaketPelanggan.isNotEmpty
                    ? myFormat.format(detailPaketPelanggan[0]['TARIF_PKET'])
                    : '')),
              ]),
            ]),
            const SizedBox(width: 10),
            DataTable(columns: [
              const DataColumn(label: Text('Mata Uang')),
              const DataColumn(label: Text(':')),
              DataColumn(
                  label: Text(detailPaketPelanggan.isNotEmpty
                      ? detailPaketPelanggan[0]['MATA_UANG']
                      : '')),
            ], rows: [
              DataRow(cells: [
                const DataCell(Text('Keterangan')),
                const DataCell(Text(':')),
                DataCell(Text(detailPaketPelanggan.isNotEmpty
                    ? detailPaketPelanggan[0]['KETERANGAN']
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Jumlah Seat')),
                const DataCell(Text(':')),
                DataCell(Text(detailPaketPelanggan.isNotEmpty
                    ? detailPaketPelanggan[0]['JMLX_SEAT'].toString()
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Jumlah Hari')),
                const DataCell(Text(':')),
                DataCell(Text(detailPaketPelanggan.isNotEmpty
                    ? detailPaketPelanggan[0]['JMLX_HARI'].toString()
                    : '')),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
