import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class TableSidePendaftaran extends StatefulWidget {
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

  TableSidePendaftaran({
    Key key,
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
  }) : super(key: key);

  @override
  State<TableSidePendaftaran> createState() => _TableSidePendaftaranState();
}

class _TableSidePendaftaranState extends State<TableSidePendaftaran> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 530,
          child: DataTable(
              border: TableBorder.all(
                  color: Colors.grey,
                  width: 2,
                  borderRadius: BorderRadius.circular(10)),
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
                DataRow(cells: [
                  const DataCell(Text('Biaya Admin')),
                  const DataCell(Text(':')),
                  DataCell(Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.biayaAdmin ?? '0',
                      textAlign: TextAlign.right,
                    ),
                  )),
                ]),
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
              ]),
        ),
        const SizedBox(width: 13),
        SizedBox(
          width: 530,
          child: DataTable(
            border: TableBorder.all(
                color: Colors.grey,
                width: 2,
                borderRadius: BorderRadius.circular(10)),
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
              DataRow(cells: [
                const DataCell(Text('Umur')),
                const DataCell(Text(':')),
                DataCell(Text(widget.umur ?? '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Alamat')),
                const DataCell(Text(':')),
                DataCell(Text(widget.alamat ?? '')),
              ]),
              DataRow(cells: [
                const DataCell(Text('Paspor')),
                const DataCell(Text(':')),
                DataCell(Text(widget.paspor ?? '')),
              ]),
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
              // DataRow(cells: [
              //   const DataCell(
              //       Text('Biaya Fasilitas')),
              //   const DataCell(Text(':')),
              //   DataCell(Text(fasilitas ?? '')),
              // ]),
              // DataRow(cells: [
              //   const DataCell(
              //       Text('Estimasi Total')),
              //   const DataCell(Text(':')),
              //   DataCell(Text(estimasi ?? '')),
              // ]),
            ],
          ),
        ),
      ],
    );
  }
}
