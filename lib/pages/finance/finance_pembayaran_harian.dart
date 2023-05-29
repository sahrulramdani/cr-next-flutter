// ignore_for_file: missing_return, deprecated_member_use

import 'package:flutter_web_course/comp/header_title_menu.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MyData extends DataTableSource {
  final styleRowKhusus = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 12);

  final List<Map<String, dynamic>> listDataPembayaran;
  MyData(this.listDataPembayaran);
  @override
  DataRow getRow(int index) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(
          Text(listDataPembayaran[index]['TGLX_BYAR'], style: styleRowKhusus)),
      DataCell(
          Text(listDataPembayaran[index]['NOXX_FAKT'], style: styleRowKhusus)),
      DataCell(
          Text(listDataPembayaran[index]['KDXX_DFTR'], style: styleRowKhusus)),
      DataCell(
          Text(listDataPembayaran[index]['NAMA_LGKP'], style: styleRowKhusus)),
      DataCell(
          Text(listDataPembayaran[index]['TGLX_TGIH'], style: styleRowKhusus)),
      DataCell(
          Text(listDataPembayaran[index]['JENS_TGIH'], style: styleRowKhusus)),
      DataCell(
          Text(listDataPembayaran[index]['NAMA_BANK'], style: styleRowKhusus)),
      DataCell(Text(
          myFormat.format(int.parse(listDataPembayaran[index]['DIBAYARKAN'])),
          style: styleRowKhusus)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listDataPembayaran.length;

  @override
  int get selectedRowCount => 0;
}

class FinancePembayaranHarian extends StatefulWidget {
  const FinancePembayaranHarian({Key key}) : super(key: key);

  @override
  State<FinancePembayaranHarian> createState() =>
      _FinancePembayaranHarianState();
}

class _FinancePembayaranHarianState extends State<FinancePembayaranHarian> {
  String kodeBayar = 'XX';
  String caraBayar = 'Semua';
  String jenisTagihan = 'Semua';
  String totalPembayaran = '0';
  String pelanggan = 'ALL';
  String noPelanggan;
  String namaPelanggan;

  TextEditingController dateAwal = TextEditingController();
  TextEditingController dateAkhir = TextEditingController();

  List<Map<String, dynamic>> listDataPembayaran = [];
  List<Map<String, dynamic>> listPelanggan = [];
  List<Map<String, dynamic>> listJenis = [];
  List<Map<String, dynamic>> listCaraBayar = [];

  void getHariIni() async {
    setState(() {
      dateAwal.text =
          DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
      dateAkhir.text =
          DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    });
  }

  void getDataPembayaran() async {
    var tglAwal = fncTanggal(dateAwal.text);
    var tglAkhir = fncTanggal(dateAkhir.text);

    var response = await http.get(
        Uri.parse(
            "$urlAddress/finance/pembayaran/get-laporan/$tglAwal/$tglAkhir/$jenisTagihan/$pelanggan/$kodeBayar"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    int ttl = 0;
    for (var i = 0; i < data.length; i++) {
      ttl += data[i]['DIBAYARKAN'];
    }

    if (data.isNotEmpty) {
      for (var j = 0; j < data.length; j++) {
        var pushData = {
          "NOXX_FAKT":
              "${data[j]['NOXX_FAKT'] != data[j == 0 ? 0 : j - 1]['NOXX_FAKT'] ? data[j]['NOXX_FAKT'] : (j == 0 ? data[j]['NOXX_FAKT'] : '')}",
          "TGLX_BYAR":
              "${data[j]['TGLX_BYAR'] != data[j == 0 ? 0 : j - 1]['TGLX_BYAR'] ? data[j]['TGLX_BYAR'] : (j == 0 ? data[j]['TGLX_BYAR'] : '')}",
          "KDXX_DFTR":
              "${data[j]['KDXX_DFTR'] != data[j == 0 ? 0 : j - 1]['KDXX_DFTR'] ? data[j]['KDXX_DFTR'] : (j == 0 ? data[j]['KDXX_DFTR'] : '')}",
          "NOXX_IDNT":
              "${data[j]['NOXX_IDNT'] != data[j == 0 ? 0 : j - 1]['NOXX_IDNT'] ? data[j]['NOXX_IDNT'] : (j == 0 ? data[j]['NOXX_IDNT'] : '')}",
          "NAMA_LGKP":
              "${data[j]['KDXX_DFTR'] != data[j == 0 ? 0 : j - 1]['KDXX_DFTR'] ? data[j]['NAMA_LGKP'] : (j == 0 ? data[j]['NAMA_LGKP'] : '')}",
          "NOXX_TGIH": "${data[j]['NOXX_TGIH']}",
          "TGLX_TGIH":
              "${data[j]['NOXX_FAKT'] != data[j == 0 ? 0 : j - 1]['NOXX_FAKT'] ? data[j]['TGLX_TGIH'] : (j == 0 ? data[j]['TGLX_TGIH'] : '')}",
          "JENS_TGIH": "${data[j]['JENS_TGIH']}",
          "TARIF_TGIH": "${data[j]['TARIF_TGIH']}",
          "DIBAYARKAN": "${data[j]['DIBAYARKAN']}",
          "NAMA_BANK":
              "${data[j]['NOXX_FAKT'] != data[j == 0 ? 0 : j - 1]['NOXX_FAKT'] ? data[j]['NAMA_BANK'] : (j == 0 ? data[j]['NAMA_BANK'] : '')}",
          "KETERANGAN": "${data[j]['KETERANGAN']}",
          "KETX_USER": "${data[j]['KETX_USER']}",
          // "JENS_TGIH":
          //     "${data[j]['JENS_TGIH'] != data[j == 0 ? 0 : j - 1]['JENS_TGIH'] ? data[j]['JENS_TGIH'] : (j == 0 ? data[j]['JENS_TGIH'] : '')}",
        };

        listDataPembayaran.add(pushData);
      }
    }

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      totalPembayaran = myFormat.format(ttl);
    });

    loadEnd();
  }

  void getJenisTagihan() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/pendapatan-biaya/8901"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listJenis = dataStatus;
    });
  }

  void getCaraBayar() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/all-carabayar"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listCaraBayar = dataStatus;
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

  @override
  void initState() {
    getHariIni();
    getPelanggan();
    getJenisTagihan();
    getCaraBayar();
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

  Widget selectJenis() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.MENU,
        label: "Jenis Tagihan",
        items: listJenis,
        showClearButton: true,
        onChanged: (value) {
          if (value != null) {
            jenisTagihan = value['DESKRIPSI'];
          } else {
            jenisTagihan = 'Semua';
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['DESKRIPSI'] ?? '-'),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(jenisTagihan ?? "Pilih Kas/Bank"),
        dropdownSearchDecoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget inputCaraBayar() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.MENU,
        label: "Sumber Kas/Bank",
        items: listCaraBayar,
        onChanged: (value) {
          if (value != null) {
            kodeBayar = value['KODE_BANK'];
            caraBayar = value['NAMA_BANK'];
          } else {
            kodeBayar = 'XX';
            caraBayar = 'Semua';
          }
        },
        showSearchBox: true,
        showClearButton: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_BANK'] ?? '-'),
        ),
        dropdownBuilder: (context, selectedItem) => Text(caraBayar ?? "Semua"),
        dropdownSearchDecoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget cmdCari() {
    return ElevatedButton.icon(
      onPressed: () async {
        loadStart();
        getDataPembayaran();
      },
      icon: const Icon(Icons.search_outlined),
      style: fncButtonAuthStyle('1', context),
      label: fncLabelButtonStyle('Cari', context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(listDataPembayaran);

    return Column(
      children: [
        Obx(() => HeaderTitleMenu(menu: menuController.activeItem.value)),
        const SizedBox(height: 10),
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
                  SizedBox(width: 150, child: inputTglAwal()),
                  const SizedBox(width: 10),
                  SizedBox(width: 150, child: inputTglAkhir()),
                  Expanded(child: Container()),
                  SizedBox(width: 260, child: inputPilihJamaah()),
                  const SizedBox(width: 10),
                  SizedBox(width: 160, child: selectJenis()),
                  const SizedBox(width: 10),
                  SizedBox(width: 200, child: inputCaraBayar()),
                  const SizedBox(width: 5),
                  cmdCari(),
                ],
              )
            ],
          ),
        ),
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
                            'Total Pembayaran : $totalPembayaran',
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
                                  hintText: 'Cari Berdasarkan Nama'),
                              onChanged: (value) {
                                if (value == '') {
                                  getDataPembayaran();
                                } else {
                                  setState(() {
                                    listDataPembayaran = listDataPembayaran
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
                  child: SizedBox(
                    width: screenWidth,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: PaginatedDataTable(
                        columnSpacing: listDataPembayaran.isEmpty ? 35 : 30,
                        dataRowHeight: 25,
                        rowsPerPage: 150,
                        source: myTable,
                        columns: const [
                          DataColumn(label: Text('No.', style: styleColumn)),
                          DataColumn(
                              label: Text('Tanggal', style: styleColumn)),
                          DataColumn(
                              label:
                                  Text('Nomor Transaksi', style: styleColumn)),
                          DataColumn(
                              label: Text('Kode Daftar', style: styleColumn)),
                          DataColumn(
                              label: Text('Nama Jamaah', style: styleColumn)),
                          DataColumn(
                              label: Text('Tgl Tagihan', style: styleColumn)),
                          DataColumn(
                              label: Text('Nama Tagihan', style: styleColumn)),
                          DataColumn(
                              label: Text('Cara Bayar', style: styleColumn)),
                          DataColumn(label: Text('Jumlah', style: styleColumn)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
