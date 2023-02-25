// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_constructors_in_immutables

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
  String idGrupBarang;
  ButtonKelola({Key key, @required this.idGrupBarang}) : super(key: key);

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
                    idGrupbrg: idGrupBarang,
                  ));
        });
  }
}

class ButtonHapus extends StatelessWidget {
  String idGrup;
  ButtonHapus({Key key, @required this.idGrup}) : super(key: key);

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
            builder: (context) => ModalHapusGrupBarang(idGrup: idGrup));
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> listData;
  MyData(this.listData);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listData[index]['NAMA_GRUP'].toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listData[index]['QTY'].toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listData[index]['KETERANGAN'].toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonKelola(idGrupBarang: listData[index]['KDXX_GRUP']),
            const SizedBox(width: 10),
            ButtonHapus(
              idGrup: listData[index]['KDXX_GRUP'],
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listData.length;

  @override
  int get selectedRowCount => 0;
}

class TableGrupBarang extends StatefulWidget {
  final List<Map<String, dynamic>> listData;
  TableGrupBarang({Key key, @required this.listData}) : super(key: key);

  @override
  State<TableGrupBarang> createState() => _TableGrupBarangState();
}

class _TableGrupBarangState extends State<TableGrupBarang> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.listData);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.60,
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
                label: Text('Grup Barang',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Qty Jenis',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Keterangan',
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
