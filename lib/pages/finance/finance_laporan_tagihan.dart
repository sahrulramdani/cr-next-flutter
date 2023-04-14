// ignore_for_file: missing_return, deprecated_member_use

import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/finance/widgets/lapor-bayar/table_laporan_pembayaran.dart';
import 'package:flutter_web_course/pages/finance/widgets/lapor-tagihan/table_laporan_tagihan.dart';
import 'package:flutter_web_course/pages/finance/widgets/penerbangan.dart/penerbangan_table.dart';
import 'package:flutter_web_course/pages/inventory/widgets/kirim/table_kirim_barang.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class FinanceLaporanTagihan extends StatefulWidget {
  const FinanceLaporanTagihan({Key key}) : super(key: key);

  @override
  State<FinanceLaporanTagihan> createState() => _FinanceLaporanTagihanState();
}

class _FinanceLaporanTagihanState extends State<FinanceLaporanTagihan> {
  String jenisTagihan = 'Semua';
  String totalTagihan = '0';
  String sisaTagihan = '0';
  String pelanggan = 'ALL';
  String noPelanggan;
  String namaPelanggan;
  String kodeBerangkat = 'ALL';
  String statusBerangkat = 'Semua';
  TextEditingController dateAwal = TextEditingController();
  TextEditingController dateAkhir = TextEditingController();

  List<Map<String, dynamic>> listDataTagihan = [];
  List<Map<String, dynamic>> listPelanggan = [];

  void getHariIni() async {
    loadStart();

    setState(() {
      dateAwal.text =
          DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
      dateAkhir.text =
          DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    });
  }

  void getPelanggan() async {
    var response =
        await http.get(Uri.parse("$urlAddress/jamaah/all-pelanggan"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listPelanggan = dataStatus;
    });

    loadEnd();
  }

  void getDataTagihan() async {
    var tglAwal = fncTanggal(dateAwal.text);
    var tglAkhir = fncTanggal(dateAkhir.text);

    var response = await http.get(
        Uri.parse(
            "$urlAddress/finance/tagihan/get-laporan/$tglAwal/$tglAkhir/$jenisTagihan/$pelanggan/$kodeBerangkat"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    int ttl1 = 0;
    int ttl2 = 0;
    for (var i = 0; i < dataStatus.length; i++) {
      ttl1 += dataStatus[i]['TOTL_TGIH'];
      ttl2 += dataStatus[i]['SISA_TGIH'];
    }

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      totalTagihan = myFormat.format(ttl1);
      sisaTagihan = myFormat.format(ttl2);
      listDataTagihan = dataStatus;
    });
  }

  @override
  void initState() {
    getHariIni();
    getPelanggan();
    super.initState();
  }

  Widget inputTglAwal() {
    return TextFormField(
      controller: dateAwal,
      decoration: const InputDecoration(
          label: Text('Tanggal Awal'), hintText: 'DD-MM-YYYY'),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateAwal.text = formattedDate;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tgl Awal masih kosong !";
        }
      },
    );
  }

  Widget inputTglAkhir() {
    return TextFormField(
      controller: dateAkhir,
      decoration: const InputDecoration(
          label: Text('Tanggal Akhir'), hintText: 'DD-MM-YYYY'),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateAkhir.text = formattedDate;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tgl Akhir masih kosong !";
        }
      },
    );
  }

  Widget inputPilihJamaah() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      height: 50,
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Pilih No Pelanggan",
          items: listPelanggan,
          onChanged: (value) {
            setState(() {
              if (value != null) {
                noPelanggan = value['KDXX_DFTR'];
                namaPelanggan = value['NAMA_LGKP'];
                pelanggan = value['KDXX_DFTR'];
              } else {
                noPelanggan = null;
                namaPelanggan = null;
                pelanggan = 'ALL';
              }
            });
          },
          showClearButton: true,
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                    item['KDXX_DFTR'] +
                        ' - ' +
                        item['NAMA_LGKP'] +
                        ' - ' +
                        item['UMUR'].toString() +
                        ' Tahun, ' +
                        item['JENS_KLMN'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                leading: CircleAvatar(
                  backgroundImage: item['FOTO_JMAH'] != ''
                      ? NetworkImage('$urlAddress/uploads/${item['FOTO_JMAH']}')
                      : const AssetImage('assets/images/NO_IMAGE.jpg'),
                ),
                subtitle: Text(
                    item['NOXX_IDNT'] +
                        ' - No Telp : ' +
                        item['NOXX_TELP'].toString() +
                        ' - TL : ' +
                        item['TMPT_LHIR'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(item['ALAMAT']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(selectedItem != null
              ? "${selectedItem['KDXX_DFTR']} - ${selectedItem['NAMA_LGKP']}"
              : "Nama Jamaah"),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget selectBerangkat(context) {
    return SizedBox(
      height: 50,
      width: ResponsiveWidget.isSmallScreen(context) ? 150 : 200,
      child: DropdownSearch(
        mode: Mode.MENU,
        label: 'Status Berangkat',
        items: const [
          "Semua",
          "Sudah Berangkat",
          "Belum Berangkat",
        ],
        onChanged: (value) {
          setState(() {
            if (value == 'Sudah Berangkat') {
              kodeBerangkat = '1';
            } else if (value == 'Belum Berangkat') {
              kodeBerangkat = '0';
            } else {
              kodeBerangkat = 'ALL';
            }

            statusBerangkat = value;
          });
        },
        selectedItem: "Semua",
      ),
    );
  }

  // Widget selectJenis(context) {
  //   return SizedBox(
  //     height: 50,
  //     width: ResponsiveWidget.isSmallScreen(context) ? 150 : 200,
  //     child: DropdownSearch(
  //       mode: Mode.MENU,
  //       label: 'Jenis Tagihan',
  //       items: const [
  //         "Semua",
  //         "Biaya Paket",
  //         "Vaksin",
  //         "Paspor",
  //         "Biaya Admin",
  //         "Biaya Handling",
  //         "Biaya Kamar",
  //         "Tagihan Sistem Lama",
  //       ],
  //       onChanged: (value) {
  //         setState(() {
  //           jenisTagihan = value;
  //         });
  //       },
  //       selectedItem: "Semua",
  //     ),
  //   );
  // }

  Widget selectJenis(context) {
    return SizedBox(
      height: 50,
      width: ResponsiveWidget.isSmallScreen(context) ? 150 : 200,
      child: DropdownSearch(
        mode: Mode.MENU,
        label: 'Status Lunas',
        items: const [
          "Semua",
          "Lunas",
          "Belum",
        ],
        onChanged: (value) {
          setState(() {
            jenisTagihan = value;
          });
        },
        selectedItem: "Semua",
      ),
    );
  }

  Widget cmdCari() {
    return ElevatedButton.icon(
      onPressed: () async {
        getDataTagihan();
      },
      icon: const Icon(Icons.search_outlined),
      style: fncButtonAuthStyle('1', context),
      label: fncLabelButtonStyle('Cari', context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
          const SizedBox(height: 20),
          Container(
            width: screenWidth,
            padding: const EdgeInsets.all(15),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 120, child: inputTglAwal()),
                    const SizedBox(width: 10),
                    SizedBox(width: 120, child: inputTglAkhir()),
                    Expanded(child: Container()),
                    SizedBox(width: 260, child: inputPilihJamaah()),
                    const SizedBox(width: 10),
                    SizedBox(width: 180, child: selectBerangkat(context)),
                    const SizedBox(width: 10),
                    SizedBox(width: 180, child: selectJenis(context)),
                    const SizedBox(width: 5),
                    cmdCari(),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
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
                          Row(
                            children: [
                              Text(
                                'Total Tagihan : $totalTagihan       -       ',
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: myBlue),
                              ),
                              Text(
                                'Sisa Tagihan : $sisaTagihan',
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: myBlue),
                              ),
                            ],
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
                                  hintText: 'Cari Berdasarkan Nama'),
                              onChanged: (value) {
                                if (value == '') {
                                  getDataTagihan();
                                } else {
                                  setState(() {
                                    listDataTagihan = listDataTagihan
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
                TableLaporanTagihan(dataLaporan: listDataTagihan)
              ],
            ),
          )
        ],
      ),
    );
  }
}
