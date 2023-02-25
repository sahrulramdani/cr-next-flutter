// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/table_detail_perolehan.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/table_laporan_pencapaian.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModalDetailPencapaian extends StatefulWidget {
  String tahun;
  String kode;
  ModalDetailPencapaian({
    Key key,
    @required this.tahun,
    @required this.kode,
  }) : super(key: key);

  @override
  State<ModalDetailPencapaian> createState() => _ModalDetailPencapaianState();
}

class _ModalDetailPencapaianState extends State<ModalDetailPencapaian> {
  List<Map<String, dynamic>> listDetPencapaian = [];

  void getDetPencapaian() async {
    var tahun = widget.tahun;
    var kode = widget.kode;
    var response = await http.get(Uri.parse(
        "$urlAddress/data/dashboard/detail/laporan-pencapaian/$tahun/${kode}"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listDetPencapaian = data;
    });
  }

  @override
  void initState() {
    getDetPencapaian();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.8,
            height: 450,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.people_alt_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('Detail Pencapaian ${widget.kode}',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        TableDetailPencapaian(
                            listDetailPencapaian: listDetPencapaian)
                      ],
                    ),
                  ),
                )),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Kembali'))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
