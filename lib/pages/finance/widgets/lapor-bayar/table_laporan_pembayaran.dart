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
  final List<Map<String, dynamic>> dataLaporan;
  MyData(this.dataLaporan);
  @override
  DataRow getRow(int index) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(fncGetTanggal(dataLaporan[index]['TGLX_BYAR']),
          style: styleRowReguler)),
      DataCell(Text(dataLaporan[index]['KDXX_DFTR'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataLaporan[index]['NAMA_LGKP'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataLaporan[index]['JENS_TGIH'].toString(),
          style: styleRowReguler)),
      DataCell(Text(myFormat.format(dataLaporan[index]['DIBAYARKAN']),
          style: styleRowReguler)),
      DataCell(Text(dataLaporan[index]['KETX_USER'].toString(),
          style: styleRowReguler)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataLaporan.length;

  @override
  int get selectedRowCount => 0;
}

class TableLaporanPembayaran extends StatefulWidget {
  List<Map<String, dynamic>> dataLaporan;
  TableLaporanPembayaran({Key key, @required this.dataLaporan})
      : super(key: key);

  @override
  State<TableLaporanPembayaran> createState() => _TableLaporanPembayaranState();
}

class _TableLaporanPembayaranState extends State<TableLaporanPembayaran> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.dataLaporan);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.58,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 10,
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('Tanggal Pembayaran', style: styleColumn)),
            DataColumn(label: Text('No Pelanggan', style: styleColumn)),
            DataColumn(label: Text('Nama Pelanggan', style: styleColumn)),
            DataColumn(label: Text('Jenis Tagihan', style: styleColumn)),
            DataColumn(label: Text('Jumlah', style: styleColumn)),
            DataColumn(label: Text('Nama User', style: styleColumn)),
          ],
        ),
      ),
    );
  }
}
