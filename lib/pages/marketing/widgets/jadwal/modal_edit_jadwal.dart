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
  String tarif;
  String pesawat;
  String rute;
  String jumlahSeat;
  String keterangan;
  String jumlahHari;
  String rute2;
  String namaTransit;
  String rute3;
  String mataUang;
  String idMataUang;

  TextEditingController dateBerangkat = TextEditingController();
  TextEditingController datePulang = TextEditingController();

  List<Map<String, dynamic>> dataDetail = [];
  List<Map<String, dynamic>> listJenisPaket = [];
  List<Map<String, dynamic>> listPaket = [];
  List<Map<String, dynamic>> listMataUang = [];
  List<Map<String, dynamic>> listTransit = [];
  List<Map<String, dynamic>> listBandara = dummyDataBandara;

  void getDetail() async {
    var id = widget.idJadwal;
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/jadwal/getDetail/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      dataDetail = data;
      namaPaket = data[0]['namaPaket'].toString();
      idpaket = data[0]['NAMA_PKET'].toString();
      namaJenis = data[0]['jenisPaket'].toString();
      idjenis = data[0]['JENS_PKET'].toString();
      tujuan = data[0]['TJAN_PKET'].toString();
      jumlahHari = data[0]['JMLX_HARI'].toString();
      pesawat = data[0]['JENS_PSWT'].toString();
      rute = data[0]['RUTE_AWAL'].toString();
      rute2 = data[0]['RUTE_TRNS'].toString();
      rute3 = data[0]['RUTE_AKHR'].toString();
      tarif = myformat.format(data[0]['TARIF_PKET']);
      jumlahSeat = data[0]["JMLX_SEAT"].toString();
      keterangan = data[0]['KETERANGAN'].toString();
      dateBerangkat.text = data[0]['TGLX_BGKT'].toString();
      datePulang.text = data[0]['TGLX_PLNG'].toString();
      mataUang = data[0]['MataUang'];
      idMataUang = data[0]['MATA_UANG'];
      namaTransit = data[0]['NAMA_NEGR'];
    });

    // print(data);
    // print(rute3);
  }

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
    super.initState();
    getDetail();
    getJenisPaket();
    getPaket();
    getMataUang();
    getTransit();
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
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaPaket ?? "Pilih Paket"),
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
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaJenis ?? "Pilih Jenis Paket"),
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

  Widget inputTujuan() {
    return TextFormField(
      initialValue: tujuan ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Tujuan Paket',
          hintText: 'tujuan',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
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
      decoration: const InputDecoration(
          labelText: 'Tanggal Berangkat',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
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
          labelText: 'Tanggal Pulang',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
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
      initialValue: jumlahHari ?? "",
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Jumlah Hari',
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

  Widget inputPesawat() {
    return TextFormField(
      initialValue: pesawat ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Pesawat',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
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
          labelText: 'Tarif',
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
          labelText: 'Jumlah Seat',
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
        dropdownBuilder: (context, selectedItem) =>
            Text(mataUang ?? "Pilih Mata Uang"),
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
    HttpJadwal.updateJadwal(
      widget.idJadwal,
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
      datePulang.text,
    ).then((value) {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.81,
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
                            width: 530,
                            child: Column(
                              children: [
                                inputIDPaket(),
                                const SizedBox(height: 8),
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
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            width: 530,
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
                                const SizedBox(height: 65),
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
                          fncSaveData();
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
