// ignore_for_file: deprecated_member_use, missing_return

import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class ModalEditJamaah extends StatefulWidget {
  final List<Map<String, dynamic>> listProvinsi;

  const ModalEditJamaah({
    Key key,
    @required this.listProvinsi,
  }) : super(key: key);

  @override
  State<ModalEditJamaah> createState() => _ModalEditJamaahState();
}

class _ModalEditJamaahState extends State<ModalEditJamaah> {
  String tglEstimasi;
  String idProvinsi;
  String namaProvinsi;
  String idKota;
  String namaKota;
  String idKec;
  String namaKec;
  String idKel;
  String namaKel;
  String tglKeluar;
  String tglExpire;

  List<Map<String, dynamic>> listProvinsi = [];
  List<Map<String, dynamic>> listKota = [];
  List<Map<String, dynamic>> listKec = [];
  List<Map<String, dynamic>> listKel = [];

  TextEditingController dateTgl = TextEditingController();
  TextEditingController dateKeluar = TextEditingController();
  TextEditingController dateExp = TextEditingController();

  void getProvinsi() async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listProvinsi = dataStatus;
    });
  }

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

  @override
  void initState() {
    // getProvinsi();
    super.initState();
  }

  Widget inputNIK() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'NIK',
          hintText: '32xxxxxxxxxxx',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: "32750119288821",
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
      decoration: const InputDecoration(
          labelText: 'Nama Lengkap',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: "Alfi Gunawan S.pd Lc,MA",
      validator: (value) {
        if (value.isEmpty) {
          return "Nama masih kosong !";
        }
      },
    );
    // return TextFormField(
    //   initialValue: 'Alfi Gunawan S.pd Lc,MA',
    //   style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
    //   decoration: const InputDecoration(
    //       border: OutlineInputBorder(), labelText: 'Nama Lengkap'),
    // );
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
        // onChanged: (value) {
        //   if (value == "Pria") {
        //     jenisKelamin = 'P';
        //     jk = value;
        //   } else {
        //     jenisKelamin = 'W';
        //     jk = value;
        //   }
        // },
        // selectedItem: jk ?? "Pilih Jenis Kelamin",
        dropdownSearchDecoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
        ),
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
      decoration: const InputDecoration(
          labelText: 'Tempat Lahir',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      // onChanged: (value) {
      //   tempatLahir = value;
      // },
      initialValue: "Subang",
      validator: (value) {
        if (value.isEmpty) {
          return "Tempat lahir masih kosong !";
        }
      },
    );
  }

  Widget inputTglLahir() {
    return TextFormField(
      controller: dateTgl,
      decoration: const InputDecoration(
          labelText: 'Tanggal Lahir', filled: true, fillColor: Colors.white),
      // onChanged: (String value) {
      //   tglLahir = value;
      // },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          dateTgl.text = formattedDate;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tgl Lahir masih kosong !";
        }
      },
    );
  }

  Widget inputAlamat() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Alamat', filled: true, fillColor: Colors.white),
      // onChanged: (value) {
      //   alamat = value;
      // },
      initialValue: "Kp. Rawa Aren, Bekasi Timur",
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
            if (value == null) {
              return "Provinsi masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
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
            if (value == null) {
              return "Kota masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, fillColor: Colors.white, filled: true)),
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
            if (value == null) {
              return "Kecamatan masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
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
            if (value == null) {
              return "Kelurahan masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
    );
  }

  Widget inputKodePos() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Kode Pos',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      // onChanged: (value) {
      //   kodePos = value;
      // },
      initialValue: "17139",
      validator: (value) {
        if (value.isEmpty) {
          return "Kode Pos masih kosong !";
        }
      },
    );
  }

  Widget inputNamaAyah() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Nama Ayah',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      // onChanged: (value) {
      //   namaAyah = value;
      // },
      initialValue: "Kohir",
    );
  }

  Widget inputTelp() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Telepon',
          hintText: "08xxxxxxxxxxx",
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      // onChanged: (value) {
      //   noTelp = value;
      // },
      initialValue: "08828817388127",
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
        // onChanged: (value) {
        //   menikah = value;
        // },
        selectedItem: "Pilih Status Menikah",
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
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
        // onChanged: (value) {
        //   pendidikan = value;
        // },
        selectedItem: "Pilih Pendidikan Terakhir",
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
        validator: (value) {
          if (value == "Pilih Pendidikan") {
            return "Status pendidikan masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputPekerjaan() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Pekerjaan",
        mode: Mode.MENU,
        items: const [
          "PNS",
          "Pegawai Swasta",
          "TNI/POLRI",
          "Petani",
          "Nelayan",
          "Wirausaha",
          "Ibu Rumah Tangga",
          "Tidak Bekerja",
          "Lainnya",
        ],
        // onChanged: (value) {
        //   pekerjaan = value;
        // },
        selectedItem: "Pilih Pekerjaan",
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
        validator: (value) {
          if (value == "Pilih Pekerjaan") {
            return "Pekerjaan masih kosong !";
          }
        },
      ),
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
        items: const ["Ada", "Belum Ada"],
        // onChanged: (value) {
        //   if (value == "Ada") {
        //     paspor = 'a';
        //     cekpaspor = 'Ada';
        //   } else {
        //     paspor = 'n';
        //     cekpaspor = 'Belum Ada';
        //   }
        // },
        selectedItem: "Pilih Status Paspor",
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
        validator: (value) {
          if (value == "Pilih Status Paspor") {
            return "Status paspor masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputNoPaspor() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Nomor Paspor',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: "3777400000131",
    );
  }

  Widget inputPasporKeluar() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Dikeluarkan di',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: "Bandung",
    );
  }

  Widget inputTglKeluar() {
    return TextField(
      controller: dateKeluar,
      decoration: const InputDecoration(
          labelText: 'Tanggal Dikeluarkan',
          filled: true,
          fillColor: Colors.white),
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
        filled: true,
        fillColor: Colors.white,
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
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Data Jamaah');
    navigationController.navigateTo('/jamaah/master');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.81,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('Ubah Data Identitas',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 530,
                            child: Column(
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
                                inputAlamat(),
                                const SizedBox(height: 8),
                                inputProvinsi(),
                                const SizedBox(height: 8),
                                inputKota(),
                                const SizedBox(height: 8),
                                inputKec(),
                                const SizedBox(height: 8),
                                inputKel(),
                                const SizedBox(height: 65),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            width: 530,
                            child: Column(
                              children: [
                                inputKodePos(),
                                const SizedBox(height: 8),
                                inputNamaAyah(),
                                const SizedBox(height: 8),
                                inputTelp(),
                                const SizedBox(height: 8),
                                inputMenikah(),
                                const SizedBox(height: 8),
                                inputPendidikan(),
                                const SizedBox(height: 8),
                                inputPekerjaan(),
                                const SizedBox(height: 8),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                          shadowColor: Colors.grey,
                          elevation: 5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Kembali'))
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
