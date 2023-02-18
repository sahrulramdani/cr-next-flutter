// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/models/http_stateful.dart';
import 'package:flutter_web_course/routing/routes.dart';
import 'package:get/get.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPass = TextEditingController();

  bool _isHidePassword = true;

  FocusNode nodeFirst = FocusNode();
  FocusNode nodeSecond = FocusNode();

  HttpStateful loginRespon = HttpStateful();

  void hideToggleClick() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  fncLogin(formKey) {
    if (formKey.currentState.validate()) {
      HttpStateful.connectAPI(_userEmail.text, _userPass.text, "01").then(
        (value) {
          setState(() {
            loginRespon = value;
            kodeToken = loginRespon.userToken;
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
                        width: screenWidth * (screenWidth > 900 ? 0.7 : 1),
                        child: const Image(
                          width: 1000,
                          fit: BoxFit.cover,
                          image: AssetImage('images/hero-login.png'),
                        ),
                      ),
                      Container(
                        height: screenHeight,
                        width: screenWidth * (screenWidth > 900 ? 0.7 : 1),
                        padding: (screenWidth > 900
                            ? const EdgeInsets.fromLTRB(30, 100, 30, 10)
                            : const EdgeInsets.fromLTRB(30, 20, 30, 10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FittedBox(
                              child: Text(
                                'Haji Dan Umroh',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cinzel Decorative'),
                              ),
                            ),
                            Text(
                              'Berawal dari KBIH Pertama di Subang pada tahun 1990 kemudian berubah menjadi PPIU di tahun 2009 dengan membawa 20 jamaah, hingga saat ini alhamdulillah masih beroperasional dengan baik.',
                              style: TextStyle(
                                fontSize: (screenWidth > 900 ? 15 : 12),
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
                  Container(
                    width: screenWidth * (screenWidth > 900 ? 0.3 : 0),
                    height: screenHeight,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            SizedBox(
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
                            image: AssetImage('images/logo-1.png'),
                          ),
                          const SizedBox(height: 10),
                          const Text('Cahaya Raudhah',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Cinzel Decorative')),
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
                                  Icons.email_outlined,
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
          ],
        ),
      ),
    );
  }
}
