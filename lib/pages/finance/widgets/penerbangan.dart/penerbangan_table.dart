// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/dummy_jadwal.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
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
  final List<Map<String, dynamic>> dataProfit;
  MyData(this.dataProfit);
  @override
  DataRow getRow(int index) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(
          dataProfit[index]['namaPaket'] +
              ' - ' +
              dataProfit[index]['KETERANGAN'] +
              ' ' +
              fncGetTanggal(dataProfit[index]['TGLX_BGKT']),
          style: styleRowReguler)),
      DataCell(Text(myFormat.format(dataProfit[index]['TARIF_PKET']),
          style: styleRowReguler)),
      DataCell(Text(dataProfit[index]['JMLX_SEAT'].toString(),
          style: styleRowReguler)),
      DataCell(
          Text(dataProfit[index]['TERISI'].toString(), style: styleRowReguler)),
      DataCell(Text(
          ((dataProfit[index]['JMLX_SEAT']) - (dataProfit[index]['TERISI']))
              .toString(),
          style: styleRowReguler)),
      DataCell(Text(myFormat.format(dataProfit[index]['EST_PROFIT']),
          style: styleRowReguler)),
      DataCell(Text(myFormat.format(dataProfit[index]['TLH_MASUK']),
          style: styleRowReguler)),
      DataCell(Text(
          myFormat.format(((dataProfit[index]['EST_PROFIT']) -
                  (dataProfit[index]['TLH_MASUK'])) *
              1),
          style: styleRowReguler)),

      // DataCell(Text(myFormat.format(dataProfit[index]['TARIF_PKET']))),
      // DataCell(Text(dataProfit[index]['JMLX_SEAT'].toString())),
      // DataCell(Text(myFormat.format(dataProfit[index]['EST_PROFIT']))),
      // DataCell(Text(myFormat.format(dataProfit[index]['TLH_MASUK']))),
      // DataCell(Text(myFormat.format(((dataProfit[index]['EST_PROFIT']) -
      //         (dataProfit[index]['TLH_MASUK'])) *
      //     1))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataProfit.length;

  @override
  int get selectedRowCount => 0;
}

class TablePenerbangan extends StatefulWidget {
  List<Map<String, dynamic>> dataProfit;
  TablePenerbangan({Key key, @required this.dataProfit}) : super(key: key);

  @override
  State<TablePenerbangan> createState() => _TablePenerbanganState();
}

class _TablePenerbanganState extends State<TablePenerbangan> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.dataProfit);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.72,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 10,
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('Penerbangan', style: styleColumn)),
            DataColumn(label: Text('Tarif', style: styleColumn)),
            DataColumn(label: Text('Seat', style: styleColumn)),
            DataColumn(label: Text('Terisi', style: styleColumn)),
            DataColumn(label: Text('Sisa', style: styleColumn)),
            DataColumn(label: Text('Estimasi', style: styleColumn)),
            DataColumn(label: Text('Telah Masuk', style: styleColumn)),
            DataColumn(label: Text('Selisih', style: styleColumn)),
          ],
        ),
      ),
    );
  }
}
