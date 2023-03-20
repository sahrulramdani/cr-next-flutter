import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class InfoPelanggan extends StatefulWidget {
  String idPelanggan;
  InfoPelanggan({Key key, @required this.idPelanggan}) : super(key: key);

  @override
  State<InfoPelanggan> createState() => _InfoPelangganState();
}

class _InfoPelangganState extends State<InfoPelanggan> {
  List<Map<String, dynamic>> detailPelanggan = [];

  void pelangganDet() async {
    var id = widget.idPelanggan;
    var response = await http.get(
        Uri.parse("$urlAddress/jamaah/jamaah/detail/info-pelanggan/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      detailPelanggan = dataStatus;
    });
  }

  @override
  void initState() {
    pelangganDet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataTable(columns: [
              const DataColumn(label: Text('NIK')),
              const DataColumn(label: Text(':')),
              DataColumn(
                  label: Text(detailPelanggan.isNotEmpty
                      ? detailPelanggan[0]['NOXX_IDNT'].toString()
                      : '')),
            ], rows: [
              DataRow(cells: [
                const DataCell(Text('Nama Lengkap')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? detailPelanggan[0]['NAMA_LGKP']
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Jenis Kelamin')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? detailPelanggan[0]['KELAMIN']
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Tempat Lahir')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? detailPelanggan[0]['TMPT_LHIR']
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Tanggal Lahir')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? fncGetTanggal(detailPelanggan[0]['KELAHIRAN'])
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Alamat')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? detailPelanggan[0]['ALAMAT']
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Kelurahan')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? detailPelanggan[0]['KDXX_KELX']
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Kecamatan')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? detailPelanggan[0]['KDXX_KECX']
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Kab/Kota')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? detailPelanggan[0]['KDXX_KOTA']
                    : '')),
              ]),
            ]),
            const SizedBox(width: 10),
            DataTable(columns: [
              const DataColumn(label: Text('Provinsi')),
              const DataColumn(label: Text(':')),
              DataColumn(
                  label: Text(detailPelanggan.isNotEmpty
                      ? detailPelanggan[0]['KDXX_PROV']
                      : '')),
            ], rows: [
              DataRow(cells: [
                const DataCell(Text('Kode Pos')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? detailPelanggan[0]['KDXX_POSX'].toString()
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Telepon')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? detailPelanggan[0]['NOXX_TELP'].toString()
                    : '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Nama Paspor')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? (detailPelanggan[0]['NAMA_PSPR'] ?? '-')
                    : 'Belum Tersedia')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Nomor Paspor')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? (detailPelanggan[0]['NOXX_PSPR'] ?? '-')
                    : '-')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Issued Paspor')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? (detailPelanggan[0]['TGLX_KLUR'] == null
                        ? '-'
                        : DateFormat("dd-MM-yyyy").format(
                            DateTime.parse(detailPelanggan[0]['TGLX_KLUR'])))
                    : '-')),
              ]),

              // DateFormat("dd-MM-yyyy")
              //           .format(DateTime.parse(detailPelanggan[0]['TGLX_KLUR']))
              DataRow(cells: [
                const DataCell(Text('Expire Paspor')),
                const DataCell(Text(':')),
                DataCell(Text(detailPelanggan.isNotEmpty
                    ? (detailPelanggan[0]['TGLX_EXPX'] == null
                        ? '-'
                        : DateFormat("dd-MM-yyyy").format(
                            DateTime.parse(detailPelanggan[0]['TGLX_EXPX'])))
                    : '-')),
              ]),
              // DataRow(cells: [
              //   const DataCell(Text('Nama Ayah')),
              //   const DataCell(Text(':')),
              //   DataCell(Text(detailPelanggan.isNotEmpty
              //       ? detailPelanggan[0]['NAMA_AYAH']
              //       : '')),
              // ]),
              // eeDataRow(cells: [
              //   DataCell(Text('Tanggal Input')),
              //   DataCell(Text(':')),
              //   DataCell(Text('06-01-2023 15:34')),
              // ]),
            ]),
          ],
        ),
      ),
    );
  }
}
