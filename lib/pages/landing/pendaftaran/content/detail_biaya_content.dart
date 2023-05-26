import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/foundation.dart';

class DetailBiayaContent extends StatefulWidget {
  String nik;
  String tarif;
  String biayaVaksin;
  String biayaPaspor;
  String biayaAdmin;
  String biayaHandling;
  String biayaKamar;
  String estimasi;
  String paket;
  String berangkat;
  String pulang;
  String namaPelanggan;
  String umur;
  String harga;
  String alamat;
  String paspor;
  String vaksin;
  String pembuatan;
  String fotoJadwal;
  DetailBiayaContent({
    Key key,
    @required this.nik,
    @required this.tarif,
    @required this.biayaVaksin,
    @required this.biayaPaspor,
    @required this.biayaAdmin,
    @required this.biayaHandling,
    @required this.biayaKamar,
    @required this.estimasi,
    @required this.paket,
    @required this.berangkat,
    @required this.pulang,
    @required this.namaPelanggan,
    @required this.umur,
    @required this.harga,
    @required this.alamat,
    @required this.paspor,
    @required this.vaksin,
    @required this.pembuatan,
    @required this.fotoJadwal,
  }) : super(key: key);

  @override
  State<DetailBiayaContent> createState() => _DetailBiayaContentState();
}

class _DetailBiayaContentState extends State<DetailBiayaContent> {
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
                Text("Detail Paket & Biaya",
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
                    widget.fotoJadwal != ''
                        ? Image(
                            image: NetworkImage(
                                '$urlAddress/uploads/paket/${widget.fotoJadwal}'),
                            height: 100,
                          )
                        : const Image(
                            image: AssetImage('assets/images/NO_IMAGE.jpg'),
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
                      const DataColumn(label: Text('Paket')),
                      const DataColumn(label: Text(':')),
                      DataColumn(label: Text(widget.paket ?? '')),
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text('Berangkat')),
                        const DataCell(Text(':')),
                        DataCell(Text(widget.berangkat ?? '')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Pulang')),
                        const DataCell(Text(':')),
                        DataCell(Text(widget.pulang ?? '')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Nama')),
                        const DataCell(Text(':')),
                        DataCell(Text(widget.namaPelanggan ?? '')),
                      ]),
                      // DataRow(cells: [
                      //   const DataCell(Text('Umur')),
                      //   const DataCell(Text(':')),
                      //   DataCell(Text(widget.umur ?? '')),
                      // ]),
                      DataRow(cells: [
                        const DataCell(Text('Alamat')),
                        const DataCell(Text(':')),
                        DataCell(Text(widget.alamat ?? '')),
                      ]),
                      // DataRow(cells: [
                      //   const DataCell(Text('Paspor')),
                      //   const DataCell(Text(':')),
                      //   DataCell(Text(widget.paspor ?? '')),
                      // ]),
                      DataRow(cells: [
                        const DataCell(Text('Pemb. Paspor')),
                        const DataCell(Text(':')),
                        DataCell(Text(widget.pembuatan ?? '')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Prss. Vaksin')),
                        const DataCell(Text(':')),
                        DataCell(Text(widget.vaksin ?? '')),
                      ]),
                    ],
                  ),
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
                    columns: const [
                      DataColumn(
                          label: Text('Tarif',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text(':',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Harga',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text('Biaya Paket')),
                        const DataCell(Text(':')),
                        DataCell(Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.tarif ?? '0',
                            textAlign: TextAlign.right,
                          ),
                        )),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Biaya Vaksin')),
                        const DataCell(Text(':')),
                        DataCell(Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.biayaVaksin ?? '0',
                            textAlign: TextAlign.right,
                          ),
                        )),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Biaya Paspor')),
                        const DataCell(Text(':')),
                        DataCell(Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.biayaPaspor ?? '0',
                            textAlign: TextAlign.right,
                          ),
                        )),
                      ]),
                      // DataRow(cells: [
                      //   const DataCell(Text('Biaya Admin')),
                      //   const DataCell(Text(':')),
                      //   DataCell(Container(
                      //     alignment: Alignment.centerRight,
                      //     child: Text(
                      //       widget.biayaAdmin ?? '0',
                      //       textAlign: TextAlign.right,
                      //     ),
                      //   )),
                      // ]),
                      DataRow(cells: [
                        const DataCell(Text('Biaya Handling')),
                        const DataCell(Text(':')),
                        DataCell(Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.biayaHandling ?? '0',
                            textAlign: TextAlign.right,
                          ),
                        )),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Biaya Kamar')),
                        const DataCell(Text(':')),
                        DataCell(Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.biayaKamar ?? '0',
                            textAlign: TextAlign.right,
                          ),
                        )),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Estimasi Total')),
                        const DataCell(Text(':')),
                        DataCell(Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.estimasi ?? '0',
                            textAlign: TextAlign.right,
                          ),
                        )),
                      ]),
                    ],
                  ),
                ),
              ]),
        ),
      ],
    );
  }
}
