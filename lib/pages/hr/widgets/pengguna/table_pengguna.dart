// ignore_for_file: unused_local_variable, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/modal_edit_grup_user.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/modal_list_user_grup.dart';
import 'package:flutter_web_course/pages/hr/widgets/pengguna/modal_akses_pengguna.dart';
import 'package:flutter_web_course/pages/hr/widgets/pengguna/modal_edit_pengguna.dart';
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
  String idPengguna;
  String namaPengguna;
  ButtonEdit({Key key, @required this.idPengguna, @required this.namaPengguna})
      : super(key: key);

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
            builder: (context) => ModalEditPengguna(
                  idPengguna: idPengguna,
                  namaPengguna: namaPengguna,
                ));
      },
    );
  }
}

class ButtonUser extends StatelessWidget {
  String idPengguna;
  String namaPengguna;
  ButtonUser({Key key, @required this.idPengguna, @required this.namaPengguna})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.supervised_user_circle_outlined,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalAksesPengguna(
                  idPengguna: idPengguna,
                  namaPengguna: namaPengguna,
                ));
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> listPengguna;
  MyData(this.listPengguna);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listPengguna[index]['USER_IDXX'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listPengguna[index]['KETX_USER'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listPengguna[index]['NAMA_GRUP'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listPengguna[index]['LOGIN_TERAKHIR'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listPengguna[index]['Active'] == '1' ? 'Aktif' : 'Nonaktif',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(
              idPengguna: listPengguna[index]['USER_IDXX'],
              namaPengguna: listPengguna[index]['USER_IDXX'],
            ),
            const SizedBox(width: 10),
            ButtonUser(
                idPengguna: listPengguna[index]['USER_IDXX'],
                namaPengguna: listPengguna[index]['USER_IDXX']),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listPengguna.length;

  @override
  int get selectedRowCount => 0;
}

class TablePengguna extends StatefulWidget {
  List<Map<String, dynamic>> listPengguna;
  TablePengguna({Key key, @required this.listPengguna}) : super(key: key);

  @override
  State<TablePengguna> createState() => _TablePenggunaState();
}

class _TablePenggunaState extends State<TablePengguna> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.listPengguna);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.73,
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
                label: Text('Username',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama User',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Grup',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Login Terakhir',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Status',
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
