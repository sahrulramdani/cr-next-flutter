// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class InfoRiwayatBayar extends StatefulWidget {
  String idPelanggan;
  InfoRiwayatBayar({Key key, @required this.idPelanggan}) : super(key: key);

  @override
  State<InfoRiwayatBayar> createState() => _InfoRiwayatBayarState();
}

class _InfoRiwayatBayarState extends State<InfoRiwayatBayar> {
  List<Map<String, dynamic>> detailPembayaran = [];

  void riwayatDet() async {
    var id = widget.idPelanggan;
    var response = await http.get(
        Uri.parse("$urlAddress/jamaah/jamaah/detail/info-bayar/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      detailPembayaran = dataStatus;
    });
  }

  @override
  void initState() {
    riwayatDet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    int x = 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.print_outlined),
              label: const Text(
                'Print Nota',
                style: TextStyle(fontFamily: 'Gilroy'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: myBlue,
                minimumSize: const Size(280, 40),
                shadowColor: Colors.grey,
                elevation: 5,
              ),
            ),
            const SizedBox(height: 20),
            DataTable(
              border: TableBorder.all(color: Colors.grey),
              columns: [
                DataColumn(
                    label: Text('No.',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('REF',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Operasional',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Akun',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Nominal',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Jenis',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Status',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Cara Bayar',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Kantor',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Keterangan',
                        style: TextStyle(
                            color: myGrey, fontWeight: FontWeight.bold))),
              ],
              rows: detailPembayaran.map((e) {
                return DataRow(
                    onLongPress: () {
                      print(e['NOXX_BYAR']);
                    },
                    cells: [
                      DataCell(Text((x++).toString())),
                      DataCell(Text(e['NOXX_BYAR'])),
                      DataCell(Text(e['CRTXX'])),
                      DataCell(Text(e['JENS_TGIH'])),
                      DataCell(Text(myFormat.format(e['DIBAYARKAN']))),
                      DataCell(Text(e['JENIS'])),
                      DataCell(Text(e['STS_PEMBAYARAN'])),
                      DataCell(Text(e['CARA_BYAR'])),
                      const DataCell(Text('PUSAT')),
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
