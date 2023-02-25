import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_course/pages/marketing/widgets/pemberangkatan/modal_konfirmasi_pemberangkatan.dart';

class DetailPemberangkatanJamaah extends StatefulWidget {
  String idJadwal;
  DetailPemberangkatanJamaah({Key key, @required this.idJadwal})
      : super(key: key);

  @override
  State<DetailPemberangkatanJamaah> createState() =>
      _DetailPemberangkatanJamaahState();
}

class _DetailPemberangkatanJamaahState
    extends State<DetailPemberangkatanJamaah> {
  List<Map<String, dynamic>> listPelangganPemberangkatan = [];

  void getJamaahPemberangkatan() async {
    var id = widget.idJadwal;
    var response = await http.get(Uri.parse(
        "$urlAddress/marketing/pemberangkatan/list-jamaah-berangkat/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listPelangganPemberangkatan = data;
    });
  }

  @override
  void initState() {
    getJamaahPemberangkatan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int x = 1;
    int y = listPelangganPemberangkatan.length;

    return SizedBox(
      width: screenWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              DataTable(
                  border: TableBorder.all(color: Colors.grey),
                  columns: [
                    DataColumn(
                        label: Text('No.',
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
                        label: Text('ID Marketing',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Marketing',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Jenis',
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
                        label: Text('Pendaftaran Via',
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
                    DataColumn(
                        label: Text('VB',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Aksi',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16)))
                  ],
                  rows: listPelangganPemberangkatan.map((data) {
                    return DataRow(cells: [
                      DataCell(Text((x++).toString())),
                      DataCell(Text(data['KDXX_DFTR'] ?? '-')),
                      DataCell(Text(data['NAMA_JMAH'] ?? '-')),
                      DataCell(Text(data['KDXX_MRKT'] == ''
                          ? '-'
                          : data['KDXX_MRKT'] ?? '-')),
                      DataCell(Text(data['NAMA_MRKT'] ?? '-')),
                      DataCell(Text(data['JENIS_DAFTAR'] ?? '-')),
                      DataCell(Text(data['FIRST_LEVEL'] ?? '-')),
                      DataCell(Text(data['DAFTAR_VIA'] ?? '-')),
                      DataCell(Text((y--).toString())),
                      DataCell(Text(data['BIAYA'] ?? '-')),
                      DataCell(Icon(
                        data['VB'] == '1'
                            ? Icons.check
                            : Icons.add_alert_outlined,
                        color: data['VB'] == '1' ? Colors.green : Colors.red,
                      )),
                      DataCell(IconButton(
                        icon: Icon(Icons.info_outline, color: myBlue),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => ModalKonfirmasiBerangkat(
                                  idDaftar: data['KDXX_DFTR']));
                        },
                      )),
                    ]);
                  }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
