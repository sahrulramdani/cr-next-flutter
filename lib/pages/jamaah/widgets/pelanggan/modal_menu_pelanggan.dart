// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/detail_modal_batal_kembali.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/detail_modal_detail.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/detail_modal_info.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/detail_modal_konfirmasi_paspor.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/detail_modal_lainnya.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/detail_modal_pembayaran.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/detail_modal_ubah_handling.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/detail_modal_ubah_jadwal.dart';

// import 'package:flutter_web_course/comp/modal_save_fail.dart';
// import 'package:flutter_web_course/comp/modal_save_success.dart';
// import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:pattern_formatter/pattern_formatter.dart';
// import 'package:intl/intl.dart';

class ButtonDetail extends StatelessWidget {
  const ButtonDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context, builder: (context) => const DetailModalDetail());
      },
      icon: const Icon(Icons.info_outline_rounded),
      label: const Text(
        'Detail',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(280, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}

class ButtonPembayaran extends StatelessWidget {
  const ButtonPembayaran({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => const DetailModalPembayaran());
      },
      icon: const Icon(Icons.payments_outlined),
      label: const Text(
        'Pembayaran',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(280, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}

class ButtonPaspor extends StatelessWidget {
  const ButtonPaspor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => const DetailModalKonfirmPaspor());
      },
      icon: const Icon(Icons.corporate_fare_rounded),
      label: const Text(
        'Konfirmasi Paspor',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(280, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}

class ButtonHandling extends StatelessWidget {
  const ButtonHandling({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => const DetailModalUbahHandling());
      },
      icon: const Icon(Icons.cases_outlined),
      label: const Text(
        'Kelola Handling',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(280, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}

class ButtonLunas extends StatelessWidget {
  const ButtonLunas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => const DetailModalInfo(
                  deskripsi: 'Mohon Maaf, Pelanggan Sudah Lunas !',
                ));
      },
      icon: const Icon(Icons.done_all_outlined),
      label: const Text(
        'Konfirmasi Lunas',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(280, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}

class ButtonJadwal extends StatelessWidget {
  const ButtonJadwal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => const DetailModalUbahJadwal());
      },
      icon: const Icon(Icons.calendar_month_outlined),
      label: const Text(
        'Perubahan Jadwal',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(280, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}

class ButtonFasilitas extends StatelessWidget {
  const ButtonFasilitas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => const DetailModalInfo(
                  deskripsi: 'Tidak Dapat Mengubah Fasilitas !',
                ));
      },
      icon: const Icon(Icons.fact_check_outlined),
      label: const Text(
        'Perubahan Fasilitas',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(280, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}

class ButtonBatal extends StatelessWidget {
  const ButtonBatal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => const DetailModalBatalKembali());
      },
      icon: const Icon(Icons.free_cancellation_outlined),
      label: const Text(
        'Pembatalan dan Pengembalian',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(280, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}

class ButtonLainnya extends StatelessWidget {
  const ButtonLainnya({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context, builder: (context) => const DetailModalLainnya());
      },
      icon: const Icon(Icons.manage_accounts_outlined),
      label: const Text(
        'Lainnya',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(280, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}

class ModalMenuPelanggan extends StatefulWidget {
  const ModalMenuPelanggan({
    Key key,
  }) : super(key: key);

  @override
  State<ModalMenuPelanggan> createState() => _ModalMenuPelangganState();
}

class _ModalMenuPelangganState extends State<ModalMenuPelanggan> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth > 600 ? screenWidth * 0.5 : screenWidth * 1,
            height: 300,
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
                      Text('Pelanggan Nanim Sumartini',
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
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          child: Column(
                            children: const [
                              ButtonDetail(),
                              SizedBox(height: 10),
                              ButtonPembayaran(),
                              SizedBox(height: 10),
                              ButtonPaspor(),
                              SizedBox(height: 10),
                              ButtonHandling(),
                              SizedBox(height: 10),
                              ButtonLunas(),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          child: Column(
                            children: const [
                              ButtonJadwal(),
                              SizedBox(height: 10),
                              ButtonFasilitas(),
                              SizedBox(height: 10),
                              ButtonBatal(),
                              SizedBox(height: 10),
                              ButtonLainnya(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
