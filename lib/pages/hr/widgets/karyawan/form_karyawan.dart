// ignore_for_file: missing_return, deprecated_member_use
import 'package:flutter_web_course/constants/dummy_karyawan.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/modal_upload_foto_jamaah.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class KaryawanForm extends StatefulWidget {
  final List<Map<String, dynamic>> listProvinsi;

  const KaryawanForm({
    Key key,
    @required this.listProvinsi,
  }) : super(key: key);

  @override
  State<KaryawanForm> createState() => _KaryawanFormState();
}

class _KaryawanFormState extends State<KaryawanForm> {
  String nik;
  String namaKaryawan;
  String jenisKelamin;
  String jk;
  String tempatLahir;
  String tglLahir;
  String alamat;
  String idProvinsi;
  String namaProvinsi;
  String idKota;
  String namaKota;
  String idKec;
  String namaKec;
  String idKel;
  String namaKel;
  String kodePos;
  String namaAyah;
  String noTelp;
  String kantor;
  String masaKerja;
  String tglKeluar;
  String tglExpire;

  String menikah;
  String pendidikan;
  String pekerjaan;
  String karyawanLevel;
  String paspor;
  String cekpaspor;
  String noPaspor;
  String dikeluarkanDi;

  bool enableKontrak = true;

  List<Map<String, dynamic>> listKota = [];
  List<Map<String, dynamic>> listKec = [];
  List<Map<String, dynamic>> listKel = [];

  TextEditingController dateLahir = TextEditingController();
  TextEditingController dateKeluar = TextEditingController();
  TextEditingController dateExp = TextEditingController();

  getKota(id) async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/regencies/$id.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKota = dataStatus;
    });
  }

  getKec(id) async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/districts/$id.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKec = dataStatus;
    });
  }

  getKel(id) async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/villages/$id.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKel = dataStatus;
    });
  }

  Widget inputNIK() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration:
          const InputDecoration(labelText: 'NIK', hintText: '32xxxxxxxxxxx'),
      onChanged: (value) {
        nik = value;
      },
      initialValue: nik,
      validator: (value) {
        if (value.isEmpty) {
          return "NIK masih kosong !";
        }
      },
    );
  }

  Widget inputNama() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Nama Lengkap'),
      onChanged: (value) {
        namaKaryawan = value;
      },
      initialValue: namaKaryawan,
      validator: (value) {
        if (value.isEmpty) {
          return "Nama masih kosong !";
        }
      },
    );
  }

  Widget inputJenisKelamin() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Jenis Kelamin",
        mode: Mode.MENU,
        items: const ["Pria", "Wanita"],
        onChanged: (value) {
          if (value == "Pria") {
            jenisKelamin = 'P';
            jk = value;
          } else {
            jenisKelamin = 'W';
            jk = value;
          }
        },
        selectedItem: jk ?? "Pilih Jenis Kelamin",
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Jenis Kelamin") {
            return "Jenis Kelamin masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputTempatLahir() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Tempat Lahir'),
      onChanged: (value) {
        tempatLahir = value;
      },
      initialValue: tempatLahir,
      validator: (value) {
        if (value.isEmpty) {
          return "Tempat Lahir masih kosong !";
        }
      },
    );
  }

  Widget inputTglLahir() {
    return TextFormField(
      controller: dateLahir,
      decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
      onChanged: (String value) {
        tglLahir = value;
      },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateLahir.text = formattedDate;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tanggal Lahir masih kosong !";
        }
      },
    );
  }

  Widget inputAlamat() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Alamat'),
      onChanged: (value) {
        alamat = value;
      },
      initialValue: alamat,
      validator: (value) {
        if (value.isEmpty) {
          return "Alamat masih kosong !";
        }
      },
    );
  }

  Widget inputProvinsi() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Provinsi",
        items: widget.listProvinsi,
        onChanged: (value) {
          if (value != null) {
            namaProvinsi = value["name"];
            idProvinsi = value["id"];
            getKota(value['id']);
          } else {
            namaProvinsi = null;
            idProvinsi = null;
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['name'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaProvinsi ?? "Nama Provinsi belum Dipilih"),
        validator: (value) {
          if (value == "Nama Provinsi belum Dipilih") {
            return "Provinsi masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputKota() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Kab / Kota",
        items: listKota,
        onChanged: (value) {
          if (value != null) {
            namaKota = value["name"];
            idKota = value["id"];
            getKec(value['id']);
          } else {
            namaKota = null;
            idKota = null;
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['name'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaKota ?? "Nama Kota belum Dipilih"),
        validator: (value) {
          if (value == "Nama Kota belum Dipilih") {
            return "Kota masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputKec() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Kecamatan",
        items: listKec,
        onChanged: (value) {
          if (value != null) {
            namaKec = value["name"];
            idKec = value["id"];
            getKel(value["id"]);
          } else {
            namaKec = null;
            idKec = null;
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['name'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaKec ?? "Nama Kecamatan belum Dipilih"),
        validator: (value) {
          if (value == "Nama Kecamatan belum Dipilih") {
            return "Kecamatan masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputKel() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Kelurahan",
        items: listKel,
        onChanged: (value) {
          if (value != null) {
            namaKel = value["name"];
            idKel = value["id"];
          } else {
            namaKel = null;
            idKel = null;
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['name'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaKel ?? "Nama Kelurahan belum Dipilih"),
        validator: (value) {
          if (value == "Nama Kelurahan belum Dipilih") {
            return "Kelurahan masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputKodePos() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Kode Pos'),
      onChanged: (value) {
        kodePos = value;
      },
      initialValue: kodePos,
      validator: (value) {
        if (value.isEmpty) {
          return "Kode Pos masih kosong !";
        }
      },
    );
  }

  Widget inputKaryawanLevel() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Level Karyawan",
        mode: Mode.MENU,
        items: const ["Honor", "Kontrak", "Tetap"],
        onChanged: (value) {
          if (value == "Tetap") {
            setState(() {
              enableKontrak = true;
            });
            karyawanLevel = value;
          } else {
            setState(() {
              enableKontrak = false;
            });
            karyawanLevel = value;
          }
        },
        selectedItem: karyawanLevel ?? "Pilih Level Karyawan",
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Level Karyawan") {
            return "Level Karyawan masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputLama() {
    return TextFormField(
      readOnly: enableKontrak,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Masa Kerja', hintText: '6 Bulan / 1 Tahun'),
      onChanged: (value) {
        masaKerja = value;
      },
    );
  }

  Widget inputKantor() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Nama Kantor",
        mode: Mode.MENU,
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
        onChanged: (value) {
          kantor = value;
        },
        selectedItem: kantor ?? "Pilih Kantor",
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Kantor") {
            return "Kantor masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputNamaAyah() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Nama Ayah'),
      onChanged: (value) {
        namaAyah = value;
      },
      initialValue: namaAyah,
    );
  }

  Widget inputTelp() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Telepon', hintText: "08xxxxxxxxxxx"),
      onChanged: (value) {
        noTelp = value;
      },
      initialValue: noTelp,
    );
  }

  Widget inputMenikah() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Status Menikah",
        mode: Mode.MENU,
        items: const ["Single", "Menikah", "Duda / Janda"],
        onChanged: (value) {
          menikah = value;
        },
        selectedItem: menikah ?? "Pilih Status Menikah",
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Status Menikah") {
            return "Status menikah masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputPendidikan() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Pendidikan Terakhir",
        mode: Mode.MENU,
        items: const [
          "TK / PAUD",
          "SD/MI Sederajat",
          "SMP/Mts Sederajat",
          "SMA/MA Sederajat",
          "D1 / Sederajat",
          "D2 / Sederajat",
          "D3 / Sederajat",
          "D4/S1 Sederajat",
          "S2 / Sederajat",
          "S3 / Sederajat"
        ],
        onChanged: (value) {
          pendidikan = value;
        },
        selectedItem: pendidikan ?? "Pilih Pendidikan Terakhir",
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
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

  // Widget inputPekerjaan() {
  //   return Container(
  //     height: 50,
  //     decoration: const BoxDecoration(
  //         border: Border(
  //             bottom: BorderSide(
  //                 style: BorderStyle.solid, color: Colors.black, width: 0.4))),
  //     child: DropdownSearch(
  //       label: "Pekerjaan",
  //       mode: Mode.MENU,
  //       items: const [
  //         "PNS",
  //         "Pegawai Swasta",
  //         "TNI/POLRI",
  //         "Petani",
  //         "Nelayan",
  //         "Wirausaha",
  //         "Ibu Rumah Tangga",
  //         "Tidak Bekerja",
  //         "Lainnya",
  //       ],
  //       onChanged: (value) {
  //         pekerjaan = value;
  //       },
  //       selectedItem: pekerjaan ?? "Pilih Pekerjaan",
  //       dropdownSearchDecoration:
  //           const InputDecoration(border: InputBorder.none),
  //     ),
  //   );
  // }

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
        items: const ["Ada", "Belum Ada"],
        onChanged: (value) {
          if (value == "Ada") {
            paspor = value;
            cekpaspor = 'a';
          } else {
            paspor = value;
            cekpaspor = 'n';
          }
        },
        selectedItem: paspor ?? "Pilih Status Paspor",
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputNoPaspor() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Nomor Paspor'),
      onChanged: (value) {
        noPaspor = value;
      },
      initialValue: noPaspor,
    );
  }

  Widget inputPasporKeluar() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Dikeluarkan di'),
      onChanged: (value) {
        dikeluarkanDi = value;
      },
      initialValue: dikeluarkanDi,
    );
  }

  Widget inputTglKeluar() {
    return TextField(
      controller: dateKeluar,
      decoration: const InputDecoration(
        labelText: 'Tanggal Dikeluarkan',
      ),
      onChanged: (String value) {
        tglKeluar = value;
      },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateKeluar.text = formattedDate;
        }
      },
    );
  }

  Widget inputTglExp() {
    return TextField(
      controller: dateExp,
      decoration: const InputDecoration(
        labelText: 'Berlaku Hingga',
      ),
      onChanged: (String value) {
        tglExpire = value;
      },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateExp.text = formattedDate;
        }
      },
    );
  }

  fncSaveData() {
    var obj = [
      {
        "id_karyawan": fncGetID(namaKaryawan, dateLahir.text),
        "identitas": nik,
        "status_aktif": "a",
        "fee_level": karyawanLevel,
        "first_level": 'Raudhah',
        "periode_pelanggan": 0,
        "total_pelanggan": 0,
        "poin": 0,
        "id_leader": "02KUS260860001",
        "id_karyawankategori": "MK0000000001",
        "bank_validation": "n",
        "dated": "000000000072",
        "userd": "U00000000001",
        "id_kantor": kantor,
        "id_operasional": "000000000072",
        "nama_lengkap": namaKaryawan,
        "jenis_kelamin": jenisKelamin,
        "tempat_lahir": tempatLahir,
        "tanggal_lahir": dateLahir.text.replaceAll('-', ''),
        "alamat": alamat,
        "kelurahan": namaKel,
        "kecamatan": namaKec,
        "kabupaten": namaKota,
        "provinsi": namaProvinsi,
        "kodepos": kodePos,
        "telepon": noTelp,
        "status_menikah": menikah,
        "pendidikan_terakhir": pendidikan,
        "pekerjaan": pekerjaan,
        "an_paspor": paspor,
        "out_paspor": dateKeluar.text,
        "expr_paspor": dateExp.text,
        "nomor_rekening": 7750785527,
        "kode_bank": "014",
        "an_rekening": "Kusdiyantini Rokhmulyati",
        "date_create": "2018-04-18 10:21:15",
        "user_create": "U00000000001",
        "date_update": "0000-00-00 00:00:00",
        "an_identitas": "a",
        "mr_alamat": alamat,
        "mr_kelurahan": namaKel,
        "mr_kecamatan": namaKec,
        "mr_kabupaten": namaKota,
        "mr_provinsi": namaProvinsi,
        "nama_leader": "Kusdiyantini Rokhmulyati",
        "nama_parent": "-",
        "userna": "Pujan Daniar",
        "nama_kantor": kantor,
        "mk": karyawanLevel,
        "state": "open",
        "ide_marketing": "Kusdiyantini Rokhmulyati|W|open",
        "level": "Raudhah",
        "sa": "MR",
        "tgl_lahir": fncGetTanggal(dateLahir.text),
        "tanggal_gabung": "31-08-2022 — 00:00",
        "nomor": 264,
        "masa_kerja": masaKerja ?? '-',
      }
    ];

    dummyKaryawanTable.addAll(obj);
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Karyawan');
    navigationController.navigateTo('/mrkt/karyawan');
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final screenHeight = MediaQuery.of(context).size.height;

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
                      'Tambah Data Baru',
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
                  if (formKey.currentState.validate()) {
                    fncSaveData();
                  } else {
                    return null;
                  }
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
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  menuController.changeActiveitemTo('Karyawan');
                  navigationController.navigateTo('/mrkt/karyawan');
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
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 0.47 * screenHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
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
                              inputNIK(),
                              const SizedBox(height: 8),
                              inputNama(),
                              const SizedBox(height: 8),
                              inputJenisKelamin(),
                              const SizedBox(height: 8),
                              inputTempatLahir(),
                              const SizedBox(height: 8),
                              inputTglLahir(),
                              const SizedBox(height: 8),
                              inputTelp(),
                              const SizedBox(height: 8),
                              inputAlamat(),
                              const SizedBox(height: 8),
                              inputProvinsi(),
                              const SizedBox(height: 8),
                              inputKota(),
                              const SizedBox(height: 8),
                              inputKec(),
                              const SizedBox(height: 8),
                              inputKel(),
                              const SizedBox(height: 8),
                              inputKodePos(),
                              const SizedBox(height: 8),
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
                              inputKaryawanLevel(),
                              const SizedBox(height: 8),
                              inputLama(),
                              const SizedBox(height: 8),
                              inputKantor(),
                              const SizedBox(height: 8),
                              inputNamaAyah(),
                              const SizedBox(height: 8),
                              inputMenikah(),
                              const SizedBox(height: 8),
                              inputPendidikan(),
                              const SizedBox(height: 8),
                              // inputPekerjaan(),
                              // const SizedBox(height: 8),
                              inputPaspor(),
                              const SizedBox(height: 8),
                              inputNoPaspor(),
                              const SizedBox(height: 8),
                              inputPasporKeluar(),
                              const SizedBox(height: 8),
                              inputTglKeluar(),
                              const SizedBox(height: 8),
                              inputTglExp(),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  SizedBox(width: 300, child: inputRouteFile()),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        // showDialog(
                                        //     context: context,
                                        //     builder: (context) =>
                                        //         const ModalUploadDokumen());
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
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
