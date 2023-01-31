// ignore_for_file: deprecated_member_use, must_be_immutable

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
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Paket",
        mode: Mode.MENU,
        items: const ["Haji", "Umroh", "Domestik", "Internasional"],
        onChanged: (value) {
          paket = value;
        },
        selectedItem: paket ?? dataJadwal[0]['tipe'].toString(),
      ),
    );
  }

  Widget inputJenisPaket() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Jenis Paket",
        mode: Mode.MENU,
        items: const ["Reguler B3", "Reguler B5", "Plus Negara"],
        onChanged: (value) {
          jenis = value;
        },
        selectedItem: jenis ?? dataJadwal[0]['jenisna'].toString(),
      ),
    );
  }

  Widget inputTujuan() {
    return TextFormField(
      initialValue: tujuan ?? dataJadwal[0]['tujuan'].toString(),
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Tujuan Paket',
          hintText: 'tujuan'),
      onChanged: (value) {
        tujuan = value;
      },
    );
  }

  Widget inputTglBerangkat() {
    return TextField(
      controller: dateBerangkat,
      decoration: const InputDecoration(
          labelText: 'Tanggal Berangkat', border: OutlineInputBorder()),
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
          setState(() {
            dateBerangkat.text = formattedDate;
          });
        }
      },
    );
  }

  Widget inputTanggalPulang() {
    return TextField(
      controller: dateBerangkat,
      decoration: const InputDecoration(
          labelText: 'Tanggal Pulang', border: OutlineInputBorder()),
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
          setState(() {
            dateBerangkat.text = formattedDate;
          });
        }
      },
    );
  }

  Widget inputJumlahHari() {
    return TextFormField(
      initialValue: jumlahHari ?? dataJadwal[0]['jumlah_hari'].toString(),
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Jumlah Hari'),
      onChanged: (value) {
        jumlahHari = value;
      },
    );
  }

  Widget inputPesawat() {
    return TextFormField(
      initialValue: pesawat ?? dataJadwal[0]['pesawat'].toString(),
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Pesawat'),
      onChanged: (value) {
        pesawat = value;
      },
    );
  }

  Widget inputRute() {
    return TextFormField(
      initialValue: rute ?? dataJadwal[0]['rute_penerbangan'].toString(),
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Rute Pesawat'),
      onChanged: (value) {
        rute = value;
      },
    );
  }

  Widget inputTarif() {
    return TextFormField(
      initialValue: tarif ?? dataJadwal[0]['biaya_rp'].toString(),
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Tarif'),
    );
  }

  Widget inputJumlahSeat() {
    return TextFormField(
      initialValue: jumlahSeat ?? dataJadwal[0]['jumlah_seat'].toString(),
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Jumlah Seat'),
    );
  }

  Widget inputMataUang() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Mata Uang",
        mode: Mode.MENU,
        items: const ["IDR", "USD"],
        onChanged: (value) {
          mataUang = value;
        },
        selectedItem: mataUang ?? dataJadwal[0]['mata_uang'].toString(),
      ),
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      initialValue: keterangan ?? dataJadwal[0]['keterangan'].toString(),
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Keterangan'),
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
