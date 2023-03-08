// ignore_for_file: missing_return, deprecated_member_use
import 'package:flutter_web_course/constants/dummy_akses_menu.dart';
import 'package:flutter_web_course/models/http_satuan.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:intl/intl.dart';

class HeaderTableGrupUser extends StatefulWidget {
  List<Map<String, dynamic>> listMenuAkses;
  HeaderTableGrupUser({
    Key key,
    this.listMenuAkses,
  }) : super(key: key);

  @override
  State<HeaderTableGrupUser> createState() => _HeaderTableGrupUserState();
}

class _HeaderTableGrupUserState extends State<HeaderTableGrupUser> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
        border: TableBorder.all(color: Colors.blue[900]),
        headingRowHeight: 40,
        dataRowHeight: 0,
        columnSpacing: 40,
        headingTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy',
            fontSize: 16),
        headingRowColor: MaterialStateColor.resolveWith(
          (states) {
            return myBlue;
          },
        ),
        columns: const [
          DataColumn(label: Text('All')),
          DataColumn(label: Text('Program')),
          DataColumn(label: Text('Module')),
          DataColumn(label: Text('Type')),
          DataColumn(label: Text('ADD')),
          DataColumn(label: Text('EDIT')),
          DataColumn(label: Text('DELETE')),
          DataColumn(label: Text('SELECT')),
          DataColumn(label: Text('PRINT')),
          DataColumn(label: Text('EXPORT')),
        ],
        rows: widget.listMenuAkses.map((e) {
          return DataRow(cells: [
            const DataCell(Text('eeee')),
            DataCell(Text(e['MENU_NAME'])),
            DataCell(Text(e['MDUL_CODE'])),
            DataCell(Text(e['TYPE_MDUL'])),
            const DataCell(Text('eeeeeeiii')),
            const DataCell(Text('eeeeeeiii')),
            const DataCell(Text('eeeeeeiii')),
            const DataCell(Text('eeeeeeiii')),
            const DataCell(Text('eeeeeeiii')),
            const DataCell(Text('eeeeeeiii')),
          ]);
        }).toList());
  }
}
