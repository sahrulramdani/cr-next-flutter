import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/modal_hapus_kepelangganan.dart';

class LainnyaKepelangganan extends StatelessWidget {
  const LainnyaKepelangganan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      padding: const EdgeInsets.all(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const ModalHapusKepelangganan());
            },
            icon: const Icon(Icons.person_add_disabled_outlined),
            label: const Text(
              'Batalkan Kepelangganan',
              style: TextStyle(fontFamily: 'Gilroy'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: myBlue,
              minimumSize: const Size(280, 40),
              shadowColor: Colors.grey,
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }
}
