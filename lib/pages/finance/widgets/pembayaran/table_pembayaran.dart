// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';

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
          authAddx == '1'
              ? {
                  menuController.changeActiveitemTo('Form Bayar'),
                  navigationController.navigateTo('/finance/form-bayar')
                }
              : '';
        },
        cells: [
          DataCell(Text((index + 1).toString(), style: styleRowReguler)),
          DataCell(
              Text(dataPembayaran[index]['NAMA_KNTR'], style: styleRowReguler)),
          DataCell(
              Text(dataPembayaran[index]['ALMT_KNTR'], style: styleRowReguler)),
          DataCell(Text(dataPembayaran[index]['JML_DFTAR'].toString(),
              style: styleRowReguler)),
          DataCell(Text(myFormat.format(dataPembayaran[index]['TOTL_TGIH']),
              style: styleRowReguler)),
          DataCell(Text(myFormat.format(dataPembayaran[index]['JML_BYAR']),
              style: styleRowReguler)),
          DataCell(Text(
              myFormat.format((dataPembayaran[index]['TOTL_TGIH']) -
                  (dataPembayaran[index]['JML_BYAR'])),
              style: styleRowReguler)),
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
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('Cabang', style: styleColumn)),
            DataColumn(label: Text('Lokasi', style: styleColumn)),
            DataColumn(label: Text('Daftar', style: styleColumn)),
            DataColumn(label: Text('Tagihan', style: styleColumn)),
            DataColumn(label: Text('Pembayaran', style: styleColumn)),
            DataColumn(label: Text('Selisih', style: styleColumn)),
          ],
        ),
      ),
    );
  }
}
