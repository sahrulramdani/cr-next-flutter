import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/comp/modal_delete_fail.dart';
import 'package:flutter_web_course/comp/modal_delete_success.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_web_course/models/http_controller.dart';

class ModalHapusKepelangganan extends StatelessWidget {
  // final String idAgency;

  const ModalHapusKepelangganan({Key key}) : super(key: key);

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
              const Text(
                  'Apakah Kamu Yakin Ingin Menghapus Kepelangganan Nanim Sumartini?',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => const ModalDeleteSuccess());
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
