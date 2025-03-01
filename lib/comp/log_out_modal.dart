import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_delete_fail.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_web_course/models/http_controller.dart';

class LogoutModal extends StatefulWidget {
  const LogoutModal({Key key}) : super(key: key);

  @override
  State<LogoutModal> createState() => _LogoutModalState();
}

class _LogoutModalState extends State<LogoutModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 300,
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.logout,
                color: Colors.red,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const FittedBox(
                child: Text('Apakah Kamu Yakin Ingin Log Out?',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        menuController.changeActiveitemTo(" ");
                        Get.offAllNamed('/auth');

                        setState(() {
                          kodeToken = "";
                          namaUser = "";
                          username = "";
                          fotoUser = null;
                          kodeAgen = null;
                        });
                      },
                      child: const Text('Yakin')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Kembali')),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
