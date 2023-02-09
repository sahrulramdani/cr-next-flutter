import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:convert';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jadwal.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/modal_menu_pelanggan.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_upload_jamaah.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:intl/intl.dart';

class ButtonEdit extends StatelessWidget {
  String idPelanggan;
  String namaPelanggan;
  ButtonEdit(
      {Key key, @required this.idPelanggan, @required this.namaPelanggan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalMenuPelanggan(
                  idPelanggan: idPelanggan,
                  namaPelanggan: namaPelanggan,
                ));
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataPelanggan;
  MyData(this.dataPelanggan);

  @override
  DataRow getRow(int index) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Icon(
          dataPelanggan[index]['STS_BRGKT'] == 0
              ? Icons.punch_clock_outlined
              : Icons.check,
          color: dataPelanggan[index]['STS_BRGKT'] == 0
              ? Colors.orange[800]
              : Colors.green)),
      DataCell(Text(dataPelanggan[index]['KDXX_DFTR'].toString())),
      DataCell(Text(dataPelanggan[index]['NAMA_LGKP'])),
      DataCell(Text(dataPelanggan[index]['JENS_KLMN'])),
      DataCell(Text(dataPelanggan[index]['UMUR'].toString())),
      DataCell(Text(dataPelanggan[index]['BERANGKAT'])),
      DataCell(Text(
          dataPelanggan[index]['PASPORAN'] == 'BELUM' ? 'BELUM' : 'PASPORAN')),
      DataCell(Text(dataPelanggan[index]['HANDLING'])),
      DataCell(Text(dataPelanggan[index]['NOXX_TELP'].toString())),
      DataCell(Text(myFormat.format(dataPelanggan[index]['UANG_MASUK']))),
      DataCell(Text(myFormat.format(dataPelanggan[index]['SISA']))),
      DataCell(Text(dataPelanggan[index]['NAMA_MRKT'])),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(
              idPelanggan: dataPelanggan[index]['KDXX_DFTR'].toString(),
              namaPelanggan: dataPelanggan[index]['NAMA_LGKP'],
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataPelanggan.length;

  @override
  int get selectedRowCount => 0;
}

class TablePelanggan extends StatefulWidget {
  final List<Map<String, dynamic>> dataPelanggan;
  const TablePelanggan({Key key, @required this.dataPelanggan})
      : super(key: key);

  @override
  State<TablePelanggan> createState() => _TablePelangganState();
}

class _TablePelangganState extends State<TablePelanggan> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.dataPelanggan);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.5,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 17,
          source: myTable,
          columns: [
            DataColumn(
                label: Text('No.',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('#',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('ID',
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
                label: Text('JK',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('U',
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
                label: Text('Persyaratan',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Handling',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Telepon',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Uang Masuk',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Estimasi Sisa',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Agency',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: SizedBox(
                    width: 80,
                    child: Center(
                      child: Text('Aksi',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16)),
                    )))
          ],
        ),
      ),
    );
  }
}
