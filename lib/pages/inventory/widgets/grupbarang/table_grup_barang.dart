// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
// import 'package:flutter_web_course/pages/inventory/widgets/modal_hapus_barang.dart';
import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/modal_hapus_grup_barang.dart';
import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/modal_list_grup.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jadwal.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_upload_jamaah.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:intl/intl.dart';

class ButtonKelola extends StatelessWidget {
  String namaBarang;
  ButtonKelola({Key key, @required this.namaBarang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.format_list_bulleted_rounded,
          color: myBlue,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => ModalListGrup(
                    namaGrup: namaBarang,
                  ));
        });
  }
}

class ButtonHapus extends StatelessWidget {
  const ButtonHapus({Key key}) : super(key: key);

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
            builder: (context) => const ModalHapusGrupBarang());
      },
    );
  }
}

class MyData extends DataTableSource {
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(listGrupBarang[index]['grup'])),
      DataCell(Text(listGrupBarang[index]['qty_jenis'])),
      DataCell(Text(listGrupBarang[index]['keterangan'])),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonKelola(namaBarang: listGrupBarang[index]['grup']),
            const SizedBox(width: 10),
            const ButtonHapus(),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listGrupBarang.length;

  @override
  int get selectedRowCount => 0;
}

class TableGrupBarang extends StatefulWidget {
  const TableGrupBarang({Key key}) : super(key: key);

  @override
  State<TableGrupBarang> createState() => _TableGrupBarangState();
}

class _TableGrupBarangState extends State<TableGrupBarang> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData();

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.72,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
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
                label: Text('Grup Barang',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Qty Jenis',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Keterangan',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Expanded(
              child: Center(
                child: Text('Aksi',
                    style: TextStyle(
                        color: myGrey,
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
