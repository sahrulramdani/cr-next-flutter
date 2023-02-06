// ignore_for_file: missing_return, deprecated_member_use, avoid_print, unused_local_variable, must_call_super, dead_code, prefer_interpolation_to_compose_strings
import 'dart:convert';

import 'package:flutter_web_course/constants/dummy_jadwal.dart';
import 'package:flutter_web_course/constants/dummy_data_bandara.dart';
import 'package:flutter_web_course/models/http_jadwal.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';

class JadwalForm extends StatefulWidget {
  const JadwalForm({Key key}) : super(key: key);

  @override
  State<JadwalForm> createState() => _JadwalFormState();
}

class _JadwalFormState extends State<JadwalForm> {
  String namaPaket;
  String idpaket;
  String idjenis;
  String namaJenis;
  String tujuan;
  String jumlahHari;
  String pesawat;
  String rute;
  String namaRute;
  String rute2;
  String namaTransit;
  String rute3;
  String tarif;
  String jumlahSeat;
  String mataUang;
  String idMataUang;
  String keterangan;

  String tglBerangkat;
  String tglPulang;
  TextEditingController dateBerangkat = TextEditingController();
  TextEditingController datePulang = TextEditingController();

  List<Map<String, dynamic>> listJenisPaket = [];
  List<Map<String, dynamic>> listPaket = [];
  List<Map<String, dynamic>> listMataUang = [];
  List<Map<String, dynamic>> listTransit = [];
  List<Map<String, dynamic>> listBandara = dummyDataBandara;

  void getJenisPaket() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/jadwal/getjenispaket"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJenisPaket = data;
    });
  }

  void getPaket() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/jadwal/getpaket"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listPaket = data;
    });
  }

  void getMataUang() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/jadwal/getmatauang"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listMataUang = data;
    });
  }

  void getTransit() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/jadwal/getTransit"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listTransit = data;
    });
  }

  @override
  void initState() {
    getJenisPaket();
    getPaket();
    getMataUang();
    getTransit();
    super.initState();
  }

  Widget inputPaket() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Paket",
        mode: Mode.MENU,
        items: listPaket,
        onChanged: (value) {
          namaPaket = value["CODD_DESC"];
          idpaket = value["CODD_VALU"];
        },
        selectedItem: "Pilih Paket",
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaPaket ?? "Pilih Paket"),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Paket") {
            return "Paket masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputJenisPaket() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Jenis Paket",
        mode: Mode.MENU,
        items: listJenisPaket,
        onChanged: (value) {
          namaJenis = value["CODD_DESC"];
          idjenis = value["CODD_VALU"];
        },
        selectedItem: "Pilih Jenis Paket",
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaJenis ?? "Pilih Jenis Paket"),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Jenis Paket") {
            return "Jenis Paket masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputTujuan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration:
          const InputDecoration(labelText: 'Tujuan Paket', hintText: 'tujuan'),
      onChanged: (value) {
        tujuan = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tujuan masih kosong !";
        }
      },
    );
  }

  Widget inputTglBerangkat() {
    return TextField(
      controller: dateBerangkat,
      decoration: const InputDecoration(labelText: 'Tanggal Berangkat'),
      onChanged: (String value) {
        tglBerangkat = value;
      },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateBerangkat.text = formattedDate;
        }
      },
    );
  }

  Widget inputTanggalPulang() {
    return TextField(
      controller: datePulang,
      decoration: const InputDecoration(labelText: 'Tanggal Pulang'),
      onChanged: (String value) {
        tglPulang = value;
      },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          datePulang.text = formattedDate;
        }
      },
    );
  }

  Widget inputJumlahHari() {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Jumlah Hari'),
      onChanged: (value) {
        jumlahHari = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Jumlah Hari masih kosong !";
        }
      },
    );
  }

  Widget inputPesawat() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Pesawat'),
      onChanged: (value) {
        pesawat = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Pesawat masih kosong !";
        }
      },
    );
  }

  Widget inputRute() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Rute Awal",
          items: listBandara,
          onChanged: (value) {
            // print(value['iata_code']);
            rute = value['iata_code'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item['iata_code']} - ${item['municipality']}"),
                trailing: Text(item['name']),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(rute ?? "Rute Awal belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Rute Awal masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputRute2() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Rute Transit",
          items: listTransit,
          onChanged: (value) {
            rute2 = value['IDXX_RTS'];
            namaTransit = value['NAMA_NEGR'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_NEGR']),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaTransit ?? "Rute Transit belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Rute Transit kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputRute3() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Rute Akhir",
          items: listBandara,
          onChanged: (value) {
            // print(value['iata_code']);
            rute3 = value['iata_code'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item['iata_code']} - ${item['municipality']}"),
                trailing: Text(item['name']),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(rute3 ?? "Rute Akhir belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Rute Akhir masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputTarif() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Tarif'),
      onChanged: (value) {
        tarif = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tarif masih kosong !";
        }
      },
    );
  }

  Widget inputJumlahSeat() {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Jumlah Seat'),
      onChanged: (value) {
        jumlahSeat = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Jumlah Seat masih kosong !";
        }
      },
    );
  }

  Widget inputMataUang() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Mata Uang",
        mode: Mode.MENU,
        items: listMataUang,
        onChanged: (value) {
          mataUang = value["CODD_DESC"];
          idMataUang = value["CODD_VALU"];
        },
        selectedItem: "Pilih Mata Uang",
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(mataUang ?? "Pilih Mata Uang"),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Mata Uang") {
            return "Mata Uang masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Keterangan'),
      onChanged: (value) {
        keterangan = value;
      },
    );
  }

  fncSaveData() {
    // print("ID JADWAL : ${widget.idJadwal}");
    // print("ID PAKET : $idpaket");
    // print("ID JENIS : $idjenis");
    // print("TUJUAN : $tujuan");
    // print("JUMLAH HARI : $jumlahHari");
    // print("PESAWAT : $pesawat");
    // print("RUTE 1 : $rute");
    // print("RUTE 2 : $rute2");
    // print("RUTE 3 : $rute3");
    // print("TARIF : $tarif");
    // print("JUMLAH SEAT : $jumlahSeat");
    // print("MATA UANG : $idMataUang");
    // print("KETERANGAN : $keterangan");
    // print("TANGGAL BERANGKT : ${dateBerangkat.text}");
    // print("TANGGAL PULNG : ${datePulang.text}");
    HttpJadwal.saveJadwal(
            idpaket,
            idjenis,
            tujuan,
            jumlahHari,
            pesawat,
            rute,
            rute2,
            rute3,
            tarif,
            jumlahSeat,
            idMataUang,
            keterangan,
            dateBerangkat.text,
            datePulang.text)
        .then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());
        menuController.changeActiveitemTo('Jadwal');
        navigationController.navigateTo('/mrkt/jadwal');
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tambah Data Baru',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: myBlue),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox(width: 20)),
              ElevatedButton.icon(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    fncSaveData();
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
                  minimumSize: const Size(100, 40),
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  menuController.changeActiveitemTo('Jadwal');
                  navigationController.navigateTo('/mrkt/jadwal');
                },
                icon: const Icon(Icons.cancel),
                label: const Text(
                  'Batal',
                  style: TextStyle(fontFamily: 'Gilroy'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: myBlue,
                  minimumSize: const Size(100, 40),
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 0.47 * screenHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 525,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              inputPaket(),
                              const SizedBox(height: 8),
                              inputJenisPaket(),
                              const SizedBox(height: 8),
                              inputTujuan(),
                              const SizedBox(height: 8),
                              inputTglBerangkat(),
                              const SizedBox(height: 8),
                              inputTanggalPulang(),
                              const SizedBox(height: 8),
                              inputJumlahHari(),
                              const SizedBox(height: 8),
                              inputPesawat(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          width: 525,
                          child: Column(
                            children: [
                              inputRute(),
                              const SizedBox(height: 8),
                              inputRute2(),
                              const SizedBox(height: 8),
                              inputRute3(),
                              const SizedBox(height: 8),
                              inputTarif(),
                              const SizedBox(height: 8),
                              inputJumlahSeat(),
                              const SizedBox(height: 8),
                              inputMataUang(),
                              const SizedBox(height: 8),
                              inputKeterangan(),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
