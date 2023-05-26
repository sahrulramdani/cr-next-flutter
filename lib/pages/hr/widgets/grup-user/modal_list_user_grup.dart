// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter_web_course/constants/dummy_akses_menu.dart';
import 'package:flutter_web_course/models/http_satuan.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/not_find_widget.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalListUserGrup extends StatefulWidget {
  final String idGrup;
  const ModalListUserGrup({
    Key key,
    @required this.idGrup,
  }) : super(key: key);

  @override
  State<ModalListUserGrup> createState() => _ModalListUserGrupState();
}

class _ModalListUserGrupState extends State<ModalListUserGrup> {
  List<Map<String, dynamic>> listUserGrup = [];

  void getDetailUser() async {
    var id = widget.idGrup;
    var response = await http
        .get(Uri.parse("$urlAddress/menu/grup-user/detail/user/$id"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listUserGrup = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getDetailUser();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
    int x = 1;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.55,
            height: 400,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('List User Grup Marketing',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                listUserGrup.isNotEmpty
                    ? Expanded(
                        child: Container(
                            width: screenWidth,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    DataTable(
                                        headingTextStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Gilroy',
                                            fontSize: 16),
                                        headingRowColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          return Colors.blue;
                                        }),
                                        columns: const [
                                          DataColumn(label: Text('No.')),
                                          DataColumn(label: Text('ID.')),
                                          DataColumn(label: Text('Nama User')),
                                          DataColumn(label: Text('Status')),
                                          DataColumn(
                                              label: Text('Terakhir Login')),
                                        ],
                                        rows: listUserGrup.map((e) {
                                          return DataRow(cells: [
                                            DataCell(Text((x++).toString())),
                                            DataCell(Text(e['USER_IDXX'])),
                                            DataCell(Text(e['KETX_USER'])),
                                            DataCell(Text(e['Active'] == '1'
                                                ? 'Aktif'
                                                : 'Tidak Aktif')),
                                            DataCell(Text(e['LOGIN_TERAKHIR'])),
                                          ]);
                                        }).toList())
                                  ],
                                ),
                              ),
                            )))
                    : Column(
                        children: [
                          Container(
                            height: 200,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset(
                                        'assets/images/hero-alert-fail.png',
                                      )),
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        FittedBox(
                                          child: Text(
                                            'Belum Ada User Di Grup Akses Ini',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FittedBox(
                                          child: Text(
                                            'Pergi ke menu pengguna untuk menambahkan User',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 75,
                          )
                        ],
                      ),
                SizedBox(
                  height: 50,
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
          ),
        )
      ]),
    );
  }
}
