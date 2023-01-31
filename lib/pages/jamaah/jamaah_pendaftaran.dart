// ignore_for_file: deprecated_member_use, missing_return

import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/modal_upload_dokumen.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JamaahPendaftaranPage extends StatefulWidget {
  const JamaahPendaftaranPage({Key key}) : super(key: key);

  @override
  State<JamaahPendaftaranPage> createState() => _JamaahPendaftaranPageState();
}

class _JamaahPendaftaranPageState extends State<JamaahPendaftaranPage> {
  List<Map<String, dynamic>> listAgency = [];
  String namaProduk;
  String namaPelanggan;
  String namaAgency;
  String paket;
  String tarif;
  String harga;
  String berangkat;
  String pulang;
  String umur;
  String alamat;
  String paspor;
  String pembuatan;
  String vaksin;
  String fasilitas;
  String biaya;
  String biayaVaksin;
  String biayaPaspor;
  String estimasi;

  String kk;
  String ktp;
  String lampiran;

  bool enableMarket = false;

  void getList() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/all-agency"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listAgency = dataStatus;
    });
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  Widget inputKantor() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          enabled: false,
          label: "Dari Kantor",
          mode: Mode.BOTTOM_SHEET,
          items: const [
            "Pusat",
            "Turangga",
            "Tasikmalaya",
            "KPRK Garut",
            "KPRK Tasikmalaya",
            "KPRK Karawang",
            "KPRK Purwakarta",
            "KPRK Cirebon",
          ],
          showSearchBox: true,
          onChanged: print,
          selectedItem: "Pusat",
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
                paket = value["paket"] +
                    ' ' +
                    value['jenis'] +
                    ' - ' +
                    value['keterangan'];
                tarif = value['uang'] + '.' + value["tarif"];
                berangkat = value["berangkat"];
                pulang = value["pulang"];
                harga = value["tarif"];
              });
              fncTotal();
            } else {
              setState(() {
                paket = '';
                tarif = '';
                berangkat = '';
                pulang = '';
                harga = '';
              });
              fncTotal();
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
          dropdownBuilder: (context, selectedItem) => Text(selectedItem != null
              ? selectedItem['keterangan']
              : "Produk belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Jadwal Produk masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputNamapelanggan() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      height: 50,
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Nama Pelanggan",
          items: listPelanggan,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                namaPelanggan = value["nama"];
                umur = value['umur'];
                alamat = value['alamat'];
                paspor = value['paspor'];

                ktp = 'KTP';
                kk = 'KK';
                lampiran = 'Belum';
              });
            } else {
              setState(() {
                namaPelanggan = '';
                umur = '';
                alamat = '';
                paspor = '';

                ktp = null;
                kk = null;
                lampiran = null;
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
          dropdownBuilder: (context, selectedItem) => Text(selectedItem != null
              ? selectedItem['nama']
              : "Pelanggan belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Nama Pelanggan masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputKTP() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "KTP",
          mode: Mode.MENU,
          items: const [
            "KTP",
            "Belum",
          ],
          onChanged: print,
          selectedItem: ktp ?? "Pilih Status KTP",
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputKK() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "KK",
          mode: Mode.MENU,
          items: const [
            "KK",
            "Belum",
          ],
          onChanged: print,
          selectedItem: kk ?? "Pilih Status KK",
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputLampiran() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Lampiran lainnya",
          mode: Mode.MENU,
          items: const [
            "Akte",
            "Surat Nikah",
            "Ijazah",
            "Belum",
          ],
          onChanged: print,
          selectedItem: lampiran ?? "Pilih Lampiran",
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputPaspor() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Paspor",
          mode: Mode.MENU,
          onChanged: (value) {
            if (value != null) {
              if (value == 'Proses Sendiri / Pending Paspor' ||
                  value == 'Telah Diterima Dikantor') {
                setState(() {
                  pembuatan = value;
                  biayaPaspor = '0';
                });
              } else {
                setState(() {
                  pembuatan = value;
                  biayaPaspor = '380,000';
                });
              }
              fncTotal();
            } else {
              setState(() {
                pembuatan = '';
              });
              fncTotal();
            }
          },
          items: const [
            "Pembuatan Baru / Kolektif Kantor",
            "Berita Acara Pemeriksaan",
            "Perpanjang",
            "Tambah Kata Nama",
            "Telah Diterima Dikantor",
            "Proses Sendiri / Pending Paspor",
          ],
          selectedItem: "Pilih Paspor",
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputVaksin() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Vaksin",
          mode: Mode.MENU,
          onChanged: (value) {
            if (value != null) {
              if (value == 'Proses Sendiri') {
                setState(() {
                  vaksin = value;
                  biayaVaksin = '0';
                });
              } else {
                setState(() {
                  vaksin = value;
                  biayaVaksin = '180,000';
                });
              }
              fncTotal();
            } else {
              setState(() {
                vaksin = '';
                biayaVaksin = '0';
              });
              fncTotal();
            }
          },
          items: const [
            "Kolektif Kantor",
            "Proses Sendiri",
          ],
          selectedItem: "Pilih Vaksin",
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputStatusHandling() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Status Handling",
          mode: Mode.MENU,
          items: const [
            "Diterima Lengkap",
            "Diterima Sebagian",
            "Belum Diterima",
            "Tidak Dengan Handling",
          ],
          onChanged: print,
          selectedItem: "Pilih Status Handling",
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputHandling() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          enabled: false,
          label: "Handling",
          mode: Mode.BOTTOM_SHEET,
          items: const [
            "Tidak Ada Keterangan",
            "Tidak Ada Keterangan",
            "Tidak Ada Keterangan",
          ],
          onChanged: print,
          selectedItem: "Pilih Handling",
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputBiayaFasilitas() {
    return TextFormField(
      textAlign: TextAlign.right,
      onChanged: (value) {
        setState(() {
          fasilitas = 'IDR.$value';
          biaya = value;
        });
        fncTotal();
      },
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Biaya Fasilitas'),
    );
  }

  Widget inputKurs() {
    return TextFormField(
      initialValue: "15,653",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration:
          const InputDecoration(labelText: 'Kurs Saat Ini', hintText: '15,653'),
    );
  }

  Widget inputRefrensi() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Refrensi",
          mode: Mode.BOTTOM_SHEET,
          items: const [
            "LANGSUNG",
            "MARKETING",
            "MARKETING NONSISTEM",
            "UMROH SMART",
            "TOURLEADER",
            "FREE",
          ],
          onChanged: (value) {
            if (value == 'MARKETING') {
              setState(() {
                enableMarket = true;
              });
            } else {
              setState(() {
                enableMarket = false;
              });
            }
          },
          selectedItem: "Pilih Refrensi",
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputNamaMarketing() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          enabled: enableMarket,
          mode: Mode.BOTTOM_SHEET,
          label: "Nama Leader",
          items: listAgency,
          onChanged: (value) {
            if (value != null) {
              namaAgency = value["KDXX_AGEN"];
            } else {
              namaAgency = '';
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_LGKP'].toString()),
                leading: const CircleAvatar(),
                subtitle: Text(item['KDXX_AGEN'].toString()),
                trailing: Text(
                    DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(item['TGLX_LHIR'].toString())),
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) => Text(selectedItem != null
              ? selectedItem['NAMA_LGKP']
              : "Leader belum Dipilih"),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputKamar() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Kategori Kamar",
          mode: Mode.BOTTOM_SHEET,
          items: const [
            "Suite",
            "Double",
            "Triple",
            "Quad",
          ],
          onChanged: print,
          selectedItem: "Pilih Kategori Kamar",
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputRouteFile() {
    return TextFormField(
      initialValue: "Upload Foto",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Upload Foto',
      ),
    );
  }

  fncTotal() {
    int cek = ((biaya != null ? int.parse(biaya.replaceAll(',', '')) : 0) +
        (harga != null ? int.parse(harga.replaceAll(',', '')) : 0) +
        (biayaPaspor != null ? int.parse(biayaPaspor.replaceAll(',', '')) : 0) +
        (biayaVaksin != null ? int.parse(biayaVaksin.replaceAll(',', '')) : 0));

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      estimasi = ('IDR.${myFormat.format(cek)}').toString();
    });
  }

  fncSaveData() {
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Pelanggan');
    navigationController.navigateTo('/jamaah/pelanggan');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: 'Jamaah - ${menuController.activeItem.value}',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          const SizedBox(height: 20),
          Container(
            width: screenWidth,
            padding: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Form Pendaftaran',
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
                    Row(
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
                            minimumSize: const Size(100, 40),
                            shadowColor: Colors.grey,
                            elevation: 5,
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            menuController.changeActiveitemTo('Pendaftaran');
                            navigationController
                                .navigateTo('/jamaah/pendaftaran');
                          },
                          icon: const Icon(Icons.restart_alt),
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
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.7,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Row(children: [
                              Container(
                                width: 700,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    inputKantor(),
                                    const SizedBox(height: 8),
                                    inputNamaJadwal(),
                                    const SizedBox(height: 8),
                                    inputNamapelanggan(),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        SizedBox(width: 213, child: inputKTP()),
                                        const SizedBox(width: 20),
                                        SizedBox(width: 213, child: inputKK()),
                                        const SizedBox(width: 20),
                                        SizedBox(
                                            width: 213, child: inputLampiran()),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(
                                    //         width: 330, child: inputPaspor()),
                                    //     const SizedBox(width: 20),
                                    //     SizedBox(
                                    //         width: 330, child: inputVaksin()),
                                    //   ],
                                    // ),
                                    inputPaspor(),
                                    const SizedBox(height: 8),
                                    inputVaksin(),
                                    const SizedBox(height: 8),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(
                                    //         width: 300,
                                    //         child: inputStatusHandling()),
                                    //     const SizedBox(width: 20),
                                    //     SizedBox(
                                    //         width: 360, child: inputHandling()),
                                    //   ],
                                    // ),
                                    inputHandling(),
                                    const SizedBox(height: 8),
                                    inputStatusHandling(),
                                    const SizedBox(height: 8),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(
                                    //         width: 460,
                                    //         child: inputBiayaFasilitas()),
                                    //     const SizedBox(width: 20),
                                    //     SizedBox(
                                    //         width: 200, child: inputKurs()),
                                    //   ],
                                    // ),
                                    inputKurs(),
                                    const SizedBox(height: 8),
                                    inputRefrensi(),
                                    const SizedBox(height: 8),
                                    inputNamaMarketing(),
                                    const SizedBox(height: 8),
                                    inputKamar(),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 450,
                                            child: inputRouteFile()),
                                        const SizedBox(width: 10),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const ModalUploadDokumen());
                                            },
                                            icon: const Icon(Icons.save),
                                            label: const Text(
                                              'Upload Dokumen',
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy'),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: myBlue,
                                              minimumSize: const Size(100, 40),
                                              shadowColor: Colors.grey,
                                              elevation: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 400,
                                    child: DataTable(
                                        dataRowHeight: 35,
                                        border:
                                            TableBorder.all(color: Colors.grey),
                                        columns: [
                                          const DataColumn(
                                              label: Text('Tarif')),
                                          const DataColumn(label: Text(':')),
                                          DataColumn(
                                              label: Text(
                                            tarif ?? '0',
                                            textAlign: TextAlign.right,
                                          )),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            const DataCell(Text('Tarif')),
                                            const DataCell(Text(':')),
                                            DataCell(Text(
                                              tarif ?? '0',
                                              textAlign: TextAlign.right,
                                            )),
                                          ]),
                                          DataRow(cells: [
                                            const DataCell(
                                                Text('Biaya Vaksin')),
                                            const DataCell(Text(':')),
                                            DataCell(Expanded(
                                              child: Text(
                                                biayaVaksin ?? '0',
                                                textAlign: TextAlign.right,
                                              ),
                                            )),
                                          ]),
                                          DataRow(cells: [
                                            const DataCell(
                                                Text('Biaya Paspor')),
                                            const DataCell(Text(':')),
                                            DataCell(Expanded(
                                              child: Text(
                                                biayaPaspor ?? '0',
                                                textAlign: TextAlign.right,
                                              ),
                                            )),
                                          ]),
                                          DataRow(cells: [
                                            const DataCell(
                                                Text('Estimasi Total')),
                                            const DataCell(Text(':')),
                                            DataCell(Expanded(
                                              child: Text(
                                                estimasi ?? '0',
                                                textAlign: TextAlign.right,
                                              ),
                                            )),
                                          ]),
                                        ]),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: 400,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        children: [
                                          DataTable(
                                            columns: [
                                              const DataColumn(
                                                  label: Text('Paket')),
                                              const DataColumn(
                                                  label: Text(':')),
                                              DataColumn(
                                                  label: Text(paket ?? '')),
                                            ],
                                            rows: [
                                              // DataRow(cells: [
                                              //   const DataCell(Text('Tarif')),
                                              //   const DataCell(Text(':')),
                                              //   DataCell(Text(
                                              //     tarif ?? '',
                                              //     textAlign: TextAlign.right,
                                              //   )),
                                              // ]),
                                              DataRow(cells: [
                                                const DataCell(
                                                    Text('Berangkat')),
                                                const DataCell(Text(':')),
                                                DataCell(Text(berangkat ?? '')),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('Pulang')),
                                                const DataCell(Text(':')),
                                                DataCell(Text(pulang ?? '')),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('Nama')),
                                                const DataCell(Text(':')),
                                                DataCell(
                                                    Text(namaPelanggan ?? '')),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('Umur')),
                                                const DataCell(Text(':')),
                                                DataCell(Text(umur ?? '')),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('Alamat')),
                                                const DataCell(Text(':')),
                                                DataCell(Text(alamat ?? '')),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('Paspor')),
                                                const DataCell(Text(':')),
                                                DataCell(Text(paspor ?? '')),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(
                                                    Text('Pemb. Paspor')),
                                                const DataCell(Text(':')),
                                                DataCell(Text(pembuatan ?? '')),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(
                                                    Text('Prss. Vaksin')),
                                                const DataCell(Text(':')),
                                                DataCell(Text(vaksin ?? '')),
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
