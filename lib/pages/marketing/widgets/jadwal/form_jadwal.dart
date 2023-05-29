// ignore_for_file: missing_return, deprecated_member_use, avoid_print, unused_local_variable, must_call_super, dead_code, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, prefer_const_constructors, duplicate_import
import 'dart:convert';
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
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class JadwalForm extends StatefulWidget {
  const JadwalForm({Key key}) : super(key: key);

  @override
  State<JadwalForm> createState() => _JadwalFormState();
}

class _JadwalFormState extends State<JadwalForm> {
  final formKey = GlobalKey<FormState>();

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

  String fotoJadwal = "";
  String fotoJadwalBase = "";
  Uint8List fotoJadwalByte;

  bool enableTujuan = false;

  String tglBerangkat;
  String tglPulang;
  TextEditingController dateBerangkat = TextEditingController();
  TextEditingController datePulang = TextEditingController();

  List<Map<String, dynamic>> listJenisPaket = [];
  List<Map<String, dynamic>> listPaket = [];
  List<Map<String, dynamic>> listMataUang = [];
  List<Map<String, dynamic>> listTransit = [];
  List<Map<String, dynamic>> listBandara = [];
  List<Map<String, dynamic>> listMaskapai = [];
  List<Map<String, dynamic>> listHotelMekkah = [];
  List<Map<String, dynamic>> listHotelMadinah = [];
  List<Map<String, dynamic>> listHotelPlus = [];
  List<Map<String, dynamic>> listHotelTambahan = [];
  List<Map<String, dynamic>> listTujuan = [];

  void getJenisPaket() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getjenispaket"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJenisPaket = data
          .where(((element) => element['CODD_DESC']
              .toString()
              .toUpperCase()
              .contains(namaPaket.toUpperCase())))
          .toList();
    });
  }

  void getPaket() async {
    loadStart();

    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getpaket"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listPaket = data;
    });
  }

  void getMataUang() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getmatauang"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listMataUang = data;
    });
  }

  void getTransit() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getTransit"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listTransit = data;
      listTujuan = data;
    });
  }

  void getMaskapai() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getMaskapai"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listMaskapai = data;
    });
  }

  void getBandara() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/bandara/get-all"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listBandara = data;
    });
  }

  void getHotel() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getHotel"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listHotelMekkah = data
          .where(((element) =>
              element['LOKX_HTLX'].toString().toUpperCase().contains('MEKKAH')))
          .toList();
      listHotelMadinah = data
          .where(((element) => element['LOKX_HTLX']
              .toString()
              .toUpperCase()
              .contains('MADINAH')))
          .toList();
      listHotelPlus = data
          .where(((element) =>
              element['KTGR_HTLX'].toString() == '02' ||
              element['KTGR_HTLX'].toString() == '03'))
          .toList();
      listHotelTambahan = data;
    });

    loadEnd();
  }

  // void getHotelMekkah() async {
  //   var response = await http.get(
  //       Uri.parse("$urlAddress/marketing/jadwal/getHotelMekkah"),
  //       headers: {
  //         'pte-token': kodeToken,
  //       });
  //   List<Map<String, dynamic>> data =
  //       List.from(json.decode(response.body) as List);
  //   setState(() {
  //     listHotelMekkah = data;
  //   });
  // }

  // void getHotelMadinah() async {
  //   var response = await http.get(
  //       Uri.parse("$urlAddress/marketing/jadwal/getHotelMadinah"),
  //       headers: {
  //         'pte-token': kodeToken,
  //       });
  //   List<Map<String, dynamic>> data =
  //       List.from(json.decode(response.body) as List);
  //   setState(() {
  //     listHotelMadinah = data;
  //   });
  // }

  // void getHotelPlus() async {
  //   var response = await http
  //       .get(Uri.parse("$urlAddress/marketing/jadwal/getHotelPlus"), headers: {
  //     'pte-token': kodeToken,
  //   });
  //   List<Map<String, dynamic>> data =
  //       List.from(json.decode(response.body) as List);
  //   setState(() {
  //     listHotelPlus = data;
  //   });
  // }

  // void getHotelTransit() async {
  //   var response = await http.get(
  //       Uri.parse("$urlAddress/marketing/jadwal/getHotelTransit"),
  //       headers: {
  //         'pte-token': kodeToken,
  //       });
  //   List<Map<String, dynamic>> data =
  //       List.from(json.decode(response.body) as List);
  //   setState(() {
  //     listHotelTambahan = data;
  //   });
  // }

  // void getTujuan() async {
  //   var response =
  //       await http.get(Uri.parse("$urlAddress/setup/plus-tujuan"), headers: {
  //     'pte-token': kodeToken,
  //   });
  //   List<Map<String, dynamic>> data =
  //       List.from(json.decode(response.body) as List);
  //   setState(() {
  //     listTujuan = data;
  //   });

  //   loadEnd();
  // }

  @override
  void initState() {
    // getJenisPaket();
    getPaket();
    getMataUang();
    getTransit();
    getMaskapai();
    getBandara();
    getHotel();
    // getHotelMekkah();
    // getHotelMadinah();
    // getHotelPlus();
    // getHotelTransit();
    // getTujuan();
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

          getJenisPaket();
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
          items: listHotelMekkah,
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
          items: listHotelMadinah,
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
          label: "Hotel Plus",
          items: listHotelPlus,
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
          dropdownBuilder: (context, selectedItem) =>
              Text(namaHotelJed ?? "Hotel belum Dipilih"),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputHotelTambahan() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Hotel Tambahan",
          items: listHotelTambahan,
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
            tujuan = value['IDXX_RTRS'];
            namaTujuan = value['NAMA_NEGR'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_NEGR']),
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
        setState(() {
          tglBerangkat = value;
        });
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
            pesawatBerangkat = value['IDXX_PSWT'];
            namaPesawatBerangkat = value['NAMA_PSWT'];
            pesawatPulang = value['IDXX_PSWT'];
            namaPesawatPulang = value['NAMA_PSWT'];
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
            if (value == "Maskapai belum Dipilih") {
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
            if (value == "Maskapai belum Dipilih") {
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
            rute = value['KDXX_BAND'];
            ruteAkhirPlng = value['KDXX_BAND'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title:
                    Text("${item['KDXX_BAND']} - ${item['PROVINSI'] ?? '|'}"),
                trailing: Text(item['NAMA_BAND']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                rute ?? "Rute Awal Berangkat belum Dipilih",
                style:
                    TextStyle(color: rute == null ? Colors.red : Colors.black),
              ),
          validator: (value) {
            if (value == "Rute Awal Berangkat belum Dipilih") {
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
            rute2 = value['IDXX_RTRS'];
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
          rute3 = value['KDXX_BAND'];
          ruteAwalPlng = value['KDXX_BAND'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text("${item['KDXX_BAND']} - ${item['PROVINSI'] ?? '|'}"),
          trailing: Text(item['NAMA_BAND']),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
          rute3 ?? "Rute Akhir Berangkat belum Dipilih",
          style: TextStyle(color: rute3 == null ? Colors.red : Colors.black),
        ),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Rute Akhir Berangkat belum Dipilih") {
            return "Rute Awal Berangkat masih kosong !";
          }
        },
      ),
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
          ruteAwalPlng = value['KDXX_BAND'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text("${item['KDXX_BAND']} - ${item['PROVINSI'] ?? '|'}"),
          trailing: Text(item['NAMA_BAND']),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
          ruteAwalPlng ?? "Rute Awal Pulang belum Dipilih",
          style: TextStyle(
              color: ruteAwalPlng == null ? Colors.red : Colors.black),
        ),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Rute Awal Pulang belum Dipilih") {
            return "Rute Awal Pulang masih kosong !";
          }
        },
      ),
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
            ruteTransitPlng = value['IDXX_RTRS'];
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
            ruteAkhirPlng = value['KDXX_BAND'];
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title:
                    Text("${item['KDXX_BAND']} - ${item['PROVINSI'] ?? '|'}"),
                trailing: Text(item['NAMA_BAND']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
                ruteAkhirPlng ?? "Rute Akhir Pulang belum Dipilih",
                style: TextStyle(
                    color: ruteAkhirPlng == null ? Colors.red : Colors.black),
              ),
          validator: (value) {
            if (value == "Rute Akhir Pulang belum Dipilih") {
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
          label: Text("Tarif", style: TextStyle(color: Colors.red))),
      onChanged: (value) {
        tarif = value;
      },
      initialValue: tarif ?? '0',
      validator: (value) {
        if (tarif.isEmpty) {
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
          label: Text("Jumlah Seat", style: TextStyle(color: Colors.red))),
      onChanged: (value) {
        jumlahSeat = value;
      },
      initialValue: tarif ?? '0',
      validator: (value) {
        if (jumlahSeat.isEmpty) {
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
          if (mataUang == null) {
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
      initialValue: keterangan,
      onChanged: (value) {
        keterangan = value;
      },
    );
  }

  Widget resultFotoJadwal() {
    if (fotoJadwalByte != null) {
      return Image.memory(
        fotoJadwalByte,
        height: 150,
      );
    } else {
      if (fotoJadwal != "") {
        if (fotoJadwal != null) {
          return Image(
            image: NetworkImage('$urlAddress/uploads/jadwal/$fotoJadwal'),
            height: 150,
          );
        } else {
          return const Image(
            image: AssetImage('assets/images/NO_IMAGE.jpg'),
            height: 150,
          );
        }
      } else {
        return const Image(
          image: AssetImage('assets/images/NO_IMAGE.jpg'),
          height: 150,
        );
      }
    }
  }

  Widget inputUploadJadwal() {
    return TextFormField(
      initialValue: fotoJadwal != "" ? fotoJadwal : "Pilih",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Upload Foto',
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget formInputLeft() {
    return SizedBox(
      width: fncWidthColumnForm(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          inputPaket(),
          const SizedBox(height: 8),
          inputJenisPaket(),
          const SizedBox(height: 8),
          inputTglBerangkat(),
          const SizedBox(height: 5),
          inputTanggalPulang(),
          const SizedBox(height: 5),
          inputJumlahHari(),
          SizedBox(height: 15),
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
          inputPesawatBerangkat(),
          SizedBox(height: 15),
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
          SizedBox(height: 15),
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
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              resultFotoJadwal(),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                  width: fncWidthInputModal(context),
                  child: inputUploadJadwal()),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    getImageJadwal();
                  },
                  icon: const Icon(Icons.image_outlined),
                  label: fncLabelButtonStyle('Upload Foto', context),
                  style: fncButtonRegulerStyle(context),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget formInputRight() {
    return SizedBox(
      width: fncWidthColumnForm(context),
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
          SizedBox(height: 15),
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
          inputPesawatPulang(),
          SizedBox(height: 15),
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
          SizedBox(height: 15),
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
          inputHotelTambahan(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  getImageJadwal() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoJadwal = fileResult.files.first.name;
        fotoJadwalByte = fileResult.files.first.bytes;
        fotoJadwalBase = encodeFoto;
      });
    }
  }

  fncSaveFoto() {
    HttpJadwal.saveFotoJadwal(
      dateBerangkat.text,
      fotoJadwalBase != '' ? fotoJadwalBase : 'TIDAK',
    ).then(
      (value) {
        if (value.status == true) {
          setState(() {
            fotoJadwal = '';
            fotoJadwalBase = '';
            fotoJadwalByte = null;
          });

          fncSaveData(value.foto);
        } else {
          setState(() {
            fotoJadwal = '';
            fotoJadwalBase = '';
            fotoJadwalByte = null;
          });

          print('GAGAL UPLOAD FOTO');
        }
      },
    );
  }

  fncSaveData(namaFoto) {
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
      rute2 ?? '',
      rute3,
      ruteAwalPlng,
      ruteTransitPlng ?? '',
      ruteAkhirPlng,
      tarif,
      jumlahSeat,
      idMataUang,
      keterangan ?? '',
      dateBerangkat.text,
      datePulang.text,
      fncKeteranganRute(rute, namaTransit, rute3, ruteAwalPlng,
          namaRuteTransitPlng, ruteAkhirPlng),
      namaFoto != 'KOSONG' ? namaFoto : "",
    ).then((value) {
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
    final screenWidth = MediaQuery.of(context).size.width;
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
                      style: fncTextHeaderFormStyle(context),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Container(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          fncSaveFoto();
                        } else {
                          return null;
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: fncLabelButtonStyle('Simpan', context),
                      style: fncButtonRegulerStyle(context),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        menuController.changeActiveitemTo('Jadwal');
                        navigationController.navigateTo('/mrkt/jadwal');
                      },
                      icon: const Icon(Icons.cancel),
                      label: fncLabelButtonStyle('Batal', context),
                      style: fncButtonRegulerStyle(context),
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: screenWidth >= 500
                    ? Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: formInputLeft()),
                              const SizedBox(width: 25),
                              Expanded(child: formInputRight())
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          formInputLeft(),
                          const SizedBox(height: 8),
                          formInputRight(),
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
