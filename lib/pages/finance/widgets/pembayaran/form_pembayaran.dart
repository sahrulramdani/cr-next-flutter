// ignore_for_file: missing_return, deprecated_member_use, prefer_interpolation_to_compose_strings
// import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';

class PembayaranForm extends StatefulWidget {
  const PembayaranForm({Key key}) : super(key: key);

  @override
  State<PembayaranForm> createState() => _PembayaranFormState();
}

class _PembayaranFormState extends State<PembayaranForm> {
  final _formKey = GlobalKey<FormState>();
  List<Map> objBarang = [];

  String namaPelanggan;
  String nik;
  String namaJadwal;
  String stringTotal;
  bool cekAll = false;
  bool disabledCekAll = true;
  String uangDiterima;
  String uangKembali;

  Widget inputPilihJamaah() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      height: 50,
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Pilih Jamaah",
          items: listPelanggan,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                namaPelanggan = value["nama"];
                nik = value["nik"];
              });
            } else {
              setState(() {
                namaPelanggan = null;
                nik = null;
              });
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                    item['nama'] + ' - ' + item['jk'] + ' - ' + item['umur'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                leading: const CircleAvatar(),
                subtitle: Text(
                    item['nik'] +
                        ' - No Telp : ' +
                        item['telp'] +
                        ' - TTL : ' +
                        item['ttl'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(item['alamat']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(namaPelanggan != null
              ? '$nik - $namaPelanggan'
              : "Jamaah belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Nama Jamaah masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputNamaJadwal() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Jadwal",
          items: listJadwalProduk,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                namaJadwal = value['paket'] +
                    ' - ' +
                    value['jenis'] +
                    ' - ' +
                    value['keterangan'];
                disabledCekAll = false;
              });
            } else {
              setState(() {
                namaJadwal = null;
                disabledCekAll = true;
              });
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                  item['paket'] +
                      ' - ' +
                      item['jenis'] +
                      ' - ' +
                      item['keterangan'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    item['uang'] +
                        ' ' +
                        item['tarif'] +
                        ' - ' +
                        'Sisa Seat : ' +
                        item['sisa'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(item['berangkat'] + ' - ' + item['pulang'],
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaJadwal ?? "Produk belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Jadwal Produk masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputJumlahTagihan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      readOnly: true,
      textAlign: TextAlign.right,
      decoration: const InputDecoration(
        labelText: 'Jumlah Tagihan',
      ),
      initialValue: stringTotal ?? '0',
    );
  }

  Widget inputJumlahPembayaran() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      readOnly: true,
      textAlign: TextAlign.right,
      decoration: const InputDecoration(
        labelText: 'Jumlah Pembayaran',
      ),
      initialValue: stringTotal ?? '0',
    );
  }

  Widget inputTotalBayar() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 25),
      readOnly: true,
      textAlign: TextAlign.right,
      decoration: const InputDecoration(
        labelText: 'Total Pembayaran',
        labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      initialValue: stringTotal ?? '0',
    );
  }

  Widget inputUangDiterima() {
    return TextFormField(
      key: _formKey,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'Uang Yang Diterima',
        labelStyle:
            TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
      ),
      initialValue: uangDiterima ?? '0',
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      onChanged: (value) {
        setState(() {
          uangDiterima = value;
        });
        fncKembali();
      },
    );
  }

  Widget inputUangKembali() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'Uang Kembali',
        labelStyle:
            TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold),
      ),
      initialValue: uangKembali ?? '0',
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
    );
  }

  Widget inputCaraBayar() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Metode Pembayaran",
        mode: Mode.MENU,
        items: const [
          "Tunai",
          "Transfer",
          "Virtual Account",
        ],
        selectedItem: "Pilih Metode Pembayaran",
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Metode Pembayaran") {
            return "Metode Pembayaran masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputRekTabungan() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Rekening Tabungan",
        mode: Mode.MENU,
        items: const [
          "Bank BRI",
          "Bank BTN",
          "Bank BNI",
          "Bank Mandiri",
          "Bank CimbNiaga",
        ],
        selectedItem: "Pilih Rekening Tabungan",
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Rekening Tabungan") {
            return "Rekening Tabungan masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Keterangan'),
    );
  }

  Widget buttonCari() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.save),
      label: const Text(
        'Cari Tagihan',
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

  Widget buttonRefresh() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.refresh_outlined),
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
    );
  }

  fncCekAll() {
    for (var i = 0; i < listTagihan.length; i++) {
      setState(() {
        listTagihan[i]['cek'] = cekAll;
      });
    }
  }

  fncTotal() {
    int ttl = 0;
    for (var i = 0; i < listTagihan.length; i++) {
      if (listTagihan[i]['cek'] == true) {
        ttl += int.parse(
            listTagihan[i]['jml_tagihan'].toString().replaceAll(',', ''));
      }
    }

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      stringTotal = myFormat.format(ttl).toString();
      uangKembali = '0';
    });
  }

  fncKembali() {
    int kembali = -1 *
        ((int.parse(stringTotal.replaceAll(',', ''))) -
            (int.parse(
                uangDiterima != '' ? uangDiterima.replaceAll(',', '') : 0)));
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    setState(() {
      uangKembali = myFormat.format(kembali == -0 ? 0 : kembali).toString();
    });
  }

  fncSaveData() {
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    // menuController.changeActiveitemTo('Pengeluaran');
    // navigationController.navigateTo('/inventory/pengeluaran');
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    int x = 1;

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
                      'Pembayaran Jamaah',
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
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 1085,
                    height: 60,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: inputPilihJamaah(),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 300,
                          child: inputNamaJadwal(),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            buttonCari(),
                            const SizedBox(width: 5),
                            buttonRefresh()
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 1085,
                    child: Row(children: [
                      Container(
                        width: 543,
                        height: 400,
                        // color: Colors.amber[200],
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1,
                                style: BorderStyle.solid)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              dataRowHeight: 35,
                              headingTextStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              border: TableBorder.all(color: Colors.grey[200]),
                              columns: [
                                const DataColumn(label: Text('No.')),
                                DataColumn(
                                    label: Checkbox(
                                  value: cekAll,
                                  onChanged: (bool value) {
                                    if (disabledCekAll == false) {
                                      setState(() {
                                        cekAll = !cekAll;
                                      });
                                      fncCekAll();
                                      fncTotal();
                                    }
                                  },
                                )),
                                const DataColumn(label: Text('Tagihan')),
                                const DataColumn(label: Text('Nominal')),
                                const DataColumn(label: Text('Jumlah Bayar')),
                                const DataColumn(label: Text('Sisa')),
                              ],
                              rows: namaJadwal == null
                                  ? []
                                  : listTagihan.map((e) {
                                      return DataRow(cells: [
                                        DataCell(Text((x++).toString())),
                                        DataCell(Checkbox(
                                          value: e['cek'],
                                          onChanged: (bool value) {
                                            setState(() {
                                              e['cek'] = !e['cek'];
                                            });
                                            fncTotal();
                                          },
                                        )),
                                        DataCell(Text(e['nama_tagihan'])),
                                        DataCell(Text(e['jml_tagihan'])),
                                        DataCell(Text(e['cek'] == false
                                            ? '0'
                                            : e['jml_tagihan'])),
                                        DataCell(Text(e['cek'] == false
                                            ? e['jml_tagihan']
                                            : '0')),
                                      ]);
                                    }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 542,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 255,
                                  child: inputJumlahTagihan(),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 255,
                                  child: inputJumlahPembayaran(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            inputTotalBayar(),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                SizedBox(
                                  width: 255,
                                  child: inputUangDiterima(),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 255,
                                  child: inputUangKembali(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                            Divider(
                              thickness: 5,
                              color: myBlue,
                            ),
                            const SizedBox(height: 35),
                            Row(
                              children: [
                                SizedBox(
                                  width: 255,
                                  child: inputCaraBayar(),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 255,
                                  child: inputRekTabungan(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            inputKeterangan(),
                          ],
                        ),
                      )
                    ]),
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
