import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';

class ModalSaveSuccess extends StatelessWidget {
  const ModalSaveSuccess({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_box_rounded,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const FittedBox(
                child: Text('Data Berhasil Disimpan',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              const SizedBox(
                height: 5,
              ),
              const FittedBox(
                child: Text('Silahkan kembali ke halaman',
                    style: TextStyle(fontSize: 10)),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali'))
            ],
          ),
        )
      ]),
    );
  }
}
