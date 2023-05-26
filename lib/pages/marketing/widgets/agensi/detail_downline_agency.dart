// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class DetailDownlineAgency extends StatefulWidget {
  String idAgency;
  DetailDownlineAgency({Key key, @required this.idAgency}) : super(key: key);

  @override
  State<DetailDownlineAgency> createState() => _DetailDownlineAgencyState();
}

class _DetailDownlineAgencyState extends State<DetailDownlineAgency> {
  List<Map<String, dynamic>> listDownline = [];

  void getDetailDownline() async {
    String id = widget.idAgency;
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/agency/detail/downline/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listDownline = dataStatus;
    });
  }

  @override
  void initState() {
    getDetailDownline();
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
            getDetailDownline();
          } else {
            setState(() {
              listDownline = list
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

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          inputCari(listDownline),
          const SizedBox(height: 5),
          listDownline.isEmpty
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
                          Text('Agensi Belum Memiliki Downline :(')
                        ],
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      columnSpacing: 30,
                      dataRowHeight: 30,
                      headingRowColor: MaterialStateProperty.resolveWith<Color>(
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
                        DataColumn(label: Text('ID Agency')),
                        DataColumn(label: Text('Nama')),
                        DataColumn(label: Text('Level')),
                        DataColumn(label: Text('Periode')),
                        DataColumn(label: Text('Total')),
                        DataColumn(label: Text('Poin')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('HP')),
                        DataColumn(label: Text('Kantor')),
                      ],
                      rows: listDownline.map((data) {
                        return DataRow(cells: [
                          DataCell(Text((x++).toString())),
                          DataCell(Text(data['KDXX_MRKT'] ?? '')),
                          DataCell(Text(data['NAMA_LGKP'] ?? '')),
                          DataCell(Text(data['FEE'] ?? '')),
                          DataCell(Text(data['PERD_JMAH'].toString())),
                          DataCell(Text(data['TOTL_JMAH'].toString())),
                          DataCell(Text(data['TOTL_POIN'].toString())),
                          DataCell(Text(
                              data['STAS_AGEN'] == 1 ? 'Aktif' : 'Non Aktif')),
                          DataCell(Text(data['NOXX_TELP'] ?? '')),
                          DataCell(Text(data['NAMA_KNTR'] ?? '')),
                        ]);
                      }).toList()),
                ),
        ],
      ),
    );
  }
}
