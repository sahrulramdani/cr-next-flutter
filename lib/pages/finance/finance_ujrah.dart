import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/header_title_menu.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/pages/finance/widgets/ujrah/table_transaksi.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FinanceUjrahPage extends StatefulWidget {
  const FinanceUjrahPage({Key key}) : super(key: key);

  @override
  State<FinanceUjrahPage> createState() => _FinanceUjrahPageState();
}

class _FinanceUjrahPageState extends State<FinanceUjrahPage> {
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

  @override
  void initState() {
    getAuth();
    super.initState();
  }

  Widget cmdPrint() {
    return ElevatedButton.icon(
      onPressed: () {
        authPrnt == '1'
            ? ''
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.print_outlined),
      label: const Text(
        'Print Proses',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: authPrnt == '1' ? myBlue : Colors.blue[200],
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdRekap() {
    return ElevatedButton.icon(
      onPressed: () {
        authPrnt == '1'
            ? ''
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.print_outlined),
      label: const Text(
        'Print Transaksi',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: authPrnt == '1' ? myBlue : Colors.blue[200],
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget spacePemisah() {
    return const SizedBox(
      height: 10,
      width: 10,
    );
  }

  Widget menuButton() => Container(
        height: 50,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                cmdPrint(),
                //---------------------------------
                spacePemisah(),
                //---------------------------------
                cmdRekap(),
              ],
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(children: [
      Obx(() => HeaderTitleMenu(menu: menuController.activeItem.value)),
      const SizedBox(height: 10),
      SizedBox(
        height: 120,
        width: screenWidth,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: listCardTransaksi.map((data) {
            return MyCardInfo(title: data['title'], total: data['total']);
          }).toList(),
        ),
      ),
      const SizedBox(height: 10),
      menuButton(),
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
                          'Perhitungan Ujrah Marketing',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          width: 250,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: TextFormField(
                            style: const TextStyle(
                                fontFamily: 'Gilroy', fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: 'Cari Berdasarkan Faktur'),
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Expanded(child: TableTransaksi()),
            ],
          ),
        ),
      )
    ]);
  }
}
