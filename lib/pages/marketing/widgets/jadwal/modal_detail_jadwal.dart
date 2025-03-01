// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/excel_manifest.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/import_sipatuh.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/import_siskopatuh.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_absen_manasik.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_album.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_album_item.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_daftar_foto.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_nametag_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_nametag_koper.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_nametag_paspor.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_pelanggan.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_sampul_album.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_sertifikat.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_sp.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_absen_kesehatan.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_identitas.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_rekompas.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_riwayat_bayar.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/print_suku.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ModalDetailJadwal extends StatefulWidget {
  String idJadwal;
  String keberangkatan;
  String jenisPaket;
  String harga;
  String tglBgkt;
  String tglPlng;
  ModalDetailJadwal({
    Key key,
    @required this.idJadwal,
    @required this.keberangkatan,
    @required this.jenisPaket,
    @required this.harga,
    @required this.tglBgkt,
    @required this.tglPlng,
  }) : super(key: key);

  @override
  State<ModalDetailJadwal> createState() => _ModalDetailJadwalState();
}

class _ModalDetailJadwalState extends State<ModalDetailJadwal> {
  bool cekAll = false;

  List<Map<String, dynamic>> listJadwalPelanggan = [];

  void getPelangganJadwal() async {
    loadStart();

    var id = widget.idJadwal;
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/jadwal/getDetail-jamaah/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    for (var i = 0; i < data.length; i++) {
      var tagihan = {
        "CEK": false,
      };
      data[i].addAll(tagihan);
    }

    setState(() {
      listJadwalPelanggan = data;
    });

    loadEnd();
  }

  @override
  void initState() {
    getPelangganJadwal();
    super.initState();
  }

  Widget cmdBentukNama() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.near_me_outlined),
      style: fncButtonAuthStyle(authInqu, context),
      label: fncLabelButtonStyle('Bentuk Nama', context),
    );
  }

  Widget cmdExcelManifest() {
    return ExcelManifest(
        listPelangganJadwal: listJadwalPelanggan, tglBgkt: widget.tglBgkt);
  }

  Widget cmdExcelAsuransi() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.mark_as_unread_outlined),
      style: fncButtonAuthStyle(authExpt, context),
      label: fncLabelButtonStyle('Excel Asuransi', context),
    );
  }

  Widget cmdImportSipatuh() {
    return ImportSipatuh(
        listPelangganJadwal: listJadwalPelanggan, tglBgkt: widget.tglBgkt);
  }

  Widget cmdImportSiskopatuh() {
    return ImportSiskopatuh(
        listPelangganJadwal: listJadwalPelanggan, tglBgkt: widget.tglBgkt);
  }

  Widget cmdAlbum() {
    return PrintAlbum(
      listPelangganJadwal: listJadwalPelanggan,
      tglBgkt: widget.tglBgkt,
      tglPlng: widget.tglPlng,
    );
  }

  Widget cmdAlbumItem() {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalAlbumItem(
                  listPelangganJadwal: listJadwalPelanggan,
                  tglBgkt: widget.tglBgkt,
                  tglPlng: widget.tglPlng,
                ));
      },
      icon: const Icon(Icons.list),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('Album Items', context),
    );
  }

  Widget cmdAlbumSampul() {
    return PrintSampulAlbum(
        tglBgkt: widget.tglBgkt, jenisPaket: widget.jenisPaket);
  }

  Widget cmdSertifikat() {
    return PrintSertifikat(
        listPelangganJadwal: listJadwalPelanggan,
        jenisPaket: widget.jenisPaket,
        tglBgkt: widget.tglBgkt,
        tglPlng: widget.tglPlng);
  }

  Widget cmdIDCard() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.list),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('ID Card', context),
    );
  }

  Widget cmdNameTagAll() {
    return PrintNameTagAll(
        listPelangganJadwal: listJadwalPelanggan, tglBgkt: widget.tglBgkt);
  }

  Widget cmdNameTag1() {
    return PrintNametagKoper(
        listPelangganJadwal: listJadwalPelanggan, tglBgkt: widget.tglBgkt);
  }

  Widget cmdNameTag3() {
    return PrintNametagPaspor(
        listPelangganJadwal: listJadwalPelanggan, tglBgkt: widget.tglBgkt);
  }

  Widget cmdSuku() {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalSuratKuasa(
                  listPelangganJadwal: listJadwalPelanggan,
                  tglBgkt: widget.tglBgkt,
                ));
      },
      icon: const Icon(Icons.assignment_sharp),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('Surat Kuasa', context),
    );
  }

  Widget cmdRekompas() {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalRekompas(
                  listPelangganJadwal: listJadwalPelanggan,
                  tglBgkt: widget.tglBgkt,
                ));
      },
      icon: const Icon(Icons.recommend_outlined),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('Rekomendasi Paspor', context),
    );
  }

  Widget cmdAbsenManasik() {
    return PrintAbsenManasik(
      listPelangganJadwal: listJadwalPelanggan,
      keberangkatan: widget.keberangkatan,
      jenisPaket: widget.jenisPaket,
      tglBgkt: widget.tglBgkt,
    );
  }

  Widget cmdAbsenKesehatan() {
    return PrintAbsenKesehatan(
      listPelangganJadwal: listJadwalPelanggan,
      keberangkatan: widget.keberangkatan,
      jenisPaket: widget.jenisPaket,
      tglBgkt: widget.tglBgkt,
    );
  }

  Widget cmdRiwayatPembayaran() {
    return PrintRiwayatBayar(
      listPelangganJadwal: listJadwalPelanggan,
      keberangkatan: widget.keberangkatan,
      jenisPaket: widget.jenisPaket,
      harga: widget.harga,
      tglBgkt: widget.tglBgkt,
    );
  }

  Widget cmdIdentitas() {
    return PrintIdentitas(
      listPelangganJadwal: listJadwalPelanggan,
      keberangkatan: widget.keberangkatan,
      jenisPaket: widget.jenisPaket,
      tglBgkt: widget.tglBgkt,
    );
  }

  Widget cmdSP() {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalSuratPernyataan(
                  listPelangganJadwal: listJadwalPelanggan,
                  tglBgkt: widget.tglBgkt,
                ));
      },
      icon: const Icon(Icons.assignment_late_outlined),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('Surat Pernyataan', context),
    );
  }

  Widget cmdNamaPelanggan() {
    return PrintNamaPelanggan(
      listPelangganJadwal: listJadwalPelanggan,
      keberangkatan: widget.keberangkatan,
      jenisPaket: widget.jenisPaket,
      tglBgkt: widget.tglBgkt,
    );
  }

  Widget cmdDaftarFoto() {
    return PrintDaftarFoto(
        listPelangganJadwal: listJadwalPelanggan, tglBgkt: widget.tglBgkt);
  }

  Widget cmdDownloadFoto() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.download_for_offline_outlined),
      style: fncButtonAuthStyle(authInqu, context),
      label: fncLabelButtonStyle('Download Foto', context),
    );
  }

  Widget cmdUploadFoto() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.drive_folder_upload_outlined),
      style: fncButtonAuthStyle(authEdit, context),
      label: fncLabelButtonStyle('Upload Foto', context),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // cmdBentukNama(),
                  // spacePemisah(),
                  cmdExcelManifest(),
                  spacePemisah(),
                  // cmdExcelAsuransi(),
                  // spacePemisah(),
                  cmdImportSipatuh(),
                  spacePemisah(),
                  cmdImportSiskopatuh(),
                  spacePemisah(),
                  cmdAlbum(),
                  spacePemisah(),
                  cmdAlbumItem(),
                  spacePemisah(),
                  cmdAlbumSampul(),
                  spacePemisah(),
                  cmdAbsenKesehatan(),
                ],
              ),
              spacePemisah(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  cmdNameTagAll(),
                  spacePemisah(),
                  cmdNameTag1(),
                  // spacePemisah(),
                  // cmdNameTag2(),
                  spacePemisah(),
                  cmdNameTag3(),
                  spacePemisah(),
                  cmdSuku(),
                  spacePemisah(),
                  cmdRekompas(),
                  spacePemisah(),
                  cmdAbsenManasik(),
                  //  spacePemisah(),
                  //   cmdAbsenKesehatan(),
                  // spacePemisah(),
                  // cmdIDCard(),
                ],
              ),
              spacePemisah(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  cmdNamaPelanggan(),
                  spacePemisah(),
                  cmdDaftarFoto(),
                  // spacePemisah(),
                  // cmdDownloadFoto(),
                  // spacePemisah(),
                  // cmdUploadFoto(),
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
        ),
      );

  fncCekAll() {
    loadStart();
    for (var i = 0; i < listJadwalPelanggan.length; i++) {
      setState(() {
        listJadwalPelanggan[i]['CEK'] = cekAll;
      });
    }
    loadEnd();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const styleHead =
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    final styleRowKhusus = TextStyle(
        fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 10);
    int x = 1;
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: fncWidthModalKeberangkatan(context),
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                          SizedBox(
                            width: screenWidth * 0.9,
                            height: 0.5 * screenHeight,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                    columnSpacing: 17,
                                    dataRowHeight: 30,
                                    headingRowHeight: 45,
                                    headingRowColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      return Colors.blue;
                                    }),
                                    columns: [
                                      const DataColumn(
                                          label: Text('No.', style: styleHead)),
                                      DataColumn(
                                          label: Checkbox(
                                        activeColor: Colors.green,
                                        value: cekAll,
                                        onChanged: (bool value) {
                                          setState(() {
                                            cekAll = !cekAll;
                                          });
                                          fncCekAll();
                                        },
                                      )),
                                      const DataColumn(
                                          label:
                                              Text('Nama', style: styleHead)),
                                      const DataColumn(
                                          label: Text('Jenis Kelamin',
                                              style: styleHead)),
                                      const DataColumn(
                                          label:
                                              Text('Umur', style: styleHead)),
                                      const DataColumn(
                                          label:
                                              Text('Paspor', style: styleHead)),
                                      const DataColumn(
                                          label:
                                              Text('Vaksin', style: styleHead)),
                                      const DataColumn(
                                          label: Text('Handling',
                                              style: styleHead)),
                                      const DataColumn(
                                          label: Text('Telepon',
                                              style: styleHead)),
                                      const DataColumn(
                                          label:
                                              Text('Total', style: styleHead)),
                                      const DataColumn(
                                          label: Text('Uang Masuk',
                                              style: styleHead)),
                                      const DataColumn(
                                          label: Text('Sisa Bayar',
                                              style: styleHead)),
                                      const DataColumn(
                                          label:
                                              Text('Lunas', style: styleHead)),
                                      // const DataColumn(
                                      //     label:
                                      //         Text('Cetak', style: styleHead)),
                                    ],
                                    rows: listJadwalPelanggan.map((e) {
                                      return DataRow(cells: [
                                        DataCell(Text((x++).toString())),
                                        DataCell(Checkbox(
                                          activeColor: Colors.green,
                                          value: e['CEK'],
                                          onChanged: (bool value) {
                                            setState(() {
                                              e['CEK'] = !e['CEK'];
                                            });
                                          },
                                        )),
                                        DataCell(Text(e['NAMA_LGKP'].toString(),
                                            style: styleRowKhusus)),
                                        DataCell(Text(
                                            e['JENS_KLMN'] == 'P'
                                                ? "Pria"
                                                : "Wanita",
                                            style: styleRowKhusus)),
                                        DataCell(Text(e['UMUR'].toString(),
                                            style: styleRowKhusus)),
                                        DataCell(Text(e['PEMB_PSPR'],
                                            style: styleRowKhusus)),
                                        DataCell(Text(e['PRSS_VKSN'],
                                            style: styleRowKhusus)),
                                        DataCell(Text(e['HANDLING'],
                                            style: styleRowKhusus)),
                                        DataCell(Text(e['NOXX_TELP'].toString(),
                                            style: styleRowKhusus)),
                                        DataCell(Text(
                                            myFormat.format(e['EST_TOTAL']),
                                            style: styleRowKhusus)),
                                        DataCell(Text(
                                            myFormat.format(e['MASUK']),
                                            style: styleRowKhusus)),
                                        DataCell(Text(
                                            myFormat.format(e['SISA']),
                                            style: styleRowKhusus)),
                                        DataCell(Text(
                                            e['STATUS_BAYAR'].toString(),
                                            style: styleRowKhusus)),
                                        // DataCell(Text('Pending',
                                        //     style: styleRowKhusus)),
                                      ]);
                                    }).toList()),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // ElevatedButton.icon(
                      //   onPressed: () {
                      //     Navigator.pop(context);
                      //     showDialog(
                      //         context: context,
                      //         builder: (context) => const ModalSaveSuccess());
                      //   },
                      //   icon: const Icon(Icons.save),
                      //   label: fncLabelButtonStyle('Simpan Data', context),
                      //   style: fncButtonRegulerStyle(context),
                      // ),
                      // const SizedBox(width: 10),
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
