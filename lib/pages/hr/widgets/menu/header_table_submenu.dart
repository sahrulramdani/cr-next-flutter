// ignore_for_file: missing_return, deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables
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

class HeaderTableSubmenu extends StatefulWidget {
  List<Map<String, dynamic>> listSubmenu;
  HeaderTableSubmenu({
    Key key,
    this.listSubmenu,
  }) : super(key: key);

  @override
  State<HeaderTableSubmenu> createState() => _HeaderTableSubmenuState();
}

class _HeaderTableSubmenuState extends State<HeaderTableSubmenu> {
  int x = 1;
  @override
  Widget build(BuildContext context) {
    return DataTable(
        border: TableBorder.all(color: Colors.blue[900]),
        headingRowHeight: 40,
        dataRowHeight: 0,
        columnSpacing: 70,
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
          DataColumn(label: Text('No')),
          DataColumn(label: Text('ID Submenu')),
          DataColumn(label: Text('Nama Submenu')),
          DataColumn(label: Text('Action')),
        ],
        rows: widget.listSubmenu != 0
            ? widget.listSubmenu.map((e) {
                return DataRow(cells: [
                  DataCell(Text((x++).toString() ?? " ")),
                  DataCell(Text(e['SUBMENU_CODE'] ?? " ")),
                  DataCell(Text(e['SUBMENU_NAME'] ?? " ")),
                  DataCell(Text("eeeeee")),
                ]);
              }).toList()
            : DataRow(cells: [
                DataCell(Text("")),
                DataCell(Text("")),
                DataCell(Text("")),
                DataCell(Text("")),
              ]));
  }
}
