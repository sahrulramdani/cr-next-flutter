// ignore_for_file: must_be_immutable, missing_required_param

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_hapus_jadwal.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/modal_detail_perolehan.dart';
// import 'package:intl/intl.dart';

/// Example without a datasource
// MYDATA

class MyData extends DataTableSource {
  final BuildContext context;
  final List<Map<String, dynamic>> listPerolehan;
  MyData(this.listPerolehan, this.context);

  @override
  DataRow getRow(int index) {
    return DataRow(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) => ModalDetailPerolehan(
                  tahun: listPerolehan[index]['TAHUN'].toString()));
        },
        cells: [
          DataCell(Text((index + 1).toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey[800]))),
          DataCell(Text(listPerolehan[index]['TAHUN'].toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey[800]))),
          DataCell(Text(listPerolehan[index]['TOTAL'].toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey[800]))),
          DataCell(Text(listPerolehan[index]['BERANGKAT'].toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey[800]))),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listPerolehan.length;

  @override
  int get selectedRowCount => 0;
}

class TableLaporanTahunan extends StatefulWidget {
  final List<Map<String, dynamic>> listPerolehan;
  const TableLaporanTahunan({Key key, @required this.listPerolehan})
      : super(key: key);

  @override
  State<TableLaporanTahunan> createState() => _TableLaporanTahunanState();
}

class _TableLaporanTahunanState extends State<TableLaporanTahunan> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.listPerolehan, context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: PaginatedDataTable(
        source: myTable,
        dataRowHeight: 40,
        columnSpacing: 14,
        columns: const [
          DataColumn(
              label: Text('No.',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
          DataColumn(
              label: Text('Tahun',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
          DataColumn(
              label: Text('Perolehan',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
          DataColumn(
              label: Text('Berangkat',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
        ],
      ),
    );
  }
}
