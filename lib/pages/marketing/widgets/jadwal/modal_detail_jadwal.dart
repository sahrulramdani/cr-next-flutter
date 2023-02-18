// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/dummy_jadwal_jamaah.dart';
import 'package:flutter_web_course/constants/dummy_pelanggan.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/table_jadwal_pelanggan.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';

class ModalDetailJadwal extends StatefulWidget {
  String idJadwal;
  String keberangkatan;
  ModalDetailJadwal(
      {Key key, @required this.idJadwal, @required this.keberangkatan})
      : super(key: key);

  @override
  State<ModalDetailJadwal> createState() => _ModalDetailJadwalState();
}

class _ModalDetailJadwalState extends State<ModalDetailJadwal> {
  List<Map<String, dynamic>> listJadwalPelanggan = [];

  void getPelangganJadwal() async {
    var id = widget.idJadwal;
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getDetail-jamaah/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwalPelanggan = data;
    });
  }

  @override
  void initState() {
    // getProvinsi();
    getPelangganJadwal();
    super.initState();
  }

  Widget cmdBentukNama() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.near_me_outlined),
      label: const Text(
        'Bentuk Nama',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdExcelManifest() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.file_copy_outlined),
      label: const Text(
        'Excel Manifest',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdExcelAsuransi() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.mark_as_unread_outlined),
      label: const Text(
        'Excel Asuransi',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdImportSipatuh() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.import_export_rounded),
      label: const Text(
        'Import Sipatuh',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdImportSiskopatuh() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.import_export_rounded),
      label: const Text(
        'Import Siskopatuh',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdAlbum() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.album_outlined),
      label: const Text(
        'Album',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdAlbumItem() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.list),
      label: const Text(
        'Album Items',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdAlbumSampul() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.local_post_office_outlined),
      label: const Text(
        'Sampul Album',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdSertifikat() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.credit_score_outlined),
      label: const Text(
        'Sertifikat',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdIDCard() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.list),
      label: const Text(
        'ID Card',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdNameTagAll() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.badge_outlined),
      label: const Text(
        'NameTag All',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdNameTag1() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.badge_outlined),
      label: const Text(
        'NameTag 1',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdNameTag2() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.badge_outlined),
      label: const Text(
        'NameTag 2',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdNameTag3() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.badge_outlined),
      label: const Text(
        'NameTag 3',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdSuku() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.filter_frames_outlined),
      label: const Text(
        'Suku',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdRekompas() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.recommend_outlined),
      label: const Text(
        'Rekompas',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdAbsenManasik() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.library_add_check_outlined),
      label: const Text(
        'Absen Manasik',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdAbsenKesehatan() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.health_and_safety_outlined),
      label: const Text(
        'Absen Kesehatan',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdRiwayatPembayaran() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.payments_outlined),
      label: const Text(
        'Riwayat Pembayaran',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdIdentitas() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.insert_drive_file_outlined),
      label: const Text(
        'Identitas',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdSP() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.sd_card_alert_outlined),
      label: const Text(
        'SP',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdNamaPelanggan() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.list_alt),
      label: const Text(
        'Nama Pelanggan',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdDaftarFoto() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.image_aspect_ratio_outlined),
      label: const Text(
        'Daftar Foto',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdDownloadFoto() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.download_for_offline_outlined),
      label: const Text(
        'Download Foto',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdUploadFoto() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.drive_folder_upload_outlined),
      label: const Text(
        'Upload Foto',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget spacePemisah() {
    return const SizedBox(
      height: 10,
      width: 10,
    );
  }

  Widget inputCari(list) {
    return Container(
      height: 40,
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        style: const TextStyle(fontFamily: 'Gilroy', fontSize: 14),
        decoration: const InputDecoration(hintText: 'Cari Berdasarkan Nama'),
        onChanged: (value) {
          if (value == '') {
            getPelangganJadwal();
          } else {
            setState(() {
              listJadwalPelanggan = list
                  .where(((element) => element['NAMA_LGKP']
                      .toString()
                      .toUpperCase()
                      .contains(value.toUpperCase())))
                  .toList();
            });
          }
        },
      ),
    );
  }

  Widget menuButton() => SizedBox(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                cmdBentukNama(),
                spacePemisah(),
                cmdExcelManifest(),
                spacePemisah(),
                cmdExcelAsuransi(),
                spacePemisah(),
                cmdImportSipatuh(),
                spacePemisah(),
                cmdImportSiskopatuh(),
                spacePemisah(),
                cmdAlbum(),
                spacePemisah(),
                cmdAlbumItem(),
                spacePemisah(),
                cmdAlbumSampul(),
              ],
            ),
            spacePemisah(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                cmdNameTagAll(),
                spacePemisah(),
                cmdNameTag1(),
                spacePemisah(),
                cmdNameTag2(),
                spacePemisah(),
                cmdNameTag3(),
                spacePemisah(),
                cmdSuku(),
                spacePemisah(),
                cmdRekompas(),
                spacePemisah(),
                cmdAbsenManasik(),
                spacePemisah(),
                cmdAbsenKesehatan(),
                spacePemisah(),
                cmdIDCard(),
              ],
            ),
            spacePemisah(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                cmdNamaPelanggan(),
                spacePemisah(),
                cmdDaftarFoto(),
                spacePemisah(),
                cmdDownloadFoto(),
                spacePemisah(),
                cmdUploadFoto(),
                spacePemisah(),
                cmdRiwayatPembayaran(),
                spacePemisah(),
                cmdIdentitas(),
                spacePemisah(),
                cmdSP(),
                spacePemisah(),
                cmdSertifikat(),
              ],
            ),
            spacePemisah(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth > 400 ? screenWidth * 0.7 : screenWidth * 0.9,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.corporate_fare_rounded,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      FittedBox(
                        child: Text(
                            'Jadwal Pelanggan Keberangkatan ${widget.keberangkatan}',
                            style: TextStyle(
                                color: myGrey, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: menuButton()),
                          inputCari(listJadwalPelanggan),
                          const SizedBox(height: 10),
                          TableJadwalPelanggan(
                              dataJadwalPel: listJadwalPelanggan)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => const ModalSaveSuccess());
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
