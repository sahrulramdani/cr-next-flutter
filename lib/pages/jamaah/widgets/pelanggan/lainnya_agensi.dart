// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class LainnyaAgensi extends StatefulWidget {
  const LainnyaAgensi({Key key}) : super(key: key);

  @override
  State<LainnyaAgensi> createState() => _LainnyaAgensiState();
}

class _LainnyaAgensiState extends State<LainnyaAgensi> {
  List<Map<String, dynamic>> listAgency = [];

  void getList() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/all-agency"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listAgency = dataStatus;
    });
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  Widget inputMarketing() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Refrensi",
        mode: Mode.BOTTOM_SHEET,
        items: const [
          "LANGSUNG",
          "MARKETING",
          "MARKETING NONSISTEM",
          "UMROH SMART",
          "TOURLEADER",
          "FREE",
        ],
        onChanged: (value) {},
        selectedItem: "MARKETING",
      ),
    );
  }

  Widget inputNamaMarketing() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Nama Marketing",
        items: listAgency,
        onChanged: (value) {},
        showClearButton: true,
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_LGKP'].toString()),
          leading: const CircleAvatar(),
          subtitle: Text(item['KDXX_AGEN'].toString()),
          trailing: Text(
              DateFormat("dd-MM-yyyy")
                  .format(DateTime.parse(item['TGLX_LHIR'].toString())),
              textAlign: TextAlign.center),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(selectedItem != null ? selectedItem['NAMA_LGKP'] : "Jarsinah"),
      ),
    );
  }

  Widget inputCatatan() {
    return TextFormField(
      initialValue: "Jayadi",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputMarketing(),
            const SizedBox(height: 8),
            inputNamaMarketing(),
            const SizedBox(height: 8),
            inputCatatan(),
          ],
        ),
      ),
    );
  }
}
