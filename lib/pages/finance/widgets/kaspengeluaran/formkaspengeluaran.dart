// ignore_for_file: missing_return, deprecated_member_use, prefer_interpolation_to_compose_strings, prefer_const_constructors, unnecessary_this
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FormKasPengeluaran extends StatefulWidget {
  const FormKasPengeluaran({Key key}) : super(key: key);

  @override
  State<FormKasPengeluaran> createState() => _FormKasPengeluaranState();
}

class _FormKasPengeluaranState extends State<FormKasPengeluaran> {
  List<Map> objBarang = [];

  int nomor = 0;
  int urut = 1;
  String kodeBarang;
  String namaBarang;
  String satuan;
  String paket;
  TextEditingController harga = TextEditingController();
  TextEditingController qty = TextEditingController();

  String tglTransaksi;
  bool isCheckedAPBS = false;
  bool isCheckedUangMk = false;
  bool isCheckedPosting = false;
  String nobukti;
  String keterangan;
  String keteranganTable;
  TextEditingController jumlahDana = TextEditingController(text: "0");
  TextEditingController jumlahBudget = TextEditingController(text: "0");
  TextEditingController sisaBudget = TextEditingController(text: "0");
  TextEditingController sisaDana = TextEditingController(text: "0");

  TextEditingController jumlahTransaksi = TextEditingController(text: "0");
  TextEditingController hargaTable = TextEditingController(text: "0");

  TextEditingController tgltransaksi = TextEditingController();

  List<Map<String, dynamic>> listJadwal = [];

  getJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/get-jadwal"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = dataStatus;
    });
  }

  @override
  void initState() {
    getJadwal();
    super.initState();
  }

  Widget inputNamaJadwal() {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');

    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Jadwal Paket",
          items: listJadwal,
          onChanged: (value) {
            paket = value["namaPaket"] +
                ' - ' +
                value['jenisPaket'] +
                ' - ' +
                value['KETERANGAN'] +
                ' - ' +
                fncGetTanggal(value['TGLX_BGKT']) +
                ' - ' +
                fncGetTanggal(value['TGLX_PLNG'] ?? '01-12-2023');
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                  item['namaPaket'] +
                      ' - ' +
                      item['jenisPaket'] +
                      ' - ' +
                      item['KETERANGAN'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    item['MATA_UANG'] +
                        ' ' +
                        myformat.format(item['TARIF_PKET']) +
                        ' - ' +
                        'Sisa Seat : ' +
                        item['SISA'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                    fncGetTanggal(item['TGLX_BGKT']) +
                        ' - ' +
                        fncGetTanggal(item['TGLX_PLNG'] ?? '01-12-2023'),
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              paket ?? "Paket Belum dipilih",
              style:
                  TextStyle(color: paket == null ? Colors.red : Colors.black)),
          validator: (value) {
            if (value == null) {
              return "Jadwal Produk masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget noTransaksi() {
    return TextFormField(
      readOnly: true,
      initialValue: "Auto Generate",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'No Transaksi'),
    );
  }

  Widget inputTglTransaksi() {
    return TextField(
      controller: tgltransaksi,
      decoration: const InputDecoration(label: Text("Tanggal Transaksi")),
      // onChanged: (String value) {
      //   tglTransaksi = value;
      // },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          tgltransaksi.text = formattedDate;
        }
      },
    );
  }

  Widget inputCabang() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          // enabled: enableTujuan,
          mode: Mode.BOTTOM_SHEET,
          label: "Cabang",
          items: ["Bekasi Barat", "Bekasi Timur", "Subang"],
          // onChanged: (value) {
          //   tujuan = value['KDXX_VALU'];
          //   namaTujuan = value['KDXX_DESC'];
          // },
          showSearchBox: true,
          // popupItemBuilder: (context, item, isSelected) => ListTile(
          //       title: Text(item['KDXX_DESC']),
          //     ),
          dropdownBuilder: (context, selectedItem) => Text(
                'Cabang',
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputPemohon() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          // enabled: enableTujuan,
          mode: Mode.BOTTOM_SHEET,
          label: "Pemohon",
          items: ["Sahrul", "Amin", "Asep"],
          // onChanged: (value) {
          //   tujuan = value['KDXX_VALU'];
          //   namaTujuan = value['KDXX_DESC'];
          // },
          showSearchBox: true,
          // popupItemBuilder: (context, item, isSelected) => ListTile(
          //       title: Text(item['KDXX_DESC']),
          //     ),
          dropdownBuilder: (context, selectedItem) => Text(
                'Pemohon',
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputSumberDana() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          // enabled: enableTujuan,
          mode: Mode.BOTTOM_SHEET,
          label: "Sumber Dana",
          items: ["Petty Cash", "Kas Operasional"],
          // onChanged: (value) {
          //   tujuan = value['KDXX_VALU'];
          //   namaTujuan = value['KDXX_DESC'];
          // },
          showSearchBox: true,
          // popupItemBuilder: (context, item, isSelected) => ListTile(
          //       title: Text(item['KDXX_DESC']),
          //     ),
          dropdownBuilder: (context, selectedItem) => Text(
                'Sumber Dana',
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputSumberBudget() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          // enabled: enableTujuan,
          mode: Mode.BOTTOM_SHEET,
          label: "Sumber Budget",
          items: ["Petty Cash", "Kas Operasional"],
          // onChanged: (value) {
          //   tujuan = value['KDXX_VALU'];
          //   namaTujuan = value['KDXX_DESC'];
          // },
          showSearchBox: true,
          // popupItemBuilder: (context, item, isSelected) => ListTile(
          //       title: Text(item['KDXX_DESC']),
          //     ),
          dropdownBuilder: (context, selectedItem) => Text(
                'Sumber Budget',
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputJumlahDana() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      controller: jumlahDana,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Jumlah Dana',
      ),
    );
  }

  Widget inputJumlahBudget() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      controller: jumlahBudget,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Jumlah Budget',
      ),
    );
  }

  Widget inputSisaDana() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      controller: sisaDana,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Sisa Dana',
      ),
    );
  }

  Widget inputSisaBudget() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      controller: sisaBudget,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Sisa Budget',
      ),
    );
  }

  Widget inputJumlahTransaksi() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      controller: jumlahTransaksi,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Jumlah Transaksi',
        labelStyle: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget inputSumberKas() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          // enabled: enableTujuan,
          mode: Mode.BOTTOM_SHEET,
          label: "Sumber Kas",
          items: ["Petty Cash", "Kas Operasional"],
          // onChanged: (value) {
          //   tujuan = value['KDXX_VALU'];
          //   namaTujuan = value['KDXX_DESC'];
          // },
          showSearchBox: true,
          // popupItemBuilder: (context, item, isSelected) => ListTile(
          //       title: Text(item['KDXX_DESC']),
          //     ),
          dropdownBuilder: (context, selectedItem) => Text(
                'Sumber Kas',
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
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

  Widget inputNoBukti() {
    return TextFormField(
      onChanged: (value) {
        nobukti = value;
      },
      initialValue: nobukti ?? '',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'No Bukti'),
    );
  }

  Widget inputUangMuka() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          // enabled: enableTujuan,
          mode: Mode.BOTTOM_SHEET,
          label: "Uang Muka",
          items: ["Petty Cash", "Kas Operasional"],
          // onChanged: (value) {
          //   tujuan = value['KDXX_VALU'];
          //   namaTujuan = value['KDXX_DESC'];
          // },
          showSearchBox: true,
          enabled: isCheckedUangMk,
          // popupItemBuilder: (context, item, isSelected) => ListTile(
          //       title: Text(item['KDXX_DESC']),
          //     ),
          dropdownBuilder: (context, selectedItem) => Text(
                'Uang Muka',
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputAkun() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          // enabled: enableTujuan,
          mode: Mode.BOTTOM_SHEET,
          label: "Kode Akun",
          items: ["Kas Operasional", "Bank BNI", "Bank BSI"],
          // onChanged: (value) {
          //   tujuan = value['KDXX_VALU'];
          //   namaTujuan = value['KDXX_DESC'];
          // },
          showSearchBox: true,
          // popupItemBuilder: (context, item, isSelected) => ListTile(
          //       title: Text(item['KDXX_DESC']),
          //     ),
          dropdownBuilder: (context, selectedItem) => Text(
                'Kode Akun',
              ),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputHargaTable() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      controller: hargaTable,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Harga',
        labelStyle: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget inputKeteranganTable() {
    return TextFormField(
      onChanged: (value) {
        keteranganTable = value;
      },
      initialValue: keteranganTable ?? '',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Keterangan'),
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
                      'Form Kas Pengeluaran',
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
              ),
              SizedBox(
                width: 5,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  menuController.changeActiveitemTo('Kas Pengeluaran');
                  navigationController.navigateTo('/finance/kas-pengeluaran');
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            noTransaksi(),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        width: 230,
                        child: Column(
                          children: [
                            inputTglTransaksi(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        width: 230,
                        child: Column(
                          children: [
                            inputCabang(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        width: 230,
                        child: Column(
                          children: [
                            inputPemohon(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 700,
                        child: inputNamaJadwal(),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Row(children: [
                              Text("Anggaran Paket"),
                              Checkbox(
                                value: this.isCheckedAPBS,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.isCheckedAPBS = value;
                                  });
                                },
                              ),
                            ]),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 150,
                            width: 830,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color.fromARGB(200, 164, 144, 124),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Column(children: [
                                          inputSumberDana(),
                                        ]),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Column(children: [
                                          inputJumlahDana(),
                                        ]),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Column(children: [
                                          inputSisaDana(),
                                        ]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Column(children: [
                                          inputSumberBudget(),
                                        ]),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Column(children: [
                                          inputJumlahBudget(),
                                        ]),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Column(children: [
                                          inputSisaBudget(),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                          ),
                          Container(
                            height: 150,
                            width: 830,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Column(children: [
                                          inputJumlahTransaksi(),
                                        ]),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Column(children: [
                                          inputSumberKas(),
                                        ]),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Column(children: [
                                          inputKeterangan(),
                                        ]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Column(children: [
                                          inputNoBukti(),
                                        ]),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                      SizedBox(
                                        width: 130,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 15),
                                            Row(children: [
                                              Text("Uang Muka"),
                                              Checkbox(
                                                value: this.isCheckedUangMk,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    this.isCheckedUangMk =
                                                        value;
                                                  });
                                                },
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Column(children: [
                                          inputUangMuka(),
                                        ]),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      SizedBox(
                                        width: 130,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 15),
                                            Row(children: [
                                              Text("Posting"),
                                              Checkbox(
                                                value: this.isCheckedPosting,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    this.isCheckedPosting =
                                                        value;
                                                  });
                                                },
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(200, 219, 228, 198),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Column(children: [
                                inputAkun(),
                              ]),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            SizedBox(
                              width: 200,
                              child: Column(children: [
                                inputHargaTable(),
                              ]),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            SizedBox(
                              width: 250,
                              child: Column(children: [
                                inputKeteranganTable(),
                              ]),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // fncSaveData();
                              },
                              icon: const Icon(Icons.add),
                              label: const Text(
                                'Tambah Data',
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                              child: SizedBox(
                                width: 1045,
                                height: 190,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    border: TableBorder.all(color: Colors.grey),
                                    columns: const [
                                      DataColumn(label: Text('Kode Akun')),
                                      DataColumn(label: Text('Nama Akun')),
                                      DataColumn(label: Text('Harga')),
                                      DataColumn(label: Text('Debit')),
                                      DataColumn(label: Text('Kredit')),
                                      DataColumn(label: Text('Keterangan')),
                                    ],
                                    rows: objBarang.map((e) {
                                      return DataRow(cells: [
                                        DataCell(Text(e['urut'].toString())),
                                        DataCell(
                                            Text(e['kode_barang'].toString())),
                                        DataCell(
                                            Text(e['nama_barang'].toString())),
                                        DataCell(Text(e['qty'].toString())),
                                        DataCell(Text(e['harga'].toString())),
                                        DataCell(Text(e['total'].toString())),
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
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
