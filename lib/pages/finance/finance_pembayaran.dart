import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/finance/widgets/pembayaran/form_pembayaran.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/finance/widgets/pembayaran/pembayaran_info_large.dart';
import 'package:flutter_web_course/pages/finance/widgets/pembayaran/table_pembayaran.dart';
import 'package:flutter_web_course/pages/overview/widgets/overview_card_small.dart';
import 'package:flutter_web_course/pages/overview/widgets/overview_cards_large.dart';
import 'package:flutter_web_course/pages/overview/widgets/overview_cards_medium.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FinancePembayaranPage extends StatefulWidget {
  const FinancePembayaranPage({Key key}) : super(key: key);

  @override
  State<FinancePembayaranPage> createState() => _FinancePembayaranPageState();
}

class _FinancePembayaranPageState extends State<FinancePembayaranPage> {
  List<Map<String, dynamic>> listPembayaranCabang = [];

  void getAuth() async {
    var response = await http.get(
        Uri.parse("$urlAddress/get-permission/$menuKode/$username"),
        headers: {
          'pte-token': kodeToken,
        });

    var auth = json.decode(response.body);
    setState(() {
      authAddx = auth['AUTH_ADDX'];
      authEdit = auth['AUTH_EDIT'];
      authDelt = auth['AUTH_DELT'];
      authInqu = auth['AUTH_INQU'];
      authPrnt = auth['AUTH_PRNT'];
      authExpt = auth['AUTH_EXPT'];
    });
  }

  getPembayaranCabang() async {
    var response =
        await http.get(Uri.parse("$urlAddress/finance/info-data/list-cabang"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listPembayaranCabang = dataStatus;
    });
  }

  @override
  void initState() {
    getAuth();
    getPembayaranCabang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: 'Finance - ${menuController.activeItem.value}',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          const PembayaranInfoLarge(),
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.only(bottom: 20),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      'Pembayaran Berdasarkan Cabang',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: myBlue),
                    ),
                  ),
                  TablePembayaran(dataPembayaran: listPembayaranCabang),
                ],
              ))
        ],
      ),
    );
  }
}
