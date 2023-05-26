// ignore_for_file: unnecessary_const, must_be_immutable, prefer_adjacent_string_concatenation, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class DetailPelangganAgency extends StatefulWidget {
  String idAgency;
  String telp;
  DetailPelangganAgency({Key key, @required this.idAgency, @required this.telp})
      : super(key: key);

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

  Widget inputCari(list) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        style: const TextStyle(fontFamily: 'Gilroy', fontSize: 14),
        decoration: const InputDecoration(
          hintText: 'Cari Berdasarkan Nama',
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            borderSide: BorderSide(color: Colors.black, width: 5.0),
          ),
        ),
        onChanged: (value) {
          if (value == '') {
            getDetailPelanggan();
          } else {
            setState(() {
              listDataPelanggan = list
                  .where(((element) => element['NAMA_LGKP']
                      .toString()
                      .toUpperCase()
                      .contains(value.toUpperCase())))
                  .toList();
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int x = 1;
    int jmah = listDataPelanggan.length;

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          inputCari(listDataPelanggan),
          const SizedBox(height: 5),
          jmah == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250,
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
                    ),
                  ],
                )
              : Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          columnSpacing: 25,
                          dataRowHeight: 30,
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            return Colors.blue;
                          }),
                          headingTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16),
                          columns: const [
                            DataColumn(label: Text('No.')),
                            DataColumn(label: Text('Cek')),
                            DataColumn(label: Text('ID Pelanggan')),
                            DataColumn(label: Text('Nama')),
                            DataColumn(label: Text('Nama Paket')),
                            DataColumn(label: Text('Berangkat')),
                            DataColumn(label: Text('Daftar Via')),
                            DataColumn(label: Text('Jamaah Ke')),
                            DataColumn(label: Text('Biaya')),
                          ],
                          rows: listDataPelanggan.map((data) {
                            return DataRow(cells: [
                              DataCell(Text((x++).toString())),
                              DataCell(Icon(
                                data['CEK'] == 1 ? Icons.check : Icons.clear,
                                color: data['CEK'] == 1
                                    ? Colors.green
                                    : Colors.red,
                              )),
                              DataCell(Text(data['KDXX_JMAH'] ?? '-')),
                              DataCell(Text(data['NAMA_LGKP'] ?? '-')),
                              DataCell(Text(data['JENISNA'] ??
                                  '-' + ' - ' + data['PAKETNA'] ??
                                  '-')),
                              DataCell(Text(fncGetTanggal(DateFormat(
                                      "dd-MM-yyyy")
                                  .format(DateTime.parse(
                                      data['TGLX_BGKT'] ?? '01-01-1111'))))),
                              DataCell(Text(data['NAMA_KNTR'] ?? '-')),
                              DataCell(Text((jmah--).toString())),
                              DataCell(Text(data['STAS_BYAR'].toString() == '1'
                                  ? 'Lunas'
                                  : 'Belum Lunas')),
                            ]);
                          }).toList()),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
