// ignore: undefined_prefixed_name
// ignore_for_file: unused_import, avoid_print, missing_return

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/authentication/table_jadwal.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/card_paket.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/not_find_widget.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/responsive_widget.dart';
import 'package:flutter_web_course/routing/routes.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_course/models/http_stateful.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthenticationPage extends ResponsiveWidget {
  const AuthenticationPage({Key key}) : super(key: key);

  @override
  Widget buildDesktop(BuildContext context) =>
      const DesktopAuthenticationPage();

  @override
  Widget buildMobile(BuildContext context) => const MobileAuthenticationPage();
}

class DesktopAuthenticationPage extends StatefulWidget {
  const DesktopAuthenticationPage({Key key}) : super(key: key);

  @override
  State<DesktopAuthenticationPage> createState() =>
      _DesktopAuthenticationPageState();
}

class _DesktopAuthenticationPageState extends State<DesktopAuthenticationPage> {
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPass = TextEditingController();

  List<Map<String, dynamic>> listJadwal = [];

  bool show = true;
  bool _isHidePassword = true;
  bool showContiner = true;

  double widthScreen = 1;

  FocusNode nodeFirst = FocusNode();
  FocusNode nodeSecond = FocusNode();

  HttpStateful loginRespon = HttpStateful();

  void getAllJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getAllJadwalDash"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = data;
    });
  }

  @override
  void initState() {
    getAllJadwal();
    super.initState();
  }

  void hideToggleClick() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  void setWidthScreen() {
    setState(() {
      if (widthScreen == 1) {
        widthScreen = 0.7;
        show = false;
        showContiner = false;
      } else {
        widthScreen = 1;
        show = true;
        showContiner = true;
      }
    });
  }

  Widget infoBadge() {
    return Container(
      width: 600,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(189, 231, 231, 231)),
            height: 130,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '** Harga dapat berubah sewaktu waktu',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                          dividerColor: const Color.fromARGB(0, 255, 193, 7)),
                      child: DataTable(
                          headingRowHeight: 0,
                          horizontalMargin: 2,
                          dataRowHeight: 20,
                          dataTextStyle: const TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold),
                          columns: const [
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                          ],
                          rows: const [
                            DataRow(cells: [
                              DataCell(Text('Harga belum termasuk :')),
                              DataCell(Text('* Handling Rp. 1,600,000')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('')),
                              DataCell(Text(
                                  '* Paspor Rp. 1,000,000 (Apabila Kolektif Di Kantor)')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('')),
                              DataCell(Text('* Keperluan Pribadi')),
                            ]),
                          ]),
                    ),
                    SizedBox(
                      width: 570,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'Telp / WA : 081-222-700-300',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  fncLogin(formKey) {
    if (formKey.currentState.validate()) {
      HttpStateful.connectAPI(_userEmail.text, _userPass.text, "01").then(
        (value) async {
          setState(() {
            loginRespon = value;
            kodeToken = loginRespon.userToken;
            namaUser = loginRespon.namaUser;
            username = loginRespon.username;
            fotoUser = loginRespon.fotoUser;
            kodeAgen = loginRespon.kodeAgen;
          });

          print(loginRespon.userToken);

          if (loginRespon.status == true) {
            Get.offAllNamed(rootRoute);
          } else {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: Stack(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: 300,
                          height: 400,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                width: 200,
                                fit: BoxFit.cover,
                                image: AssetImage('images/hero-alert-fail.png'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const FittedBox(
                                child: Text('Kamu Gagal Login Nih!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const FittedBox(
                                child: Text(
                                    'Periksa kembali username dan password mu dengan benar',
                                    style: TextStyle(fontSize: 10)),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _userEmail.clear();
                                    _userPass.clear();
                                    nodeFirst.requestFocus();
                                  },
                                  child: const Text('Kembali'))
                            ],
                          ),
                        )
                      ]),
                    ));
          }
        },
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Row(
                children: [
                  Flexible(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: screenHeight,
                          width: screenWidth,
                          child: const Image(
                            width: 1000,
                            fit: BoxFit.cover,
                            image: AssetImage('images/frame-login.png'),
                          ),
                        ),
                        Container(
                          height: screenHeight,
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  SizedBox(
                                    height: 70,
                                    child: Image(
                                        image: AssetImage(
                                            'images/logo-frame-login.png')),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: screenHeight,
                          width: screenWidth,
                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    width: 300,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setWidthScreen();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: 100,
                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          'Masuk',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              TableJadwalDashboard(
                                  dataJadwal: listJadwal, show: show),
                              const SizedBox(height: 10),
                              showContiner == true
                                  ? Row(
                                      children: [
                                        const Expanded(
                                            child: SizedBox(
                                          child: Align(
                                            child: Image(
                                              width: 250,
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'images/legalitas-1.png'),
                                            ),
                                          ),
                                        )),
                                        infoBadge(),
                                        const Expanded(
                                            child: SizedBox(
                                          child: Align(
                                            child: Image(
                                              width: 250,
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'images/legalitas-2.png'),
                                            ),
                                          ),
                                        )),
                                      ],
                                    )
                                  : Align(
                                      child: infoBadge(),
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  showContiner != true
                      ? Container(
                          width: screenWidth * 0.3,
                          height: screenHeight,
                          color: Colors.white,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            show != true
                ? SizedBox(
                    width: screenWidth,
                    height: screenHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
                          constraints: const BoxConstraints(maxWidth: 500),
                          width: screenWidth * 0.3,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Image(
                                  width: 170,
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'images/logo_craudhah_pot.png'),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                    'Memberikan pengalaman Haji dan Umroh terbaik yang akan anda rasakan',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                    )),
                                const SizedBox(height: 25),
                                TextFormField(
                                  focusNode: nodeFirst,
                                  controller: _userEmail,
                                  style: const TextStyle(color: Colors.black),
                                  cursorColor: Colors.grey,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Email masih kosong !";
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      labelText: "Masukan Username",
                                      suffixIcon: Icon(
                                        Icons.assignment_ind,
                                        color: Colors.grey,
                                      ),
                                      hintText: 'usernameku'),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  cursorColor: Colors.grey,
                                  focusNode: nodeSecond,
                                  controller: _userPass,
                                  obscureText: _isHidePassword,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Password masih kosong !";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Masukan Password",
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          hideToggleClick();
                                        },
                                        child: Icon(
                                          _isHidePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: _isHidePassword
                                              ? Colors.grey
                                              : Colors.blue,
                                        ),
                                      ),
                                      hintText: 'passwordku'),
                                  onFieldSubmitted: (value) {
                                    fncLogin(formKey);
                                  },
                                ),
                                const SizedBox(
                                  height: 70,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    fncLogin(formKey);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: screenWidth * 0.72,
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        'Masuk Sekarang',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox()
          ]),
        ));
  }
}

class MobileAuthenticationPage extends StatefulWidget {
  const MobileAuthenticationPage({Key key}) : super(key: key);

  @override
  State<MobileAuthenticationPage> createState() =>
      _MobileAuthenticationPageState();
}

class _MobileAuthenticationPageState extends State<MobileAuthenticationPage> {
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPass = TextEditingController();

  bool _isHidePassword = true;

  HttpStateful loginRespon = HttpStateful();

  void hideToggleClick() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  fncLogin(formKey) {
    if (formKey.currentState.validate()) {
      HttpStateful.connectAPI(_userEmail.text, _userPass.text, "01").then(
        (value) async {
          setState(() {
            loginRespon = value;
            kodeToken = loginRespon.userToken;
            namaUser = loginRespon.namaUser;
            username = loginRespon.username;
            fotoUser = loginRespon.fotoUser;
            kodeAgen = loginRespon.kodeAgen;
          });

          print(loginRespon.userToken);
          if (loginRespon.status == true) {
            Get.offAllNamed(rootRoute);
          } else {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: Stack(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: 300,
                          height: 400,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                width: 200,
                                fit: BoxFit.cover,
                                image: AssetImage('images/hero-alert-fail.png'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const FittedBox(
                                child: Text('Kamu Gagal Login Nih!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const FittedBox(
                                child: Text(
                                    'Periksa kembali username dan password mu dengan benar',
                                    style: TextStyle(fontSize: 10)),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _userEmail.clear();
                                    _userPass.clear();
                                  },
                                  child: const Text('Kembali'))
                            ],
                          ),
                        )
                      ]),
                    ));
          }
        },
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();

    return Column(
      children: [
        SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: screenWidth,
                  height: screenHeight,
                  child: const Image(
                    width: 1000,
                    fit: BoxFit.cover,
                    image: AssetImage('images/frame-login.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: const Image(
                          image: AssetImage('images/logo-frame-login.png')),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
                      constraints: const BoxConstraints(maxWidth: 500),
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Image(
                              width: 170,
                              fit: BoxFit.cover,
                              image: AssetImage('images/logo_craudhah_pot.png'),
                            ),
                            const Text(
                                'Memberikan pengalaman Haji dan Umroh terbaiak yang akan anda rasakan',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                )),
                            const SizedBox(height: 25),
                            TextFormField(
                              controller: _userEmail,
                              style: const TextStyle(color: Colors.black),
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Email masih kosong !";
                                }
                              },
                              decoration: const InputDecoration(
                                  labelText: "Masukan Username",
                                  suffixIcon: Icon(
                                    Icons.assignment_ind,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'usernameku'),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              cursorColor: Colors.grey,
                              controller: _userPass,
                              obscureText: _isHidePassword,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Password masih kosong !";
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "Masukan Password",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      hideToggleClick();
                                    },
                                    child: Icon(
                                      _isHidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: _isHidePassword
                                          ? Colors.grey
                                          : Colors.blue,
                                    ),
                                  ),
                                  hintText: 'passwordku'),
                              onFieldSubmitted: (value) {
                                fncLogin(formKey);
                              },
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                fncLogin(formKey);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: screenWidth * 0.72,
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    'Masuk Sekarang',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ],
    );
  }
}
