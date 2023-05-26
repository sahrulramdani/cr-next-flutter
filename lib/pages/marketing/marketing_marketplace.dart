// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/card_paket.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/not_find_widget.dart';
import 'package:flutter_web_course/pages/marketing/widgets/marketplace/card_paket_marketplace.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';

class MarketingMarketplacePage extends StatefulWidget {
  const MarketingMarketplacePage({Key key}) : super(key: key);

  @override
  State<MarketingMarketplacePage> createState() =>
      _MarketingMarketplacePageState();
}

class _MarketingMarketplacePageState extends State<MarketingMarketplacePage> {
  String idpaket;
  String namaPaket;
  String keterangan;
  List<Map<String, dynamic>> listPaket = [];
  List<Map<String, dynamic>> listJadwal = [];
  List<Map<String, dynamic>> listJadwalBackup = [];
  TextEditingController dateSearch = TextEditingController();

  void getAuth() async {
    // loadStart();
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

  void getPaket() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getpaket"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    var arr = {"CODD_VALU": "03", "CODD_DESC": "Semua"};

    data.add(arr);

    setState(() {
      listPaket = data;
    });
  }

  void getJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/get-jadwal"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = data;
      listJadwalBackup = data;
    });
  }

  @override
  void initState() {
    getAuth();
    getPaket();
    getJadwal();
    super.initState();
  }

  Widget inputPaket() {
    return SizedBox(
      height: 45,
      child: DropdownSearch(
        label: "Paket",
        mode: Mode.MENU,
        items: listPaket,
        onChanged: (value) {
          namaPaket = value["CODD_DESC"];
          idpaket = value["CODD_VALU"];
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
          namaPaket ?? "Pilih Paket",
          style:
              TextStyle(color: namaPaket == null ? Colors.red : Colors.black),
        ),
        dropdownSearchDecoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          hintText: "Umroh Plus Yaman",
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: myBlue,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: myBlue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: myBlue,
              width: 2.0,
            ),
          ),
        ),
        validator: (value) {
          if (value == "Pilih Paket") {
            return "Paket masih kosong !";
          }
          return null;
        },
      ),
    );
  }

  Widget inputTanggal() {
    return TextFormField(
      controller: dateSearch,
      decoration: InputDecoration(
        labelText: "Keberangkatan",
        hintText: ('DD-MM-YYYY'),
        contentPadding: const EdgeInsets.all(0),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: myBlue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: myBlue,
            width: 2.0,
          ),
        ),
        prefixIcon: const Icon(Icons.calendar_today_outlined),
        prefixIconColor: myBlue,
      ),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateSearch.text = formattedDate;
        }
      },
    );
  }

  Widget inputKeteranganSearch() {
    return SizedBox(
      height: 45,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          hintText: "Umroh Plus Yaman",
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: myBlue,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: myBlue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: myBlue,
              width: 2.0,
            ),
          ),
        ),
        onChanged: (value) {
          keterangan = value;
        },
      ),
    );
  }

  Widget cardIsWeb() {
    int jmlRow = listJadwal.length ~/ 5 + 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < jmlRow; i++)
            Row(
              children: [
                for (var j = (i * 4);
                    j < (i == (jmlRow - 1) ? listJadwal.length : ((i + 1) * 4));
                    j++)
                  CardPaketMarketplace(
                    idPaket: listJadwal[j]['IDXX_JDWL'].toString(),
                    judul: listJadwal[j]['jenisPaket'],
                    keterangan: listJadwal[j]['KETERANGAN'],
                    harga: listJadwal[j]['TARIF_PKET'],
                    mu: listJadwal[j]['MATA_UANG'],
                    sisa: listJadwal[j]['SISA'],
                    foto: listJadwal[j]['FOTO_PKET'],
                    keberangkatan: listJadwal[j]['TGLX_BGKT'],
                    keberangkatanDi: listJadwal[j]['RUTE_AWAL_BRKT'],
                    maskapai: listJadwal[j]['PSWT_BGKT'],
                  )
              ],
            )
        ],
      ),
    );
  }

  Widget cardIsMobile() {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: listJadwal.map((e) {
              return CardPaketMarketplace(
                idPaket: e['IDXX_JDWL'].toString(),
                judul: e['jenisPaket'],
                keterangan: e['KETERANGAN'],
                harga: e['TARIF_PKET'],
                mu: e['MATA_UANG'],
                sisa: e['SISA'],
                foto: e['FOTO_PKET'],
                keberangkatan: e['TGLX_BGKT'],
                keberangkatanDi: e['RUTE_AWAL_BRKT'],
                maskapai: e['PSWT_BGKT'],
              );
            }).toList(),
          ),
        ));
  }

  fncCari() async {
    setState(() {
      listJadwal = listJadwalBackup;
    });

    if (namaPaket != 'Semua') {
      if (namaPaket != null) {
        setState(() {
          listJadwal = listJadwalBackup
              .where(((element) => element['namaPaket']
                  .toString()
                  .toUpperCase()
                  .contains(namaPaket.toUpperCase())))
              .toList();
        });
      }
    }

    if (dateSearch.text != null) {
      if (dateSearch.text != '') {
        setState(() {
          listJadwal = listJadwal
              .where(((element) => element['TGLX_BGKT']
                  .toString()
                  .toUpperCase()
                  .contains(dateSearch.text.toUpperCase())))
              .toList();
        });
      }
    }

    if (keterangan != null) {
      if (keterangan != '') {
        setState(() {
          listJadwal = listJadwal
              .where(((element) => element['KETERANGAN']
                  .toString()
                  .toUpperCase()
                  .contains(keterangan.toUpperCase())))
              .toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final styleButtonCari = ElevatedButton.styleFrom(
      backgroundColor: myBlue,
      minimumSize: ResponsiveWidget.isSmallScreen(context)
          ? const Size(60, 50)
          : const Size(100, 50),
      shadowColor: Colors.grey,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
    );

    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: 'Marketing - ${menuController.activeItem.value}',
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                )
              ],
            )),
        const SizedBox(height: 20),
        screenWidth > 550
            ? Row(
                children: [
                  SizedBox(width: 200, child: inputPaket()),
                  const SizedBox(width: 10),
                  SizedBox(width: 200, height: 45, child: inputTanggal()),
                  const SizedBox(width: 10),
                  Expanded(child: inputKeteranganSearch()),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      fncCari();
                    },
                    icon: const Icon(Icons.search_rounded),
                    label: fncLabelButtonStyle('Cari', context),
                    style: styleButtonCari,
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      getJadwal();
                      idpaket = null;
                      namaPaket = null;
                      keterangan = null;
                      dateSearch.text = '';
                    },
                    icon: const Icon(Icons.clear_rounded),
                    label: fncLabelButtonStyle('Clear', context),
                    style: styleButtonCari,
                  ),
                ],
              )
            : Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: SizedBox(child: inputPaket())),
                      const SizedBox(width: 10),
                      Expanded(
                          child: SizedBox(height: 45, child: inputTanggal())),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: inputKeteranganSearch()),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () async {
                          fncCari();
                        },
                        icon: const Icon(Icons.search_rounded),
                        label: fncLabelButtonStyle('Cari', context),
                        style: styleButtonCari,
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          getJadwal();
                          idpaket = null;
                          namaPaket = null;
                          keterangan = null;
                          dateSearch.text = '';
                        },
                        icon: const Icon(Icons.clear_rounded),
                        label: fncLabelButtonStyle('Clear', context),
                        style: styleButtonCari,
                      ),
                    ],
                  )
                ],
              ),
        const SizedBox(height: 10),
        listJadwal.isNotEmpty
            ? Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: screenWidth < 500 ? cardIsMobile() : cardIsWeb(),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  NotFindWidget(
                    description: "Data Tidak Ditemukan",
                  ),
                ],
              )
      ],
    );
  }
}
