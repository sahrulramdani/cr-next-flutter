// ignore_for_file: unused_local_variable, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/pages/inventory/widgets/satuan/modal_edit_satuan.dart';
import 'package:flutter_web_course/pages/inventory/widgets/satuan/modal_hapus_satuan.dart';
import 'package:flutter_web_course/pages/overview/widgets/datatable_proyek.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_upload_jamaah.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:intl/intl.dart';

class ButtonEdit extends StatelessWidget {
  final String satuan;
  const ButtonEdit({Key key, @required this.satuan}) : super(key: key);

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
            builder: (context) => ModalEditSatuan(idsatuan: satuan));
      },
    );
  }
}

class ButtonHapus extends StatelessWidget {
  String idsatuan;
  ButtonHapus({Key key, @required this.idsatuan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalHapusSatuan(idsatuan: idsatuan));
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> listPengeluaran;
  MyData(this.listPengeluaran);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listPengeluaran[index]['NOTRANSAKSI'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listPengeluaran[index]['STATUSPOSTING'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(satuan: listPengeluaran[index]['NOTRANSAKSI']),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listPengeluaran.length;

  @override
  int get selectedRowCount => 0;
}

class TablePengeluaran extends StatefulWidget {
  List<Map<String, dynamic>> listPengeluaran;
  TablePengeluaran({Key key, @required this.listPengeluaran}) : super(key: key);

  @override
  State<TablePengeluaran> createState() => _TablePengeluaranState();
}

class _TablePengeluaranState extends State<TablePengeluaran> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.listPengeluaran);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.63,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          source: myTable,
          columns: const [
            DataColumn(
                label: Text('No.',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('No Transaksi',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Status Posting',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Expanded(
              child: Center(
                child: Text('Aksi',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16)),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
