// ignore_for_file: missing_return, deprecated_member_use
import 'package:flutter_web_course/constants/dummy_jadwal.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';

class JadwalForm extends StatefulWidget {
  const JadwalForm({Key key}) : super(key: key);

  @override
  State<JadwalForm> createState() => _JadwalFormState();
}

class _JadwalFormState extends State<JadwalForm> {
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
        items: const ["Reguler B3", "Reguler B5", "Plus Negara"],
        onChanged: (value) {
          jenis = value;
        },
        selectedItem: "Pilih Jenis Paket",
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
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
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
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Rute Pesawat'),
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
        items: const ["IDR", "USD"],
        onChanged: (value) {
          mataUang = value;
        },
        selectedItem: "Pilih Mata Uang",
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
    var obj = [
      {
        "id_jadwal": fncGetIDJadwal(dateBerangkat.text),
        "tipe": paket,
        "jenis": "a",
        "tujuan": tujuan,
        "tanggal_berangkat": dateBerangkat.text,
        "jumlah_hari": jumlahHari,
        "biaya": tarif.replaceAll(',', ''),
        "mata_uang": mataUang,
        "jumlah_seat": jumlahSeat,
        "pesawat": pesawat,
        "rute_penerbangan": rute,
        "keterangan": keterangan,
        "status_berangkat": "a",
        "status_sistem": "reguler",
        "date_create": "2022-11-23 08:06:42",
        "user_create": "U20190814001",
        "date_update": null,
        "user_update": null,
        "tanggal_pulang": "2023-01-25",
        "status_tanggal_berangkat": "n",
        "status_konfirmasi": "0/40",
        "jenisna": jenis,
        "tipena": "$paket $keterangan $jenis",
        "tg_berangkat": fncGetTanggal(dateBerangkat.text),
        "tg_pulang": fncGetTanggal(datePulang.text),
        "biaya_rp": tarif,
        "biaya_rpmu": tarif,
        "tgi_berangkat": dateBerangkat.text,
        "tgi_pulang": datePulang.text,
        "sisa_seat": jumlahSeat,
        "status": "0",
        "via_kantor": "1",
        "via_marketing": "39"
      }
    ];

    dummyJadwalTable.addAll(obj);

    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Jadwal');
    navigationController.navigateTo('/mrkt/jadwal');
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
