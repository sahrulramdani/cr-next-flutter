// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print

import 'dart:convert';
import 'package:flutter_web_course/models/http_pengguna.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalEditPengguna extends StatefulWidget {
  final String idPengguna;
  final String namaPengguna;
  const ModalEditPengguna({
    Key key,
    @required this.idPengguna,
    @required this.namaPengguna,
  }) : super(key: key);

  @override
  State<ModalEditPengguna> createState() => _ModalEditPenggunaState();
}

class _ModalEditPenggunaState extends State<ModalEditPengguna> {
  List<Map<String, dynamic>> listGrupUser = [];
  List<Map<String, dynamic>> listKantor = [];
  List<Map<String, dynamic>> listAgency = [];
  List<Map<String, dynamic>> listKategoriUser = [];
  String username;
  String namaPengguna;
  String idKategori;
  String namaKategori;
  String idAgen;
  String namaAgen;
  String password1;
  String password2;
  String namaKantor;
  String idKantor;
  String idGrup;
  String namaGrup;
  String email;
  bool _isHidePassword = true;
  String status;
  bool enableAgency = false;

  String fotoUser = "";
  String fotoUserBase = "";
  Uint8List fotoUserByte;
  String fotoLamaUser = "";

  void getGrupUser() async {
    var response =
        await http.get(Uri.parse("$urlAddress/menu/grup-user/all"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listGrupUser = data;
    });
  }

  void getKantor() async {
    var response =
        await http.get(Uri.parse("$urlAddress/hr/kantor-all"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listKantor = data;
    });
  }

  void getKategoriUser() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/kategori-akun"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listKategoriUser = data;
    });
  }

  void getAgen() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/all-agency"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listAgency = data;
    });
  }

  void getDetailPengguna() async {
    var id = widget.idPengguna;
    var response = await http.get(
        Uri.parse("$urlAddress/menu/daftar-pengguna/detail/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      username = data[0]['USER_IDXX'];
      password1 = data[0]['PASS_IDXX'];
      idKantor = data[0]['UNIT_KNTR'];
      namaKantor = data[0]['NAMA_KNTR'];
      idGrup = data[0]['KDXX_GRUP'];
      namaPengguna = data[0]['KETX_USER'];
      namaGrup = data[0]['NAMA_GRUP'];
      email = data[0]['EMAIL'];
      fotoUser = data[0]['NAMA_FILE'] ?? '';
      fotoLamaUser = data[0]['NAMA_FILE'] ?? '';
      idKategori = data[0]['KATX_USER'] ?? '';
      namaKategori = data[0]['KAT_USER'] ?? '';
      idAgen = data[0]['KDXX_MRKT'] == '' ? null : data[0]['KDXX_MRKT'];
      namaAgen = data[0]['NAMA_AGEN'];
      if (data[0]['KATX_USER'] == '5803') {
        enableAgency = true;
      }
      status = data[0]['ACTIVE'] == '1' ? 'Aktif' : 'Tidak Aktif';
    });
  }

  @override
  void initState() {
    getGrupUser();
    getKantor();
    getKategoriUser();
    getAgen();
    getDetailPengguna();
    super.initState();
  }

  hideToggleClick() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  Widget inputUsername() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
        labelText: 'Username',
      ),
      readOnly: true,
      onChanged: ((value) {
        username = value;
      }),
      initialValue: username ?? '',
      validator: (value) {
        if (value.isEmpty) {
          return "Username masih kosong !";
        }
      },
    );
  }

  Widget inputPassword() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
        labelText: 'Password',
        suffixIcon: GestureDetector(
          onTap: () {
            // hideToggleClick();
          },
          child: Icon(
            _isHidePassword ? Icons.visibility_off : Icons.visibility,
            color: _isHidePassword ? Colors.grey : Colors.blue,
          ),
        ),
      ),
      onChanged: ((value) {
        password1 = value;
      }),
      initialValue: password1 ?? '',
      obscureText: _isHidePassword,
      validator: (value) {
        if (value.isEmpty) {
          return "Password masih kosong !";
        }
      },
    );
  }

  Widget inputKategori() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Kategori User",
        items: listKategoriUser,
        onChanged: (value) {
          setState(() {
            idKategori = value['CODD_VALU'];
            namaKategori = value['CODD_DESC'];
            if (value['CODD_DESC'] == 'Marketing') {
              enableAgency = true;
            } else {
              enableAgency = false;
              idAgen = null;
              namaAgen = null;
              namaPengguna = null;
            }
          });
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaKategori ?? "Kategori User belum Dipilih"),
        dropdownSearchDecoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
        ),
      ),
    );
  }

  Widget inputNamaAgen() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Nama Marketing",
          items: listAgency,
          onChanged: (value) {
            setState(() {
              if (value != null) {
                idAgen = value["KDXX_MRKT"];
                namaAgen = value["NAMA_LGKP"];
                namaPengguna = value['NAMA_LGKP'];
              } else {
                idAgen = null;
                namaAgen = null;
                namaPengguna = null;
              }
            });
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_LGKP'].toString()),
                leading: CircleAvatar(
                  backgroundImage: item['FOTO_AGEN'] != ""
                      ? NetworkImage(
                          '$urlAddress/uploads/foto/${item['FOTO_AGEN']}')
                      : const AssetImage('assets/images/box-background.png'),
                ),
                subtitle: Text(item['KDXX_MRKT'].toString()),
                trailing: Text(
                    DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(item['TGLX_LHIR'].toString())),
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaAgen ?? "Marketing belum Dipilih"),
          dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hoverColor: Colors.white,
          )),
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
        dropdownBuilder: (context, selectedItem) => Text(
          namaKantor ?? "Pilih Kantor",
        ),
        validator: (value) {
          if (value == "Nama Kantor belum Dipilih") {
            return "Kantor masih kosong !";
          }
        },
        dropdownSearchDecoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
        ),
      ),
    );
  }

  Widget inputNamaPengguna() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
        labelText: 'Nama Pengguna',
      ),
      onChanged: ((value) {
        namaPengguna = value;
      }),
      initialValue: namaPengguna ?? '',
      validator: (value) {
        if (value.isEmpty) {
          return "Nama Pengguna masih kosong !";
        }
      },
    );
  }

  Widget inputEmail() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
          labelText: 'Email',
          hintText: 'youremail@email.com'),
      onChanged: ((value) {
        email = value;
      }),
      initialValue: email ?? '',
    );
  }

  Widget inputGrupUser() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Grup Akses Pengguna",
        mode: Mode.MENU,
        items: listGrupUser,
        onChanged: (value) {
          idGrup = value['KDXX_GRUP'];
          namaGrup = value['NAMA_GRUP'];
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_GRUP'] + ' - ' + item['KETERANGAN']),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaGrup ?? "Pilih Grup User"),
        dropdownSearchDecoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (namaGrup == null) {
            return "Grup User masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputStatusPengguna() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Status Pengguna",
        mode: Mode.MENU,
        items: const ["Aktif", "Tidak Aktif"],
        onChanged: (value) {
          if (value == "Aktif") {
            status = 'Aktif';
          } else {
            status = 'Tidak Aktif';
          }
        },
        selectedItem: status ?? "Pilih Status Pengguna",
        dropdownSearchDecoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == "Pilih Status Grup") {
            return "Status Grup masih kosong !";
          }
        },
      ),
    );
  }

  Widget resultFotoUser() {
    if (fotoUserByte != null) {
      return Image.memory(
        fotoUserByte,
        height: 80,
      );
    } else {
      if (fotoUser != "") {
        return Image(
          image: NetworkImage('$urlAddress/uploads/profil/$fotoUser'),
          height: 80,
        );
      } else {
        return const Image(
          image: AssetImage('assets/images/NO_IMAGE.jpg'),
          height: 80,
        );
      }
    }
  }

  Widget inputUploadUser() {
    return TextFormField(
      initialValue: fotoUser != "" ? fotoUser : "Pilih",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Upload Foto',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
    );
  }

  getImageUser() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoUser = fileResult.files.first.name;
        fotoUserByte = fileResult.files.first.bytes;
        fotoUserBase = encodeFoto;
      });
    }
  }

  fncSaveFoto() {
    HttpPengguna.updateFotoUser(
      username,
      fotoUserBase != '' ? fotoUserBase : 'TIDAK',
      fotoLamaUser,
    ).then(
      (value) {
        if (value.status == true) {
          fncSaveData(value.foto);
        } else {
          print('GAGAL UPLOAD FOTO');
        }
      },
    );
  }

  fncSaveData(namaFoto) {
    HttpPengguna.updatePengguna(
      username,
      password1,
      idKategori,
      idAgen ?? '',
      idKantor,
      namaPengguna,
      idGrup,
      email ?? '',
      namaFoto,
      status == 'Aktif' ? '1' : '0',
    ).then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());

        menuController.changeActiveitemTo('Daftar Pengguna');
        navigationController.navigateTo('/setting/daftar-pengguna');
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
    final formKey = GlobalKey<FormState>();
    int x = 1;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.75,
            height: 450,
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
                      Text('Edit Profil Pengguna ${widget.namaPengguna}',
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 480,
                          child: Column(
                            children: [
                              inputUsername(),
                              const SizedBox(height: 8),
                              inputPassword(),
                              const SizedBox(height: 8),
                              inputKategori(),
                              const SizedBox(height: 8),
                              Visibility(
                                visible: enableAgency,
                                child: Column(
                                  children: [
                                    inputNamaAgen(),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  resultFotoUser(),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 325, child: inputUploadUser()),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        getImageUser();
                                      },
                                      icon: const Icon(Icons.save),
                                      label: const Text(
                                        'Upload Foto',
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
                        const SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          width: 480,
                          child: Column(
                            children: [
                              inputNamaPengguna(),
                              const SizedBox(height: 8),
                              inputKantor(),
                              const SizedBox(height: 8),
                              inputGrupUser(),
                              const SizedBox(height: 8),
                              inputEmail(),
                              const SizedBox(height: 8),
                              inputStatusPengguna(),
                              const SizedBox(height: 30),
                              Visibility(
                                visible: enableAgency,
                                child: const SizedBox(height: 50),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            fncSaveFoto();
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
