// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/controllers.dart';

// import 'package:flutter_web_course/pages/inventory/widgets/modal_hapus_barang.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jadwal.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_upload_jamaah.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataPembayaran;
  MyData(this.dataPembayaran);
  @override
  DataRow getRow(int index) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return DataRow(
        onLongPress: () {
          menuController.changeActiveitemTo('Form Bayar');
          navigationController.navigateTo('/finance/form-bayar');
        },
        cells: [
          DataCell(Text((index + 1).toString())),
          DataCell(Text(dataPembayaran[index]['NAMA_KNTR'])),
          DataCell(Text(dataPembayaran[index]['ALMT_KNTR'])),
          DataCell(Text(dataPembayaran[index]['JML_DFTAR'].toString())),
          DataCell(Text(myFormat.format(dataPembayaran[index]['TOTL_TGIH']))),
          DataCell(Text(myFormat.format(dataPembayaran[index]['JML_BYAR']))),
          DataCell(Text(myFormat.format((dataPembayaran[index]['TOTL_TGIH']) -
              (dataPembayaran[index]['JML_BYAR'])))),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataPembayaran.length;

  @override
  int get selectedRowCount => 0;
}

class TablePembayaran extends StatefulWidget {
  List<Map<String, dynamic>> dataPembayaran;
  TablePembayaran({Key key, @required this.dataPembayaran}) : super(key: key);

  @override
  State<TablePembayaran> createState() => _TablePembayaranState();
}

class _TablePembayaranState extends State<TablePembayaran> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.dataPembayaran);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.38,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 8,
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
                label: Text('Cabang',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Lokasi',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Daftar',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Tagihan',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Pembayaran',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Selisih',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
          ],
        ),
      ),
    );
  }
}
