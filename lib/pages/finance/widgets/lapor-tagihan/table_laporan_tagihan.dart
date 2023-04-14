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
      DataCell(Text(fncGetTanggal(dataLaporan[index]['TGLX_TAGIHAN']),
          style: styleRowReguler)),
      DataCell(Text(fncGetTanggal(dataLaporan[index]['BERANGKAT']),
          style: styleRowReguler)),
      DataCell(Text(dataLaporan[index]['KDXX_DFTR'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataLaporan[index]['NAMA_LGKP'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataLaporan[index]['JENS_TGIH'].toString(),
          style: styleRowReguler)),
      DataCell(Text(myFormat.format(dataLaporan[index]['TOTL_TGIH']),
          style: styleRowReguler)),
      DataCell(Text(myFormat.format(dataLaporan[index]['SISA_TGIH']),
          style: styleRowReguler)),
      DataCell(Text(dataLaporan[index]['STS_LUNAS'].toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: dataLaporan[index]['STS_LUNAS'] == 'Belum'
                  ? Colors.red[800]
                  : Colors.green[800]))),
      DataCell(Text(
          dataLaporan[index]['STAS_BGKT'] == 0
              ? 'Belum Berangkat'
              : 'Sudah Berangkat',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: dataLaporan[index]['STAS_BGKT'] == 0
                  ? Colors.red[800]
                  : Colors.green[800]))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataLaporan.length;

  @override
  int get selectedRowCount => 0;
}

class TableLaporanTagihan extends StatefulWidget {
  List<Map<String, dynamic>> dataLaporan;
  TableLaporanTagihan({Key key, @required this.dataLaporan}) : super(key: key);

  @override
  State<TableLaporanTagihan> createState() => _TableLaporanTagihanState();
}

class _TableLaporanTagihanState extends State<TableLaporanTagihan> {
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
          columnSpacing: 5,
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('Tanggal Tagihan', style: styleColumn)),
            DataColumn(label: Text('Tanggal Berangkat', style: styleColumn)),
            DataColumn(label: Text('No Pelanggan', style: styleColumn)),
            DataColumn(label: Text('Nama Pelanggan', style: styleColumn)),
            DataColumn(label: Text('Jenis Tagihan', style: styleColumn)),
            DataColumn(label: Text('Jumlah', style: styleColumn)),
            DataColumn(label: Text('Sisa', style: styleColumn)),
            DataColumn(label: Text('Status Lunas', style: styleColumn)),
            DataColumn(label: Text('Status Berangkat', style: styleColumn)),
          ],
        ),
      ),
    );
  }
}
