// ignore_for_file: missing_return, prefer_const_constructors, unnecessary_const
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/models/http_stateful.dart';
import 'package:flutter_web_course/pages/authentication/table_jadwal.dart';
import 'package:flutter_web_course/routing/routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPass = TextEditingController();

  List<Map<String, dynamic>> listJadwal = [];

  bool _isHidePassword = true;

  double widthScreen = 1;
  bool show = true;
  bool showContiner = true;

  FocusNode nodeFirst = FocusNode();
  FocusNode nodeSecond = FocusNode();

  HttpStateful loginRespon = HttpStateful();

  void hideToggleClick() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  void getAllJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getAllJadwalDash"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = data;
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

  fncLogin(formKey) {
    if (formKey.currentState.validate()) {
      HttpStateful.connectAPI(_userEmail.text, _userPass.text, "01").then(
        (value) {
          setState(() {
            loginRespon = value;
            kodeToken = loginRespon.userToken;
            namaUser = loginRespon.namaUser;
            username = loginRespon.username;
            fotoUser = loginRespon.fotoUser;
          });
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
  void initState() {
    // getProvinsi();
    getAllJadwal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
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
                        width:
                            screenWidth * (screenWidth > 900 ? widthScreen : 1),
                        child: const Image(
                          width: 1000,
                          fit: BoxFit.cover,
                          image: AssetImage('images/hero-login-new-2.png'),
                          opacity: const AlwaysStoppedAnimation(0.7),
                        ),
                      ),
                      // Container(
                      //   height: screenHeight,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         // ignore: prefer_const_literals_to_create_immutables
                      //         children: [
                      //           Container(
                      //             color: Colors.amber,
                      //             width: 300,
                      //             height: 200,
                      //           )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        height: screenHeight,
                        padding: (screenWidth > 900
                            ? const EdgeInsets.fromLTRB(0, 10, 0, 10)
                            : const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: const Image(
                                      image: AssetImage(
                                          'images/logo_craudhah_depan.png')),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: screenHeight,
                        width:
                            screenWidth * (screenWidth > 900 ? widthScreen : 1),
                        padding: (screenWidth > 900
                            ? const EdgeInsets.fromLTRB(10, 10, 20, 10)
                            : const EdgeInsets.fromLTRB(30, 20, 30, 10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
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
                            SizedBox(
                              height: 160,
                            ),
                            TableJadwalDashboard(
                                dataJadwal: listJadwal, show: show),
                            SizedBox(height: 10),
                            Align(
                              child: Container(
                                width: 600,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              143, 231, 231, 231)),
                                      // width: show == true
                                      //     ? screenWidth * 0.87
                                      //     : screenWidth * 0.63,
                                      // width: screenWidth,
                                      height: 130,
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '** Harga dapat berubah sewaktu waktu',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                              Theme(
                                                data: Theme.of(context)
                                                    .copyWith(
                                                        dividerColor:
                                                            Color.fromARGB(0,
                                                                255, 193, 7)),
                                                child: DataTable(
                                                    headingRowHeight: 0,
                                                    horizontalMargin: 2,
                                                    dataRowHeight: 20,
                                                    dataTextStyle: TextStyle(
                                                        fontFamily: 'Gilroy',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    columns: const [
                                                      DataColumn(
                                                          label: Text('')),
                                                      DataColumn(
                                                          label: Text('')),
                                                    ],
                                                    rows: const [
                                                      DataRow(cells: [
                                                        DataCell(Text(
                                                            'Harga belum termasuk :')),
                                                        DataCell(Text(
                                                            '* Handling Rp. 1,600,000')),
                                                      ]),
                                                      DataRow(cells: [
                                                        DataCell(Text('')),
                                                        DataCell(Text(
                                                            '* Paspor Rp. 1,000,000 (Apabila Kolektif Di Kantor)')),
                                                      ]),
                                                      DataRow(cells: [
                                                        DataCell(Text('')),
                                                        DataCell(Text(
                                                            '* Keperluan Pribadi')),
                                                      ]),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 570,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: const [
                                                    Text(
                                                      'Telp / WA : 081-222-700-300',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Expanded(
                                          //   child: Column(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.start,
                                          //     crossAxisAlignment:
                                          //         CrossAxisAlignment.end,
                                          //     children: const [
                                          //       Text(
                                          //         'Telp / WA : 081-222-700-300',
                                          //         style: TextStyle(
                                          //             fontWeight:
                                          //                 FontWeight.bold),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
                  showContiner != true
                      ? Container(
                          width: screenWidth * (screenWidth > 900 ? 0.3 : 0),
                          height: screenHeight,
                          color: Colors.white,
                        )
                      : SizedBox(),
                ],
              ),
            ),
            show != true
                ? SizedBox(
                    width: screenWidth,
                    height: screenHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: (screenWidth > 900
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.center),
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
                          constraints: const BoxConstraints(maxWidth: 500),
                          // height: screenHeight * (screenWidth > 900 ? 1 : 0.7),
                          width: screenWidth * (screenWidth > 900 ? 0.3 : 0.9),
                          decoration: (screenWidth > 900
                              ? const BoxDecoration()
                              : BoxDecoration(
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
                                )),
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
                                // const SizedBox(height: 10),
                                // const Text('Cahaya Raudhah',
                                //     style: TextStyle(
                                //         fontSize: 16,
                                //         fontFamily: 'Cinzel Decorative')),
                                // const Text(
                                //     'Memberikan pengalaman Haji dan Umroh terbaik yang akan anda rasakan',
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //       fontSize: 11,
                                //     )),
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
                                // const SizedBox(
                                //   height: 15,
                                // ),
                                // Container(
                                //   width: screenWidth,
                                //   padding: const EdgeInsets.only(left: 5),
                                //   child: Row(
                                //     children: [
                                //       Checkbox(value: true, onChanged: (value) {}),
                                //       const Text('Remember Me')
                                //     ],
                                //   ),
                                // ),
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
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
