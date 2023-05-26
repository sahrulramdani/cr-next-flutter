// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print, must_be_immutable, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/models/http_tourleader.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/modal_jadwal_tourleader.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_course/constants/style.dart';

// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalTambahJadwalTL extends StatefulWidget {
  const ModalTambahJadwalTL({Key key}) : super(key: key);

  @override
  State<ModalTambahJadwalTL> createState() => _ModalTambahJadwalTLState();
}

class _ModalTambahJadwalTLState extends State<ModalTambahJadwalTL> {
  String idPaket;
  String namaPaket;
  String tglPaket;
  String idTourlead;
  String namaTourlead;
  String tugas;
  int urut = 0;

  List<Map<String, dynamic>> listJadwal = [];
  List<Map<String, dynamic>> listTourlead = [];
  List<Map<String, dynamic>> listTourleadBertugas = [];

  getJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/get-jadwal"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = dataStatus;
    });
  }

  getTourleader() async {
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/tourlead/get-tourleader"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listTourlead = dataStatus;
    });
  }

  @override
  void initState() {
    getJadwal();
    getTourleader();
    super.initState();
  }

  Widget inputNamaJadwal() {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');

    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Jadwal",
          items: listJadwal,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                idPaket = value['IDXX_JDWL'];
                namaPaket = value["namaPaket"] +
                    ' ' +
                    value['jenisPaket'] +
                    ' - ' +
                    value['KETERANGAN'];

                tglPaket = fncGetTanggal(value['TGLX_BGKT']);
              });
            } else {
              setState(() {
                idPaket = null;
                namaPaket = null;
                tglPaket = null;
              });
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                  item['namaPaket'] +
                      ' - ' +
                      item['jenisPaket'] +
                      ' - ' +
                      item['KETERANGAN'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    item['MATA_UANG'] +
                        ' ' +
                        myformat.format(item['TARIF_PKET']) +
                        ' - ' +
                        'Sisa Seat : ' +
                        item['SISA'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                    fncGetTanggal(item['TGLX_BGKT']) +
                        ' - ' +
                        fncGetTanggal(item['TGLX_PLNG'] ?? '01-12-2023'),
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaPaket ?? "Jadwal Belum dipilih"),
          validator: (value) {
            if (idPaket == null) {
              return "Jadwal Produk masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
    );
  }

  Widget inputTglBerangkat() {
    return TextFormField(
      initialValue: tglPaket ?? 'DD-MM-YYYY',
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Tanggal Berangkap',
          hintText: '',
          filled: true,
          fillColor: Colors.white),
    );
  }

  Widget inputNamaTourleader() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Nama Tourleader",
          items: listTourlead,
          onChanged: (value) {
            if (value != null) {
              idTourlead = value["KDXX_MRKT"];
              namaTourlead = value["NAMA_LGKP"];
            } else {
              idTourlead = null;
              namaTourlead = null;
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_LGKP'].toString()),
                leading: CircleAvatar(
                  backgroundImage: item['FOTO_AGEN'] != ""
                      ? NetworkImage(
                          '$urlAddress/uploads/foto/${item['FOTO_AGEN']}')
                      : const AssetImage('assets/images/box-background.png'),
                ),
                subtitle: Text(item['KDXX_MRKT'].toString()),
                trailing: Text(
                    DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(item['TGLX_LHIR'].toString())),
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) => Text(selectedItem != null
              ? selectedItem['NAMA_LGKP']
              : "Marketing belum Dipilih"),
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
    );
  }

  Widget inputTugas() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Jenis Tugas",
          mode: Mode.MENU,
          items: const [
            "Pembimbing",
            "Terbimbing",
          ],
          onChanged: (value) {
            tugas = value;
          },
          dropdownBuilder: (context, selectedItem) =>
              Text(tugas ?? "Pilih Jenis Tugas"),
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
    );
  }

  fncSaveData(context) {
    List<Map<String, dynamic>> listTugasTL = [];

    for (var i = 0; i < listTourleadBertugas.length; i++) {
      var list = {
        '"NOXX_URUT"': '"${listTourleadBertugas[i]['NOXX_URUT'].toString()}"',
        '"KDXX_MRKT"': '"${listTourleadBertugas[i]['KDXX_MRKT'].toString()}"',
        '"NAMA_MRKT"': '"${listTourleadBertugas[i]['NAMA_MRKT'].toString()}"',
        '"TUGAS"': '"${listTourleadBertugas[i]['TUGAS'].toString()}"',
      };
      listTugasTL.add(list);
    }

    HttpTourleader.saveTugasTourleader(
      idPaket,
      '${listTugasTL}',
    ).then((value) {
      if (value.status == true) {
        Navigator.pop(context);
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => const ModalJadwalTourleader());

        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
    int i = 1;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.7,
            height: 550,
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
                      Text("Tambah Jadwal TL",
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pilih Jadwal Untuk Tourleader",
                          style: TextStyle(
                              color: myBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: inputNamaJadwal()),
                          const SizedBox(width: 15),
                          SizedBox(
                            width: 150,
                            child: inputTglBerangkat(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text("Pilih Tourleader Yang Bertugas",
                          style: TextStyle(
                              color: myBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      Row(
                        children: [
                          Expanded(child: inputNamaTourleader()),
                          const SizedBox(width: 15),
                          SizedBox(
                            width: 150,
                            child: inputTugas(),
                          ),
                          const SizedBox(width: 15),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (namaTourlead != null && tugas != null) {
                                var pushTL = {
                                  "NOXX_URUT": urut.toString(),
                                  "KDXX_MRKT": idTourlead,
                                  "NAMA_MRKT": namaTourlead,
                                  "TUGAS": tugas,
                                };
                                listTourleadBertugas.add(pushTL);
                                setState(() {
                                  idTourlead = null;
                                  namaTourlead = null;
                                  tugas = null;
                                  urut = urut + 1;
                                });
                              }
                            },
                            icon: const Icon(Icons.add),
                            style: fncButtonRegulerStyle(context),
                            label: fncLabelButtonStyle('Tambah', context),
                          ),
                          const SizedBox(width: 15),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                listTourleadBertugas = [];
                              });
                            },
                            icon: const Icon(Icons.refresh),
                            style: fncButtonRegulerStyle(context),
                            label: fncLabelButtonStyle('Clear', context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SizedBox(
                                width: screenWidth,
                                child: DataTable(
                                    headingRowColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      return Colors.blue;
                                    }),
                                    headingTextStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Gilroy',
                                        fontSize: 16),
                                    dataRowHeight: 40,
                                    dataTextStyle:
                                        const TextStyle(fontSize: 13),
                                    columns: const [
                                      DataColumn(label: Text('No.')),
                                      DataColumn(
                                          label: Text('Nama Tourleader')),
                                      DataColumn(
                                          label: Text('Tugas Tourleader')),
                                      DataColumn(label: Text('Aksi')),
                                    ],
                                    rows: listTourleadBertugas.map((e) {
                                      return DataRow(cells: [
                                        DataCell(Text((i++).toString())),
                                        DataCell(Text(e['NAMA_MRKT'])),
                                        DataCell(Text(e['TUGAS'])),
                                        DataCell(IconButton(
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: myBlue,
                                          ),
                                          onPressed: () {
                                            listTourleadBertugas.removeWhere(
                                                (item) =>
                                                    item['NOXX_URUT'] ==
                                                    e['NOXX_URUT']);

                                            setState(() {});
                                          },
                                        )),
                                      ]);
                                    }).toList()),
                              )))
                    ],
                  ),
                )),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            fncSaveData(context);
                          } else {
                            return null;
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text(
                          'Simpan Data',
                          style: TextStyle(fontFamily: 'Gilroy'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myBlue,
                          shadowColor: Colors.grey,
                          elevation: 5,
                        ),
                      ),
                      const SizedBox(width: 10),
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
