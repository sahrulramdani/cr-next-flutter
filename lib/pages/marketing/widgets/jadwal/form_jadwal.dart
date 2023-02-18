// ignore_for_file: missing_return, deprecated_member_use, avoid_print, unused_local_variable, must_call_super, dead_code, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, prefer_const_constructors, duplicate_import
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
import 'package:flutter_web_course/controllers/func_all.dart';
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
  String namaTujuan;
  String jumlahHari;
  String tarif;
  String jumlahSeat;
  String mataUang;
  String idMataUang;
  String keterangan;

  String rute;
  String rute2;
  String rute3;
  String namaTransit;
  String ruteAwalPlng;
  String ruteTransitPlng;
  String namaRuteTransitPlng;
  String ruteAkhirPlng;

  String pesawatBerangkat;
  String namaPesawatBerangkat;
  String pesawatPulang;
  String namaPesawatPulang;

  String idHotelMek;
  String namaHotelMek;
  String idHotelMad;
  String namaHotelMad;
  String idHotelJed;
  String namaHotelJed;
  String idHotelTra;
  String namaHotelTra;

  bool enableTujuan = false;

  String tglBerangkat;
  String tglPulang;
  TextEditingController dateBerangkat = TextEditingController();
  TextEditingController datePulang = TextEditingController();

  List<Map<String, dynamic>> listJenisPaket = [];
  List<Map<String, dynamic>> listPaket = [];
  List<Map<String, dynamic>> listMataUang = [];
  List<Map<String, dynamic>> listTransit = [];
  List<Map<String, dynamic>> listBandara = dummyDataBandara;
  List<Map<String, dynamic>> listMaskapai = [];
  List<Map<String, dynamic>> listHotel = [];
  List<Map<String, dynamic>> listTujuan = [];

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

  void getMaskapai() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/jadwal/getMaskapai"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listMaskapai = data;
    });
  }

  void getHotel() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/jadwal/getHotel"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listHotel = data;
    });
  }

  void getTujuan() async {
    var response = await http.get(Uri.parse("$urlAddress/setup/plus-tujuan"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listTujuan = data;
    });
  }

  @override
  void initState() {
    getJenisPaket();
    getPaket();
    getMataUang();
    getTransit();
    getMaskapai();
    getHotel();
    getTujuan();
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
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
          namaPaket ?? "Pilih Paket",
          style:
              TextStyle(color: namaPaket == null ? Colors.red : Colors.black),
        ),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Paket") {
            return "Paket masih kosong !";
          }
          return null;
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
          if (value['CODD_VALU'] == '02' || value['CODD_VALU'] == '04') {
            setState(() {
              enableTujuan = true;
            });
          } else {
            setState(() {
              enableTujuan = false;
              tujuan = null;
              namaTujuan = null;
            });
          }
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
          namaJenis ?? "Pilih Jenis Paket",
          style:
              TextStyle(color: namaJenis == null ? Colors.red : Colors.black),
        ),
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

  Widget inputHotelMek() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Hotel Mekkah",
          items: listHotel,
          onChanged: (value) {
            // print(value['iata_code']);
            idHotelMek = value['IDXX_HTLX'];
            namaHotelMek = value['NAMA_HTLX'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title:
                    Text("${item['NAMA_HTLX']} - Bintang ${item['CODD_DESC']}"),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                namaHotelMek ?? "Hotel belum Dipilih",
                style: TextStyle(
                    color: namaHotelMek == null ? Colors.red : Colors.black),
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputHotelMad() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Hotel Madinah",
          items: listHotel,
          onChanged: (value) {
            // print(value['iata_code']);
            idHotelMad = value['IDXX_HTLX'];
            namaHotelMad = value['NAMA_HTLX'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title:
                    Text("${item['NAMA_HTLX']} - Bintang ${item['CODD_DESC']}"),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                namaHotelMad ?? "Hotel belum Dipilih",
                style: TextStyle(
                    color: namaHotelMad == null ? Colors.red : Colors.black),
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputHotelJed() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Hotel Jeddah",
          items: listHotel,
          onChanged: (value) {
            // print(value['iata_code']);
            idHotelJed = value['IDXX_HTLX'];
            namaHotelJed = value['NAMA_HTLX'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title:
                    Text("${item['NAMA_HTLX']} - Bintang ${item['CODD_DESC']}"),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                namaHotelJed ?? "Hotel belum Dipilih",
                style: TextStyle(
                    color: namaHotelJed == null ? Colors.red : Colors.black),
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputHotelTra() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Hotel Transit",
          items: listHotel,
          onChanged: (value) {
            // print(value['iata_code']);
            idHotelTra = value['IDXX_HTLX'];
            namaHotelTra = value['NAMA_HTLX'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title:
                    Text("${item['NAMA_HTLX']} - Bintang ${item['CODD_DESC']}"),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                namaHotelTra ?? "Hotel belum Dipilih",
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputTujuan() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          enabled: enableTujuan,
          mode: Mode.BOTTOM_SHEET,
          label: "Tujuan",
          items: listTujuan,
          onChanged: (value) {
            tujuan = value['KDXX_VALU'];
            namaTujuan = value['KDXX_DESC'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['KDXX_DESC']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                namaTujuan ?? 'Tujuan Hanya Untuk Jenis Plus',
                style: TextStyle(
                    color: tujuan == null ? Colors.red : Colors.black),
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputTglBerangkat() {
    return TextField(
      controller: dateBerangkat,
      decoration: const InputDecoration(
          label: Text("Tanggal Berangkat", style: TextStyle(color: Colors.red)),
          hintText: "DD-MM-YYYY"),
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
      decoration: const InputDecoration(
          label: Text("Tanggal Pulang", style: TextStyle(color: Colors.red)),
          hintText: "DD-MM-YYYY"),
      onChanged: (String value) {},
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
        setState(() {
          var tglAwal = fncTanggal(dateBerangkat.text);
          var tglAkhir = fncTanggal(datePulang.text);
          DateTime formattgl1 = DateTime.parse(tglAwal);
          DateTime formattgl2 = DateTime.parse(tglAkhir);
          var difference = formattgl2.difference(formattgl1).inDays + 1;
          jumlahHari = difference.toString();
        });
      },
      onSubmitted: (value) {
        setState(() {
          var tglAwal = fncTanggal(dateBerangkat.text);
          var tglAkhir = fncTanggal(datePulang.text);
          DateTime formattgl1 = DateTime.parse(tglAwal);
          DateTime formattgl2 = DateTime.parse(tglAkhir);
          var difference = formattgl2.difference(formattgl1).inDays + 1;
          jumlahHari = difference.toString();
        });
      },
    );
  }

  Widget inputJumlahHari() {
    return TextFormField(
      initialValue: jumlahHari,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text(
        "Jumlah Hari",
        style: TextStyle(color: Colors.red),
      )),
      // onChanged: (value) {
      //   jumlahHari = value;
      // },
      validator: (value) {
        if (value.isEmpty) {
          return "Jumlah Hari masih kosong !";
        }
      },
      readOnly: true,
    );
  }

  Widget inputPesawatBerangkat() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Maskapai Berangkat",
          items: listMaskapai,
          onChanged: (value) {
            // print(value['iata_code']);
            pesawatBerangkat = value['IDXX_PSWT'];
            namaPesawatBerangkat = value['NAMA_PSWT'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item['NAMA_PSWT']}"),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                namaPesawatBerangkat ?? "Maskapai belum Dipilih",
                style: TextStyle(
                    color: namaPesawatBerangkat == null
                        ? Colors.red
                        : Colors.black),
              ),
          validator: (value) {
            if (value == null) {
              return "Maskapai masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputPesawatPulang() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Maskapai Pulang",
          items: listMaskapai,
          onChanged: (value) {
            // print(value['iata_code']);
            pesawatPulang = value['IDXX_PSWT'];
            namaPesawatPulang = value['NAMA_PSWT'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item['NAMA_PSWT']}"),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                namaPesawatPulang ?? "Maskapai belum Dipilih",
                style: TextStyle(
                    color:
                        namaPesawatPulang == null ? Colors.red : Colors.black),
              ),
          validator: (value) {
            if (value == null) {
              return "Maskapai masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
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
          label: "Rute Awal Berangkat",
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
          dropdownBuilder: (context, selectedItem) => Text(
                rute ?? "Rute Awal Berangkat belum Dipilih",
                style:
                    TextStyle(color: rute == null ? Colors.red : Colors.black),
              ),
          validator: (value) {
            if (value == null) {
              return "Rute Awal Berangkat masih kosong !";
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
          label: "Rute Transit Berangkat",
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
              Text(namaTransit ?? "Rute Transit Berangkat belum Dipilih"),
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
          label: "Rute Akhir Berangkat",
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
          dropdownBuilder: (context, selectedItem) => Text(
                rute3 ?? "Rute Akhir Berangkat belum Dipilih",
                style:
                    TextStyle(color: rute3 == null ? Colors.red : Colors.black),
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputRuteAwalPlng() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Rute Awal Pulang",
          items: listBandara,
          onChanged: (value) {
            // print(value['iata_code']);
            ruteAwalPlng = value['iata_code'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item['iata_code']} - ${item['municipality']}"),
                trailing: Text(item['name']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                ruteAwalPlng ?? "Rute Awal Pulang belum Dipilih",
                style: TextStyle(
                    color: ruteAwalPlng == null ? Colors.red : Colors.black),
              ),
          validator: (value) {
            if (value == null) {
              return "Rute Awal Pulang masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputRuteTransitPlng() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Rute Transit Pulang",
          items: listTransit,
          onChanged: (value) {
            ruteTransitPlng = value['IDXX_RTS'];
            namaRuteTransitPlng = value['NAMA_NEGR'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_NEGR']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                namaRuteTransitPlng ?? "Rute Transit Pulang belum Dipilih",
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputRuteAkhirPlng() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Rute Akhir Pulang",
          items: listBandara,
          onChanged: (value) {
            // print(value['iata_code']);
            ruteAkhirPlng = value['iata_code'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item['iata_code']} - ${item['municipality']}"),
                trailing: Text(item['name']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                ruteAkhirPlng ?? "Rute Akhir Pulang belum Dipilih",
                style: TextStyle(
                    color: ruteAkhirPlng == null ? Colors.red : Colors.black),
              ),
          validator: (value) {
            if (value == null) {
              return "Rute Akhir Pulang masih kosong !";
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
      decoration: const InputDecoration(
          label: Text(
        "Tarif",
        style: TextStyle(color: Colors.red),
      )),
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
      decoration: const InputDecoration(
          label: Text(
        "Jumlah Seat",
        style: TextStyle(color: Colors.red),
      )),
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
        dropdownBuilder: (context, selectedItem) => Text(
          mataUang ?? "Pilih Mata Uang",
          style: TextStyle(color: mataUang == null ? Colors.red : Colors.black),
        ),
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
    // print("ID PAKET : $idpaket");
    // print("ID JENIS : $idjenis");
    // print("TUJUAN : $tujuan");
    // print("HOTEL MEK : $idHotelMek");
    // print("HOTEL MAD : $idHotelMad");
    // print("HOTEL JED : $idHotelJed");
    // print("HOTEL TRA : $idHotelTra");
    // print("JUMLAH HARI : $jumlahHari");
    // print("PESAWAT BRGKT : $pesawatBerangkat");
    // print("PESAWAT PLANG : $pesawatPulang");
    // print("RUTE AWAL BERANGKAT : $rute");
    // print("RUTE TRANSIT BERANGKAT : $rute2");
    // print("RUTE PULANG BERANGKAT : $rute3");
    // print("RUTE AWAL PULANG : $ruteAwalPlng ");
    // print("RUTE TRANSIT PULANG : $ruteTransitPlng ");
    // print("RUTE AKHIR PULANG : $ruteAkhirPlng ");
    // print("TARIF : $tarif");
    // print("JUMLAH SEAT : $jumlahSeat");
    // print("MATA UANG : $idMataUang");
    // print("KETERANGAN : $keterangan");
    // print("TANGGAL BERANGKT : ${dateBerangkat.text}");
    // print("TANGGAL PULNG : ${datePulang.text}");
    HttpJadwal.saveJadwal(
            idpaket,
            idjenis,
            tujuan ?? '',
            idHotelMek ?? '',
            idHotelMad ?? '',
            idHotelJed ?? '',
            idHotelTra ?? '',
            jumlahHari,
            pesawatBerangkat ?? '',
            pesawatPulang ?? '',
            rute,
            rute2 ?? "",
            rute3,
            ruteAwalPlng,
            ruteTransitPlng ?? "",
            ruteAkhirPlng,
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
      } else if (value.status == false) {
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
                    Divider(
                      color: myBlue,
                      thickness: 10,
                    ),
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
                              inputTglBerangkat(),
                              const SizedBox(height: 8),
                              inputTanggalPulang(),
                              const SizedBox(height: 8),
                              inputJumlahHari(),
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
                              inputTujuan(),
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 525,
                          child: Column(
                            children: [
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              Text(
                                "Maskapai Berangkat",
                                style: TextStyle(
                                  color: myBlue,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              inputPesawatBerangkat()
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
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              Text(
                                "Maskapai Pulang",
                                style: TextStyle(
                                  color: myBlue,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              inputPesawatPulang()
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 525,
                          child: Column(
                            children: [
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              Text(
                                "Rute Berangkat",
                                style: TextStyle(
                                  color: myBlue,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              inputRute(),
                              const SizedBox(height: 8),
                              inputRute2(),
                              const SizedBox(height: 8),
                              inputRute3(),
                              const SizedBox(height: 8),
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
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              Text(
                                "Rute Pulang",
                                style: TextStyle(
                                  color: myBlue,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              inputRuteAwalPlng(),
                              const SizedBox(height: 8),
                              inputRuteTransitPlng(),
                              const SizedBox(height: 8),
                              inputRuteAkhirPlng(),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 525,
                          child: Column(
                            children: [
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              Text(
                                "Pilihan Hotel",
                                style: TextStyle(
                                  color: myBlue,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              inputHotelMek(),
                              const SizedBox(height: 8),
                              inputHotelMad(),
                              const SizedBox(height: 8),
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
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              Text(
                                "Pilihan Hotel",
                                style: TextStyle(
                                  color: myBlue,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Divider(
                                color: myBlue,
                                thickness: 1.5,
                                height: 30,
                              ),
                              inputHotelJed(),
                              const SizedBox(height: 8),
                              inputHotelTra(),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    )
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
