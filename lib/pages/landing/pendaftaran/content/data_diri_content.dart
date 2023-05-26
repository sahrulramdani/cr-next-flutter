import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/foundation.dart';

class DataDiriContent extends StatefulWidget {
  final Uint8List ktpPelangganByte;
  final String nik;
  final String nama;
  final String jk;
  final String tempatLahir;
  final String tanggalLahir;
  final String alamat;
  final String provinsi;
  final String kota;
  final String kecamatan;
  final String kelurahan;
  final String kodePos;
  final String namaAyah;
  final String telp;
  final String menikah;
  final String pendidikan;
  final String pekerjaan;
  final String namaAgen;
  const DataDiriContent({
    Key key,
    @required this.ktpPelangganByte,
    @required this.nik,
    @required this.nama,
    @required this.jk,
    @required this.tempatLahir,
    @required this.tanggalLahir,
    @required this.alamat,
    @required this.provinsi,
    @required this.kota,
    @required this.kecamatan,
    @required this.kelurahan,
    @required this.kodePos,
    @required this.namaAyah,
    @required this.telp,
    @required this.menikah,
    @required this.pendidikan,
    @required this.pekerjaan,
    @required this.namaAgen,
  }) : super(key: key);

  @override
  State<DataDiriContent> createState() => _DataDiriContentState();
}

class _DataDiriContentState extends State<DataDiriContent> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final decorationBox = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 3,
          blurRadius: 4,
          offset: const Offset(0, 3),
        ),
      ],
    );

    return Column(
      children: [
        Container(
          width: screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          decoration: decorationBox,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Detail Data Diri",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: myBlue,
                        fontSize: 15)),
                const SizedBox(height: 15),
                Divider(thickness: 1, color: myBlue),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.ktpPelangganByte != null
                        ? Image.memory(
                            widget.ktpPelangganByte,
                            height: 100,
                          )
                        : const Image(
                            image: AssetImage('assets/images/ktp_pict.jpg'),
                            height: 100,
                          )
                  ],
                ),
                const SizedBox(height: 15),
                Divider(thickness: 1, color: myBlue),
                const SizedBox(height: 15),
                SizedBox(
                  width: screenWidth,
                  child: DataTable(
                      columnSpacing: 5,
                      headingTextStyle: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy',
                          fontSize: screenWidth < 550 ? 11 : 14),
                      dataTextStyle: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy',
                          fontSize: screenWidth < 550 ? 11 : 14),
                      columns: [
                        const DataColumn(
                            label: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('NIK'))),
                        const DataColumn(label: Text(':')),
                        DataColumn(
                            label: Align(
                                alignment: Alignment.centerRight,
                                child: Text(widget.nik ?? ''))),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Nama Lengkap'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.nik ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Jenis Kelamin'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.jk ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Tempat, Tanggal Lahir'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "${widget.tempatLahir ?? ''}, ${widget.tanggalLahir ?? ''}"))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Alamat Lengkap'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.alamat ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Provinsi'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.provinsi ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Kota / Kabupaten'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.kota ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Kecamatan'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.kecamatan ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Kelurahan'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.kelurahan ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Kode Pos'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.kodePos ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Nama Ayah'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.namaAyah ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Nomor Telepon'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.telp ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Status Menikah'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.menikah ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Pendidikan Terakhir'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.pendidikan ?? ''))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Pekerjaan'))),
                          const DataCell(Text(':')),
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.pekerjaan ?? ''))),
                        ]),
                      ]),
                ),
                const SizedBox(height: 20),
                const Text(
                    "Periksa kembali data yang dimasukan, apakah sudah benar atau belum"),
                const Text("Isi semua field dengan seksama, dan benar"),
                Text(
                    "Dan pastikan apakah kamu benar Jamaah dari Saudara/Saudari ${widget.namaAgen}"),
              ]),
        ),
      ],
    );
  }
}
