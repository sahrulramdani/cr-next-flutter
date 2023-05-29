import 'package:flutter_web_course/comp/header_title_menu.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/finance/widgets/penerbangan.dart/penerbangan_table.dart';
import 'package:flutter_web_course/pages/inventory/widgets/kirim/table_kirim_barang.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class FinancePenerbanganPage extends StatefulWidget {
  const FinancePenerbanganPage({Key key}) : super(key: key);

  @override
  State<FinancePenerbanganPage> createState() => _FinancePenerbanganPageState();
}

class _FinancePenerbanganPageState extends State<FinancePenerbanganPage> {
  List<Map<String, dynamic>> listProfitJadwal = [];

  void getProfitPenerbangan() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/penerbangan/get-profit"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listProfitJadwal = dataStatus;
    });
  }

  @override
  void initState() {
    getProfitPenerbangan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Obx(() => HeaderTitleMenu(menu: menuController.activeItem.value)),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Jumlah Pembayaran Penerbangan',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: myBlue),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 50,
                            width: ResponsiveWidget.isSmallScreen(context)
                                ? 100
                                : 250,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontFamily: 'Gilroy', fontSize: 14),
                              decoration: const InputDecoration(
                                  hintText: 'Cari Berdasarkan Nama'),
                              onChanged: (value) {
                                if (value == '') {
                                  setState(() {
                                    getProfitPenerbangan();
                                  });
                                } else {
                                  setState(() {
                                    listProfitJadwal = listProfitJadwal
                                        .where(((element) =>
                                            element['namaPaket']
                                                .toString()
                                                .toUpperCase()
                                                .contains(value.toUpperCase())))
                                        .toList();
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TablePenerbangan(
                    dataProfit: listProfitJadwal,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
