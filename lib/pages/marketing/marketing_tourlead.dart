import 'package:flutter_web_course/comp/header_title_menu.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/modal_jadwal_tourleader.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/modal_pemberangkatan_tourlead.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/table_tourleader.dart';

class MarketingTourleadPage extends StatefulWidget {
  const MarketingTourleadPage({Key key}) : super(key: key);

  @override
  State<MarketingTourleadPage> createState() => _MarketingTourleadPageState();
}

class _MarketingTourleadPageState extends State<MarketingTourleadPage> {
  String kodeLevel = 'XXXX';
  String namaLevel = 'Semua';
  List<Map<String, dynamic>> listTourleader = [];
  List<Map<String, dynamic>> listFeeLevel = [];
  List<Map<String, dynamic>> listTourleaderBackup = [];

  void getAuth() async {
    loadStart();
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

  void getFeeLevel() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/fee-level"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    var tambah = {
      "CODD_VALU": "XXXX",
      "CODD_DESC": "Semua",
    };

    data.add(tambah);

    setState(() {
      listFeeLevel = data;
    });
  }

  void getTourlead() async {
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/tourlead/all-tourleader"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listTourleader = data;
      listTourleaderBackup = data;
    });
    loadEnd();
  }

  @override
  void initState() {
    getAuth();
    getFeeLevel();
    getTourlead();
    super.initState();
  }

  Widget cmdJadwalTL() {
    return ElevatedButton.icon(
      onPressed: () {
        authAddx == '1'
            ? showDialog(
                context: context,
                builder: (context) => const ModalJadwalTourleader())
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.collections_bookmark_outlined),
      style: fncButtonAuthStyle(authAddx, context),
      label: fncLabelButtonStyle('Jadwal TL', context),
    );
  }

  Widget cmdTlBerangkat() {
    return ElevatedButton.icon(
      onPressed: () {
        authInqu == '1'
            ? showDialog(
                context: context,
                builder: (context) => const ModalPemberangkatanTourlead())
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.list_alt_outlined),
      style: fncButtonAuthStyle(authInqu, context),
      label: fncLabelButtonStyle('Pemberangkatan TL', context),
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
                cmdJadwalTL(),
                //---------------------------------
                spacePemisah(),
                //---------------------------------
                cmdTlBerangkat(),
              ],
            ),
          ],
        ),
      );

  Widget inputFilter() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        mode: Mode.MENU,
        items: listFeeLevel,
        onChanged: (value) {
          namaLevel = value["CODD_DESC"];
          kodeLevel = value["CODD_VALU"];

          fncFilterFee(namaLevel);
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(namaLevel ?? "Semua"),
      ),
    );
  }

  fncFilterFee(level) {
    setState(() {
      listTourleader = listTourleaderBackup;
    });

    if (level == 'Semua') {
      setState(() {
        listTourleader = listTourleaderBackup;
      });
    } else {
      setState(() {
        listTourleader = listTourleaderBackup
            .where(((element) => element['FEE_LEVEL']
                .toString()
                .toUpperCase()
                .contains(level.toString().toUpperCase())))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Obx(() => HeaderTitleMenu(menu: menuController.activeItem.value)),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          width: screenWidth,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: listCardTourleader.map((data) {
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
                            'Pengelolaan Tour Leader',
                            style: fncTextHeaderFormStyle(context),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 200,
                            child: inputFilter(),
                          ),
                          Container(
                            height: 50,
                            width: ResponsiveWidget.isSmallScreen(context)
                                ? 100
                                : 200,
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
                                    getTourlead();
                                  });
                                } else {
                                  setState(() {
                                    listTourleader = listTourleaderBackup
                                        .where(((element) =>
                                            element['NAMA_LGKP']
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
                  child: TableTourleader(
                    dataTourleader: listTourleader,
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
