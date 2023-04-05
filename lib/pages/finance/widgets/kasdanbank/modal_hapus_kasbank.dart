// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/comp/modal_delete_fail.dart';
import 'package:flutter_web_course/comp/modal_delete_success.dart';
import 'package:flutter_web_course/models/http_kasbank.dart';
import 'package:flutter_web_course/models/http_satuan.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_web_course/models/http_controller.dart';

class ModalHapusKasBank extends StatelessWidget {
  // final String idAgency;
  String idKasBank;

  ModalHapusKasBank({Key key, @required this.idKasBank}) : super(key: key);

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
                Icons.add_alert_rounded,
                color: Colors.red,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const FittedBox(
                child: Text('Apakah Kamu Yakin Ingin Menghapus Data?',
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
                        Navigator.pop(context);
                        HttpKasBank.deleteKasBank('KASX_BANK', idKasBank)
                            .then((value) {
                          if (value.status == true) {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    const ModalDeleteSuccess());

                            menuController
                                .changeActiveitemTo('Pembuatan Kas dan Bank');
                            navigationController
                                .navigateTo('/finance/pembuatan-kasbank');
                          }
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
