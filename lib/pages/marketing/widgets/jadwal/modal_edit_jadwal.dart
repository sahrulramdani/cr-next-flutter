// ignore_for_file: deprecated_member_use, must_be_immutable, missing_return

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/dummy_jadwal.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';

class ModalEditJadwal extends StatefulWidget {
  String idJadwal;
  ModalEditJadwal({Key key, @required this.idJadwal}) : super(key: key);

  @override
  State<ModalEditJadwal> createState() => _ModalEditJadwalState();
}

class _ModalEditJadwalState extends State<ModalEditJadwal> {
  List<Map<String, dynamic>> dataJadwal;
  String paket;
  String jenis;
  String tujuan;
  String jumlahHari;
  String pesawat;
  String rute;
  String tarif;
  String jumlahSeat;
  String mataUang;
  String keterangan;

  String tglBerangkat;
  String tglPulang;
  TextEditingController dateBerangkat = TextEditingController();
  TextEditingController datePulang = TextEditingController();

  void getDataDetail() async {
    List<Map<String, dynamic>> listJadwal = dummyJadwalTable
        .where((element) =>
            element['id_jadwal'].toString().contains(widget.idJadwal))
        .toList();
    setState(() {
      dataJadwal = listJadwal;
      dateBerangkat.text = dataJadwal[0]['tgi_berangkat'].toString();
      datePulang.text = dataJadwal[0]['tgi_pulang'].toString();
    });
  }

  @override
  void initState() {
    getDataDetail();
    super.initState();
  }

  Widget inputIDPaket() {
    return TextFormField(
      initialValue: dataJadwal[0]['id_jadwal'].toString(),
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'ID Jadwal'),
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
        items: const ["Haji", "Urmroh", "Domestik", "Internasional"],
        onChanged: (value) {
          paket = value;
        },
        selectedItem: "Pilih Paket",
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
        items: const ["Reguler B3", "Reguler B5", "Plus Negara"],
        onChanged: (value) {
          jenis = value;
        },
        selectedItem: "Pilih Jenis Paket",
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
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
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
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          datePulang.text = formattedDate;
        }
      },
    );
  }

  Widget inputJumlahHari() {
    return TextFormField(
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
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Rute Pesawat',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        rute = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Rute masih kosong !";
        }
      },
    );
  }

  Widget inputTarif() {
    return TextFormField(
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
        items: const ["IDR", "USD"],
        onChanged: (value) {
          mataUang = value;
        },
        selectedItem: "Pilih Mata Uang",
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
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Jadwal');
    navigationController.navigateTo('/mrkt/jadwal');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
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
                                inputPesawat(),
                                const SizedBox(height: 8),
                                inputRute(),
                                const SizedBox(height: 8),
                                inputTarif(),
                                const SizedBox(height: 8),
                                inputJumlahSeat(),
                                const SizedBox(height: 8),
                                inputMataUang(),
                                const SizedBox(height: 8),
                                inputKeterangan()
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
