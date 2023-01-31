// ignore_for_file: missing_return, deprecated_member_use, prefer_interpolation_to_compose_strings
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';

class PengeluaranForm extends StatefulWidget {
  const PengeluaranForm({Key key}) : super(key: key);

  @override
  State<PengeluaranForm> createState() => _PengeluaranFormState();
}

class _PengeluaranFormState extends State<PengeluaranForm> {
  List<Map> objBarang = [];

  int nomor = 0;
  int urut = 1;
  String kodeBarang;
  String namaBarang;
  String satuan;
  String keterangan;
  TextEditingController harga = TextEditingController();
  TextEditingController qty = TextEditingController();

  Widget inputFaktur() {
    return TextFormField(
      readOnly: true,
      initialValue: "PB120223002",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration:
          const InputDecoration(labelText: 'Faktur', hintText: 'Auto Generate'),
    );
  }

  Widget inputBarang() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Pilih Barang",
          items: listBarang,
          onChanged: (value) {
            setState(() {
              kodeBarang = value['id'];
              namaBarang = value['nama'];
              satuan = value['satuan'];
              harga.text = value['harga_jual'];
            });
          },
          showClearButton: true,
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                  item['nama'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    '${'Harga Beli : ' + item['harga_beli']} - Harga Jual : ' +
                        item['harga_jual'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                    '${'Stok : ' + item['stok']} - ' + item['satuan'],
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaBarang ?? 'Pilih Barang'),
          validator: (value) {
            if (value == null) {
              return "Produk masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputSatuan() {
    return TextFormField(
      readOnly: true,
      initialValue: satuan ?? 'Satuan',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration:
          const InputDecoration(labelText: 'Satuan', hintText: 'Auto Generate'),
    );
  }

  Widget inputHarga() {
    return TextFormField(
      readOnly: true,
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      controller: harga,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Harga Beli'),
    );
  }

  Widget inputQty() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: qty,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Quantity'),
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      onChanged: (value) {
        keterangan = value;
      },
      initialValue: keterangan ?? '',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Keterangan'),
    );
  }

  Widget cmdTambah() {
    return ElevatedButton.icon(
      onPressed: () {
        NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

        if (kodeBarang != null) {
          if (qty.text != null) {
            var obj = [
              {
                "no": nomor,
                "urut": urut,
                "kode_barang": kodeBarang,
                "nama_barang": namaBarang,
                "qty": qty.text,
                "satuan": satuan,
                "harga": harga.text,
                "total": myFormat
                    .format(int.parse(qty.text) *
                        int.parse(harga.text.replaceAll(',', '')))
                    .toString(),
                "keterangan": keterangan ?? ''
              }
            ];

            setState(() {
              objBarang.addAll(obj);
              nomor = nomor + 1;
              urut = urut + 1;
            });
          }
        }
      },
      icon: const Icon(Icons.playlist_add_outlined),
      label: const Text(
        'Tambah',
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

  Widget cmdClear() {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          objBarang = [];
          nomor = 0;
          urut = urut + 1;
        });
      },
      icon: const Icon(Icons.clear),
      label: const Text(
        'Clear All',
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

  Widget menuButton() => SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            cmdTambah(),
            //---------------------------------
            spacePemisah(),
            //---------------------------------
            cmdClear(),
          ],
        ),
      );

  fncSaveData() {
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Pengeluaran');
    navigationController.navigateTo('/inventory/pengeluaran');
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final screenWidth = MediaQuery.of(context).size.width;

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
                      'Transaksi Pengeluaran Barang',
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
                  fncSaveData();
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
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                            inputFaktur(),
                            const SizedBox(height: 8),
                            inputBarang(),
                            const SizedBox(height: 8),
                            inputSatuan(),
                            const SizedBox(height: 8),
                            inputHarga(),
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
                            inputQty(),
                            const SizedBox(height: 8),
                            inputKeterangan(),
                            const SizedBox(height: 75),
                            menuButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 1075,
                        height: 190,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            border: TableBorder.all(color: Colors.grey),
                            columns: const [
                              DataColumn(label: Text('No.')),
                              DataColumn(label: Text('Kode Barang')),
                              DataColumn(label: Text('Nama Barang')),
                              DataColumn(label: Text('Qty')),
                              DataColumn(label: Text('Harga')),
                              DataColumn(label: Text('Total Harga')),
                              DataColumn(label: Text('Keterangan')),
                            ],
                            rows: objBarang.map((e) {
                              return DataRow(cells: [
                                DataCell(Text(e['urut'].toString())),
                                DataCell(Text(e['kode_barang'].toString())),
                                DataCell(Text(e['nama_barang'].toString())),
                                DataCell(Text(e['qty'].toString())),
                                DataCell(Text(e['harga'].toString())),
                                DataCell(Text(e['total'].toString())),
                                DataCell(Text(e['keterangan'].toString())),
                              ]);
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
