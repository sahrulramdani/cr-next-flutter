// ignore_for_file: deprecated_member_use, missing_return

import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/models/http_pendaftaran.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/modal_upload_foto_jamaah.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
// import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JamaahPendaftaranPage extends StatefulWidget {
  const JamaahPendaftaranPage({Key key}) : super(key: key);

  @override
  State<JamaahPendaftaranPage> createState() => _JamaahPendaftaranPageState();
}

class _JamaahPendaftaranPageState extends State<JamaahPendaftaranPage> {
  String idKantor = '00001';
  String namaKantor;
  String idProduk;
  String namaProduk;
  String nik;
  String namaPelanggan;
  String kk;
  String ktp;
  String lampiran;
  String pembuatan;
  String vaksin;
  String handling;
  String refrensi;
  String namaAgency;
  String totalEst;
  String tglBerangkat;

  String paket;
  String tarif;
  String harga;
  String berangkat;
  String pulang;
  String umur;
  String alamat;
  String paspor;
  String fasilitas;
  // String biaya;
  String biayaVaksin;
  String biayaPaspor;
  String biayaAdmin = '100,000';
  String estimasi;
  String mataUang;

  String ktpPelanggan;
  Uint8List ktpPelangganByte;

  String fotoKkPelanggan = "";
  String fotoKkPelangganBase = "";
  Uint8List fotoKkPelangganByte;

  String fotoDokPelanggan = "";
  String fotoDokPelangganBase = "";
  Uint8List fotoDokPelangganByte;

  bool enableMarket = false;

  List<Map<String, dynamic>> listAgency = [];
  List<Map<String, dynamic>> listJadwal = [];
  List<Map<String, dynamic>> listKantor = [];
  List<Map<String, dynamic>> listJamaah = [];
  List<Map<String, String>> listTagihan = [];

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

  getKantor() async {
    var response = await http.get(Uri.parse("$urlAddress/setup/kantor"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKantor = dataStatus;
    });
  }

  getJadwal() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/jadwal/get-jadwal"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = dataStatus;
    });
  }

  void getJamaah() async {
    var response = await http.get(Uri.parse("$urlAddress/jamaah/all-jamaah"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    listJamaah = dataStatus;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getList();
    getJadwal();
    getKantor();
    getJamaah();
  }

  Widget inputKantor() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        enabled: enableMarket,
        mode: Mode.BOTTOM_SHEET,
        label: "Nama Kantor",
        items: listKantor,
        onChanged: (value) {
          namaKantor = value['NAMA_KNTR'];
          idKantor = value['KDXX_KNTR'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_KNTR'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => const Text('Pusat'),
        validator: (value) {
          if (value == "Nama Kantor belum Dipilih") {
            return "Kantor masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
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
          label: "Jadwal",
          items: listJadwal,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                idProduk = value['IDXX_JDWL'];
                paket = value["namaPaket"] +
                    ' ' +
                    value['jenisPaket'] +
                    ' - ' +
                    value['KETERANGAN'];
                tarif = myformat.format(value['TARIF_PKET']);
                berangkat = fncGetTanggal(value['TGLX_BGKT']);
                pulang = fncGetTanggal(value['TGLX_PLNG']);
                harga = myformat.format(value['TARIF_PKET']);
                mataUang = value['MATA_UANG'];
                tglBerangkat = value['TGLX_BGKT'];
              });
              // fncTotal();
            } else {
              setState(() {
                idProduk = '';
                paket = '';
                tarif = '';
                berangkat = '';
                pulang = '';
                harga = '';
                mataUang = '';
                tglBerangkat;
              });
              // fncTotal();
            }
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
                        fncGetTanggal(item['TGLX_PLNG']),
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              paket ?? "Jadwal Belum dipilih",
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
          items: listJamaah,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                nik = value['NOXX_IDNT'];
                namaPelanggan = value["NAMA_LGKP"];
                umur = value['UMUR'].toString();
                alamat = value['ALAMAT'];
                paspor =
                    value['NOXX_PSPR'] != null ? 'Tersedia' : 'Tidak Tersedia';

                ktp = value['FOTO_KTPX'] != '' ? 'KTP' : 'Belum';
                kk = 'Belum';
                lampiran = 'Belum';
                ktpPelanggan =
                    value['FOTO_KTPX'] == '' ? null : value['FOTO_KTPX'];
              });
            } else {
              setState(() {
                nik = null;
                namaPelanggan = '';
                umur = '';
                alamat = '';
                paspor = '';

                ktp = null;
                kk = null;
                lampiran = null;
                ktpPelanggan = null;
              });
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_LGKP'].toString()),
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage('$urlAddress/uploads/${item['FOTO_JMAH']}'),
                ),
                subtitle: Text(item['NOXX_IDNT'].toString()),
                trailing: Text(
                    DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(item['TGLX_LHIR'].toString())),
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              namaPelanggan ?? "Pelanggan Belum dipilih",
              style: TextStyle(
                  color: namaPelanggan == null ? Colors.red : Colors.black)),
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
          onChanged: (value) {
            ktp = value;
          },
          dropdownBuilder: (context, selectedItem) => Text(
              ktp ?? "Pilih Status KTP",
              style: TextStyle(color: ktp == null ? Colors.red : Colors.black)),
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
          onChanged: (value) {
            kk = value;
          },
          dropdownBuilder: (context, selectedItem) => Text(
              kk ?? "Pilih Status KK",
              style: TextStyle(color: kk == null ? Colors.red : Colors.black)),
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
          onChanged: (value) {
            lampiran = value;
          },
          dropdownBuilder: (context, selectedItem) => Text(
              lampiran ?? "Lampiran",
              style: TextStyle(
                  color: lampiran == null ? Colors.red : Colors.black)),
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
          dropdownBuilder: (context, selectedItem) => Text(
              pembuatan ?? "Pilih Paspor",
              style: TextStyle(
                  color: pembuatan == null ? Colors.red : Colors.black)),
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
          dropdownBuilder: (context, selectedItem) => Text(
              vaksin ?? "Pilih Vaksin",
              style:
                  TextStyle(color: vaksin == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  // Widget inputStatusHandling() {
  //   return Container(
  //     height: 50,
  //     decoration: const BoxDecoration(
  //         border: Border(
  //             bottom: BorderSide(
  //                 style: BorderStyle.solid, color: Colors.black, width: 0.4))),
  //     child: DropdownSearch(
  //         label: "Status Handling",
  //         mode: Mode.MENU,
  //         items: const [
  //           "Diterima Lengkap",
  //           "Diterima Sebagian",
  //           "Belum Diterima",
  //           "Tidak Dengan Handling",
  //         ],
  //         onChanged: (value) {
  //           handling = value;
  //         },
  //         selectedItem: "Pilih Status Handling",
  //         dropdownSearchDecoration:
  //             const InputDecoration(border: InputBorder.none)),
  //   );
  // }

  // Widget inputHandling() {
  //   return Container(
  //     height: 50,
  //     decoration: const BoxDecoration(
  //         border: Border(
  //             bottom: BorderSide(
  //                 style: BorderStyle.solid, color: Colors.black, width: 0.4))),
  //     child: DropdownSearch(
  //         enabled: false,
  //         label: "Handling",
  //         mode: Mode.BOTTOM_SHEET,
  //         items: const [
  //           "Tidak Ada Keterangan",
  //           "Tidak Ada Keterangan",
  //           "Tidak Ada Keterangan",
  //         ],
  //         onChanged: print,
  //         selectedItem: "Pilih Handling",
  //         dropdownSearchDecoration:
  //             const InputDecoration(border: InputBorder.none)),
  //   );
  // }

  // Widget inputBiayaFasilitas() {
  //   return TextFormField(
  //     textAlign: TextAlign.right,
  //     onChanged: (value) {
  //       setState(() {
  //         fasilitas = 'IDR.$value';
  //         biaya = value;
  //       });
  //       fncTotal();
  //     },
  //     keyboardType: TextInputType.number,
  //     inputFormatters: [ThousandsFormatter()],
  //     style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
  //     decoration: const InputDecoration(labelText: 'Biaya Fasilitas'),
  //   );
  // }

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
            refrensi = value;
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
          dropdownBuilder: (context, selectedItem) => Text(
              refrensi ?? "Pilih Refrensi",
              style: TextStyle(
                  color: refrensi == null ? Colors.red : Colors.black)),
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
          label: "Nama Marketing",
          items: listAgency,
          onChanged: (value) {
            if (value != null) {
              namaAgency = value["KDXX_MRKT"];
            } else {
              namaAgency = '';
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_LGKP'].toString()),
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage('$urlAddress/uploads/${item['FOTO_AGEN']}'),
                ),
                subtitle: Text(item['KDXX_MRKT'].toString()),
                trailing: Text(
                    DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(item['TGLX_LHIR'].toString())),
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) => Text(selectedItem != null
              ? selectedItem['NAMA_LGKP']
              : "Marketing belum Dipilih"),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  // Widget inputKamar() {
  //   return Container(
  //     height: 50,
  //     decoration: const BoxDecoration(
  //         border: Border(
  //             bottom: BorderSide(
  //                 style: BorderStyle.solid, color: Colors.black, width: 0.4))),
  //     child: DropdownSearch(
  //         label: "Kategori Kamar",
  //         mode: Mode.BOTTOM_SHEET,
  //         items: const [
  //           "Suite",
  //           "Double",
  //           "Triple",
  //           "Quad",
  //         ],
  //         onChanged: print,
  //         selectedItem: "Pilih Kategori Kamar",
  //         dropdownSearchDecoration:
  //             const InputDecoration(border: InputBorder.none)),
  //   );
  // }

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
    int cek = (
        // (biaya != null ? int.parse(biaya.replaceAll(',', '')) : 0) +
        (harga != null ? int.parse(harga.replaceAll(',', '')) : 0) +
            (biayaPaspor != null
                ? int.parse(biayaPaspor.replaceAll(',', ''))
                : 0) +
            (biayaAdmin != null
                ? int.parse(biayaAdmin.replaceAll(',', ''))
                : 0) +
            (biayaVaksin != null
                ? int.parse(biayaVaksin.replaceAll(',', ''))
                : 0));

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      estimasi = ('$mataUang.${myFormat.format(cek)}').toString();
      totalEst = cek.toString();
    });
  }

  Widget btnUploadKtp() {
    return ElevatedButton.icon(
      onPressed: () {
        // showDialog(
        //     context: context,
        //     builder: (context) =>
        //         const ModalUploadDokumen());
      },
      icon: const Icon(Icons.save),
      label: const Text(
        'Upload KTP',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 10,
      ),
    );
  }

  Widget btnUploadKK() {
    return ElevatedButton.icon(
      onPressed: () {
        getImageKK();
      },
      icon: const Icon(Icons.save),
      label: const Text(
        'Upload KK',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 10,
      ),
    );
  }

  Widget btnUploadDokumen() {
    return ElevatedButton.icon(
      onPressed: () {
        getImageDok();
      },
      icon: const Icon(Icons.save),
      label: const Text(
        'Upload Dokumen',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 10,
      ),
    );
  }

  Widget resultFotoKTP() {
    if (ktpPelangganByte != null) {
      return Image.memory(
        ktpPelangganByte,
        height: 100,
      );
    } else {
      if (ktpPelanggan != null) {
        return Image(
          image: NetworkImage('$urlAddress/uploads/$ktpPelanggan'),
          height: 100,
        );
      } else {
        return const Image(
          image: AssetImage('assets/images/NO_IMAGE.jpg'),
          height: 100,
        );
      }
    }
  }

  Widget resultFotoKK() {
    if (fotoKkPelangganByte != null) {
      return Image.memory(
        fotoKkPelangganByte,
        height: 100,
      );
    } else {
      return const Image(
        image: AssetImage('assets/images/NO_IMAGE.jpg'),
        height: 100,
      );
    }
  }

  Widget resultFotoDok() {
    if (fotoDokPelangganByte != null) {
      return Image.memory(
        fotoDokPelangganByte,
        height: 100,
      );
    } else {
      return const Image(
        image: AssetImage('assets/images/NO_IMAGE.jpg'),
        height: 100,
      );
    }
  }

  getImageKK() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoKkPelanggan = fileResult.files.first.name;
        fotoKkPelangganByte = fileResult.files.first.bytes;
        fotoKkPelangganBase = encodeFoto;
      });
    }
  }

  getImageDok() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoDokPelanggan = fileResult.files.first.name;
        fotoDokPelangganByte = fileResult.files.first.bytes;
        fotoDokPelangganBase = encodeFoto;
      });
    }
  }

  fncSaveData() async {
    // GET ID PELANGGAN
    var response1 = await http
        .get(Uri.parse("$urlAddress/jamaah/pendaftaran/kode"), headers: {
      'pte-token': kodeToken,
    });
    dynamic body1 = json.decode(response1.body);
    String idPelanggan = body1['idPelanggan'];

    // // GET ID TAGIHAN
    // var response2 = await http
    //     .get(Uri.parse("$urlAddress/jamaah/pendaftaran/tagihan"), headers: {
    //   'pte-token': kodeToken,
    // });
    // dynamic body2 = json.decode(response2.body);
    // String idTagihan = body2['idTagihan'];

    // MEMBUAT TAGIHAN
    var tagihan = {
      {
        '"nama_tagihan"': '"Paket Umroh"',
        '"total_tagihan"': '"${tarif.replaceAll(',', '')}"',
      },
      if (biayaVaksin != '0')
        {
          '"nama_tagihan"': '"Vaksin"',
          '"total_tagihan"': '"${biayaVaksin.replaceAll(',', '')}"',
        },
      if (biayaPaspor != '0')
        {
          '"nama_tagihan"': '"Paspor"',
          '"total_tagihan"': '"${biayaPaspor.replaceAll(',', '')}"',
        },
      {
        '"nama_tagihan"': '"Biaya Admin"',
        '"total_tagihan"': '"${biayaAdmin.replaceAll(',', '')}"',
      },
    };
    listTagihan.addAll(tagihan);

    // print(idPelanggan);
    // print(idKantor);
    // print(nik);
    // print(idProduk);
    // print(ktp);
    // print(kk);
    // print(lampiran);
    // print(pembuatan);
    // print(vaksin);
    // print(handling);
    // print(refrensi);
    // print(namaAgency);
    // print(totalEst);
    // print(fncJatuhTempo(tglBerangkat));
    // print(fotoKkPelangganBase != '' ? fotoKkPelangganBase : 'TIDAK');
    // print(fotoDokPelangganBase != '' ? fotoDokPelangganBase : 'TIDAK');
    // print('$listTagihan');

    HttpPendaftaran.savePendaftaran(
      idPelanggan,
      idKantor,
      nik,
      idProduk,
      ktp,
      kk,
      lampiran,
      pembuatan,
      vaksin,
      handling = 'Belum Diterima',
      refrensi,
      namaAgency ?? '',
      totalEst,
      fncJatuhTempo(tglBerangkat).toString(),
      '$listTagihan',
      fotoKkPelangganBase != '' ? fotoKkPelangganBase : 'TIDAK',
      fotoDokPelangganBase != '' ? fotoDokPelangganBase : 'TIDAK',
      // idTagihan
    ).then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());
        menuController.changeActiveitemTo('Pendaftaran');
        navigationController.navigateTo('/jamaah/pendaftaran');
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
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
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 330, child: inputPaspor()),
                                        const SizedBox(width: 20),
                                        SizedBox(
                                            width: 330, child: inputVaksin()),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // inputPaspor(),
                                    // inputVaksin(),
                                    // const SizedBox(height: 8),
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
                                    // const SizedBox(height: 8),
                                    // inputHandling(),
                                    // inputStatusHandling(),
                                    // const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 200, child: inputKurs()),
                                        const SizedBox(width: 20),
                                        SizedBox(
                                            width: 460, child: inputRefrensi()),
                                      ],
                                    ),
                                    // inputKurs(),
                                    // const SizedBox(height: 8),
                                    // inputRefrensi(),
                                    const SizedBox(height: 8),
                                    inputNamaMarketing(),
                                    const SizedBox(height: 8),
                                    // inputKamar(),
                                    // const SizedBox(height: 8),
                                    Container(
                                      width: 680,
                                      height: 260,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          resultFotoKTP(),
                                          const SizedBox(width: 10),
                                          resultFotoKK(),
                                          const SizedBox(width: 10),
                                          resultFotoDok()
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        // btnUploadKtp(),
                                        // const SizedBox(width: 10),
                                        btnUploadKK(),
                                        const SizedBox(width: 10),
                                        btnUploadDokumen()
                                      ],
                                    )
                                    // Row(
                                    //   children: [
                                    //     SizedBox(
                                    //         width: 450,
                                    //         child: inputRouteFile()),
                                    //     const SizedBox(width: 10),
                                    //     Container(
                                    //       padding:
                                    //           const EdgeInsets.only(top: 10),
                                    //       child: ElevatedButton.icon(
                                    //         onPressed: () {
                                    //           // showDialog(
                                    //           //     context: context,
                                    //           //     builder: (context) =>
                                    //           //         const ModalUploadDokumen());
                                    //         },
                                    //         icon: const Icon(Icons.save),
                                    //         label: const Text(
                                    //           'Upload Dokumen',
                                    //           style: TextStyle(
                                    //               fontFamily: 'Gilroy'),
                                    //         ),
                                    //         style: ElevatedButton.styleFrom(
                                    //           backgroundColor: myBlue,
                                    //           minimumSize: const Size(100, 40),
                                    //           shadowColor: Colors.grey,
                                    //           elevation: 10,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // )
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
                                        columns: const [
                                          DataColumn(
                                              label: Text('Tarif',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          DataColumn(
                                              label: Text(':',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          DataColumn(
                                              label: Text('Harga',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            const DataCell(Text('Tarif')),
                                            const DataCell(Text(':')),
                                            DataCell(Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                tarif ?? '0',
                                                textAlign: TextAlign.right,
                                              ),
                                            )),
                                          ]),
                                          DataRow(cells: [
                                            const DataCell(
                                                Text('Biaya Vaksin')),
                                            const DataCell(Text(':')),
                                            DataCell(Container(
                                              alignment: Alignment.centerRight,
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
                                            DataCell(Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                biayaPaspor ?? '0',
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
                                                biayaAdmin ?? '0',
                                                textAlign: TextAlign.right,
                                              ),
                                            )),
                                          ]),
                                          DataRow(cells: [
                                            const DataCell(
                                                Text('Estimasi Total')),
                                            const DataCell(Text(':')),
                                            DataCell(Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                estimasi ?? '0',
                                                textAlign: TextAlign.right,
                                              ),
                                            )),
                                          ]),
                                        ]),
                                  ),
                                  const SizedBox(height: 30),
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
