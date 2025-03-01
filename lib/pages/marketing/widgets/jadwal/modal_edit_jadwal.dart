// ignore_for_file: deprecated_member_use, must_be_immutable, missing_return, avoid_print, unused_import, unused_local_variable, prefer_const_constructors, unnecessary_string_interpolations, prefer_if_null_operators, await_only_futures, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/dummy_jadwal.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/models/http_jadwal.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:flutter_web_course/constants/dummy_data_bandara.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class ModalEditJadwal extends StatefulWidget {
  String idJadwal;

  ModalEditJadwal({
    Key key,
    @required this.idJadwal,
  }) : super(key: key);

  @override
  State<ModalEditJadwal> createState() => _ModalEditJadwalState();
}

class _ModalEditJadwalState extends State<ModalEditJadwal> {
  NumberFormat myformat = NumberFormat.decimalPattern('en_us');
  String idJadwal;
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
  String fotoLamaJadwal = "";

  bool enableTujuan = false;

  TextEditingController dateBerangkat = TextEditingController();
  TextEditingController datePulang = TextEditingController();

  List<Map<String, dynamic>> dataDetail = [];
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

  void getDetail() async {
    var id = widget.idJadwal;
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getDetail/$id"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      dataDetail = data;
      namaPaket = data[0]['namaPaket'];
      idpaket = data[0]['NAMA_PKET'];
      namaJenis = data[0]['jenisPaket'];
      idjenis = data[0]['JENS_PKET'];
      tujuan = data[0]['TJAN_PKET'];
      jumlahHari = data[0]['JMLX_HARI'].toString();
      pesawatBerangkat = data[0]['PSWT_BGKT'];
      namaPesawatBerangkat = data[0]['PESAWAT_BERANGKAT'];
      pesawatPulang = data[0]['PSWT_PLNG'];
      namaPesawatPulang = data[0]['PESAWAT_PULANG'];
      rute = data[0]['RUTE_AWAL_BRKT'];
      rute2 = data[0]['RUTE_TRNS_BRKT'];
      rute3 = data[0]['RUTE_AKHR_BRKT'];
      ruteAwalPlng = data[0]['RUTE_AWAL_PLNG'];
      ruteTransitPlng = data[0]['RUTE_TRNS_PLNG'];
      namaRuteTransitPlng = data[0]['NAMA_NEGRATRPLNG'];
      ruteAkhirPlng = data[0]['RUTE_AKHR_PLNG'];
      tarif = myformat.format(data[0]['TARIF_PKET']);
      jumlahSeat = data[0]["JMLX_SEAT"].toString();
      keterangan = data[0]['KETERANGAN'];
      dateBerangkat.text = data[0]['TGLX_BGKT'].toString();
      datePulang.text = data[0]['TGLX_PLNG'].toString();
      mataUang = data[0]['MataUang'];
      idMataUang = data[0]['MATA_UANG'];
      namaTransit = data[0]['NAMA_NEGR'];
      idHotelMek = data[0]['HOTL_MEKX'];
      namaHotelMek = data[0]['HOTEL_MEKKAH'];
      idHotelMad = data[0]['HOTL_MADX'];
      namaHotelMad = data[0]['HOTEL_MADINAH'];
      idHotelJed = data[0]['HOTL_JEDX'];
      namaHotelJed = data[0]['HOTEL_PLUS'];
      idHotelTra = data[0]['HOTL_TRAX'];
      namaHotelTra = data[0]['HOTEL_TAMBAH'];
      tujuan = data[0]['TJAN_PKET'];
      namaTujuan = data[0]['NAMA_TUJUAN'];
      if (data[0]['JENS_PKET'] == '02' || data[0]['JENS_PKET'] == '04') {
        enableTujuan = true;
      }
      fotoJadwal = data[0]['FOTO_PKET'];
      fotoLamaJadwal = data[0]['FOTO_PKET'];
    });
  }

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
  }

  @override
  void initState() {
    super.initState();
    getDetail();
    getJenisPaket();
    getPaket();
    getMataUang();
    getTransit();
    getMaskapai();
    getBandara();
    getHotel();
  }

  Widget inputIDPaket() {
    return TextFormField(
      initialValue: widget.idJadwal,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'ID Jadwal',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      readOnly: true,
    );
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
            style: TextStyle(
                color: namaPaket == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
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
            style: TextStyle(
                color: namaJenis == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
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
          title: Text("${item['NAMA_HTLX']} - Bintang ${item['CODD_DESC']}"),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
          namaHotelMek ?? "Hotel belum Dipilih",
          style: TextStyle(
              color: namaHotelMek == null ? Colors.red : Colors.black),
        ),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
      ),
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
          title: Text("${item['NAMA_HTLX']} - Bintang ${item['CODD_DESC']}"),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
          namaHotelMad ?? "Hotel belum Dipilih",
          style: TextStyle(
              color: namaHotelMad == null ? Colors.red : Colors.black),
        ),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
      ),
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
          title: Text("${item['NAMA_HTLX']} - Bintang ${item['CODD_DESC']}"),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaHotelJed ?? "Hotel belum Dipilih"),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
      ),
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
        label: "Hotel Tambahan",
        items: listHotelTambahan,
        onChanged: (value) {
          // print(value['iata_code']);
          idHotelTra = value['IDXX_HTLX'];
          namaHotelTra = value['NAMA_HTLX'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text("${item['NAMA_HTLX']} - Bintang ${item['CODD_DESC']}"),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
          namaHotelTra ?? "Hotel belum Dipilih",
        ),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
      ),
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
          style: TextStyle(color: tujuan == null ? Colors.red : Colors.black),
        ),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
      ),
    );
  }

  Widget inputTglBerangkat() {
    return TextField(
      controller: dateBerangkat,
      decoration: const InputDecoration(
          label: Text("Tanggal Berangkat", style: TextStyle(color: Colors.red)),
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
          hintText: "DD-MM-YYYY"),
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
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
          hintText: "DD-MM-YYYY"),
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
      readOnly: true,
      initialValue: jumlahHari ?? "",
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text("Jumlah Hari", style: TextStyle(color: Colors.red)),
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
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
              color: namaPesawatBerangkat == null ? Colors.red : Colors.black),
        ),
        validator: (value) {
          if (value == null) {
            return "Maskapai masih kosong !";
          }
        },
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
      ),
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
              color: namaPesawatPulang == null ? Colors.red : Colors.black),
        ),
        validator: (value) {
          if (value == null) {
            return "Maskapai masih kosong !";
          }
        },
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
      ),
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
            if (value == null) {
              return "Rute Awal Berangkat masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
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
          validator: (value) {
            if (value == null) {
              return "Rute Transit Berangkat kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
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
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title:
                    Text("${item['KDXX_BAND']} - ${item['PROVINSI'] ?? '|'}"),
                trailing: Text(item['NAMA_BAND']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              rute3 ?? "Rute Akhir Berangkat belum Dipilih",
              style:
                  TextStyle(color: rute3 == null ? Colors.red : Colors.black)),
          validator: (value) {
            if (value == null) {
              return "Rute Akhir Berangkat masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
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
                title:
                    Text("${item['KDXX_BAND']} - ${item['PROVINSI'] ?? '|'}"),
                trailing: Text(item['NAMA_BAND']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              ruteAwalPlng ?? "Rute Awal Pulang belum Dipilih",
              style: TextStyle(
                  color: ruteAwalPlng == null ? Colors.red : Colors.black)),
          validator: (value) {
            if (value == null) {
              return "Rute Awal Pulang masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, fillColor: Colors.white, filled: true)),
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
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
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
                  color: ruteAkhirPlng == null ? Colors.red : Colors.black)),
          validator: (value) {
            if (value == null) {
              return "Rute Akhir Pulang masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
    );
  }

  Widget inputTarif() {
    return TextFormField(
      initialValue: tarif ?? "",
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text("Tarif", style: TextStyle(color: Colors.red)),
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
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
      initialValue: jumlahSeat ?? "",
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text("Jumlah Seat", style: TextStyle(color: Colors.red)),
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
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
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            mataUang ?? "Pilih Mata Uang",
            style:
                TextStyle(color: mataUang == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
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
      initialValue: keterangan ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Keterangan',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
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
            image: NetworkImage('$urlAddress/uploads/paket/$fotoJadwal'),
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

  Widget inputUploadFoto() {
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
    HttpJadwal.updateFotoJadwal(
      dateBerangkat.text,
      fotoJadwalBase != '' ? fotoJadwalBase : 'TIDAK',
      fotoLamaJadwal,
    ).then(
      (value) {
        if (value.status == true) {
          fncSaveData(value.foto);
        } else {
          print('GAGAL UPLOAD FOTO');
        }
      },
    );
  }

  fncSaveData(namaFoto) {
    // print("ID JADWAL : ${widget.idJadwal}");
    // print("ID PAKET : $idpaket");
    // print("ID JENIS : $idjenis");
    // print("TUJUAN : $tujuan");
    // print("HOTEL MEK : $idHotelMek");
    // print("HOTEL MAD : $idHotelMad");
    // print("HOTEL JED : $idHotelJed");
    // print("HOTEL TRA : $idHotelTra");
    // // print("KOTA TRANSIT : $idTransit");
    // print("JUMLAH HARI : $jumlahHari");
    // print("PESAWAT BRGKT : $pesawatBerangkat");
    // print("PESAWAT PLANG : $pesawatPulang");
    // print("RUTE AWAL BRKT : $rute");
    // print("RUTE TRANSIT BRKT : $rute2");
    // print("RUTE AKHIR BRKT : $rute3");
    // print("RUTE AWAL PLNG : $ruteAwalPlng");
    // print("RUTE TRANSIT PLNG : $ruteTransitPlng");
    // print("RUTE AKHIR PLNG : $ruteAkhirPlng");
    // print("TARIF : $tarif");
    // print("JUMLAH SEAT : $jumlahSeat");
    // print("MATA UANG : $idMataUang");
    // print("KETERANGAN : $keterangan");
    // print("TANGGAL BERANGKT : ${dateBerangkat.text}");
    // print("TANGGAL PULNG : ${datePulang.text}");
    HttpJadwal.updateJadwal(
      widget.idJadwal,
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
      rute2,
      rute3,
      ruteAwalPlng,
      ruteTransitPlng,
      ruteAkhirPlng,
      tarif,
      jumlahSeat,
      idMataUang,
      keterangan,
      dateBerangkat.text,
      datePulang.text,
      fncKeteranganRute(rute, namaTransit, rute3, ruteAwalPlng,
          namaRuteTransitPlng, ruteAkhirPlng),
      namaFoto,
    ).then((value) {
      if (value.status == true) {
        imageCache.clear();

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
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: fncWidthModalForm(context),
            height: 700,
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
                      Text('Ubah Jadwal',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: fncWidthColumnModal(context),
                            child: Column(
                              children: [
                                inputIDPaket(),
                                const SizedBox(height: 8),
                                inputPaket(),
                                const SizedBox(height: 8),
                                inputJenisPaket(),
                                const SizedBox(height: 8),
                                inputTglBerangkat(),
                                const SizedBox(height: 8),
                                inputTanggalPulang(),
                                const SizedBox(height: 8),
                                inputJumlahHari(),
                                const SizedBox(height: 15),
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
                                const SizedBox(height: 15),
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
                                const SizedBox(height: 15),
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
                                        child: inputUploadFoto()),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          getImageJadwal();
                                        },
                                        icon: const Icon(Icons.image_outlined),
                                        label: fncLabelButtonStyle(
                                            'Upload Foto', context),
                                        style: fncButtonRegulerStyle(context),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            width: fncWidthColumnModal(context),
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
                                const SizedBox(height: 75),
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
                                inputRuteAwalPlng(),
                                const SizedBox(height: 8),
                                inputRuteTransitPlng(),
                                const SizedBox(height: 8),
                                inputRuteAkhirPlng(),
                                const SizedBox(height: 15),
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
                                const SizedBox(height: 15),
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
                                const SizedBox(height: 212),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          fncSaveFoto();
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
