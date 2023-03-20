// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy_pelanggan.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class DetailPelangganAgency extends StatefulWidget {
  String idAgency;
  DetailPelangganAgency({Key key, @required this.idAgency}) : super(key: key);

  @override
  State<DetailPelangganAgency> createState() => _DetailPelangganAgencyState();
}

class _DetailPelangganAgencyState extends State<DetailPelangganAgency> {
  List<Map<String, dynamic>> listDataPelanggan = [];

  void getDetailPelanggan() async {
    String id = widget.idAgency;
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/agency/detail/pelanggan/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataPelanggan =
        List.from(json.decode(response.body) as List);
    setState(() {
      listDataPelanggan = dataPelanggan;
    });
  }

  @override
  void initState() {
    getDetailPelanggan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int x = 1;
    int jmah = listDataPelanggan.length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: jmah == 0
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
                    Text('Agensi Belum Memiliki Pelanggan :(')
                  ],
                ),
              )
            : Column(
                children: [
                  DataTable(
                      columnSpacing: 15,
                      columns: [
                        DataColumn(
                            label: Text('No.',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Cek',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('ID Pelanggan',
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
                            label: Text('Nama Paket',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Berangkat',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Daftar Via',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Jamaah Ke',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                        DataColumn(
                            label: Text('Biaya',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16))),
                      ],
                      rows: listDataPelanggan.map((data) {
                        return DataRow(cells: [
                          DataCell(Text((x++).toString())),
                          DataCell(Icon(
                            data['CEK'] == 1 ? Icons.check : Icons.clear,
                            color: data['CEK'] == 1 ? Colors.green : Colors.red,
                          )),
                          DataCell(Text(data['KDXX_JMAH'] ?? '-')),
                          DataCell(Text(data['NAMA_LGKP'] ?? '-')),
                          DataCell(Text(data['JENISNA'] ??
                              '-' + ' - ' + data['PAKETNA'] ??
                              '-')),
                          DataCell(Text(fncGetTanggal(DateFormat("dd-MM-yyyy")
                              .format(DateTime.parse(
                                  data['TGLX_BGKT'] ?? '01-01-1111'))))),
                          DataCell(Text(data['NAMA_KNTR'] ?? '-')),
                          DataCell(Text((jmah--).toString())),
                          DataCell(Text(data['STAS_BYAR'].toString() == '1'
                              ? 'Lunas'
                              : 'Belum Lunas')),
                        ]);
                      }).toList()),
                ],
              ),
      ),
    );
  }
}
