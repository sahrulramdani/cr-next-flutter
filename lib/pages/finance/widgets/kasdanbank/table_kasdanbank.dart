// ignore_for_file: unused_local_variable, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/pages/finance/widgets/kasdanbank/modal_edit_kasbank.dart';
import 'package:flutter_web_course/pages/finance/widgets/kasdanbank/modal_hapus_kasbank.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
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
  final String idKasBank;
  const ButtonEdit({Key key, @required this.idKasBank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: authEdit == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authExpt == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalEditKasBank(idKasBank: idKasBank))
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
    );
  }
}

class ButtonHapus extends StatelessWidget {
  String idKasBank;
  ButtonHapus({Key key, @required this.idKasBank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: authDelt == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authDelt == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalHapusKasBank(idKasBank: idKasBank))
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> listKasBank;
  MyData(this.listKasBank);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(Text(listKasBank[index]['KODE_BANK'], style: styleRowReguler)),
      DataCell(Text(listKasBank[index]['NAMA_BANK'], style: styleRowReguler)),
      DataCell(Text(listKasBank[index]['CHKX_BANK'] == '1' ? 'Bank' : 'Kas',
          style: styleRowReguler)),
      DataCell(Text(listKasBank[index]['DESKRIPSI'], style: styleRowReguler)),
      DataCell(Text(
          "${listKasBank[index]['CURR_MNYX']} - ${listKasBank[index]['CODD_DESC']}",
          style: styleRowReguler)),
      DataCell(Text(listKasBank[index]['NOXX_REKX'], style: styleRowReguler)),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(idKasBank: listKasBank[index]['KODE_BANK']),
            const SizedBox(width: 10),
            ButtonHapus(idKasBank: listKasBank[index]['KODE_BANK']),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listKasBank.length;

  @override
  int get selectedRowCount => 0;
}

class TableKasDanBank extends StatefulWidget {
  List<Map<String, dynamic>> listKasBank;
  TableKasDanBank({Key key, @required this.listKasBank}) : super(key: key);

  @override
  State<TableKasDanBank> createState() => _TableKasDanBankState();
}

class _TableKasDanBankState extends State<TableKasDanBank> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.listKasBank);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.63,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('Kode Bank', style: styleColumn)),
            DataColumn(label: Text('Nama Bank', style: styleColumn)),
            DataColumn(label: Text('Jenis', style: styleColumn)),
            DataColumn(label: Text('Nama Account', style: styleColumn)),
            DataColumn(label: Text('Mata Uang', style: styleColumn)),
            DataColumn(label: Text('Nomor Rekening', style: styleColumn)),
            DataColumn(
                label: Expanded(
              child: Center(
                child: Text('Aksi', style: styleColumn),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
