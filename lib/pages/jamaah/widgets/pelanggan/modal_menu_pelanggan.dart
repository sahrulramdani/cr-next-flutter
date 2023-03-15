// ignore_for_file: deprecated_member_use, must_be_immutable

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
  String idPelanggan;
  String namaPelanggan;
  ButtonDetail(
      {Key key, @required this.idPelanggan, @required this.namaPelanggan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => DetailModalDetail(
                idPelanggan: idPelanggan, namaPelanggan: namaPelanggan));
      },
      icon: const Icon(Icons.info_outline_rounded),
      label: const Text(
        'Detail',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: authInqu == '1' ? myBlue : Colors.blue[200],
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
  String idPelanggan;
  String namaPelanggan;
  ButtonLainnya(
      {Key key, @required this.idPelanggan, @required this.namaPelanggan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => DetailModalLainnya(
                idPelanggan: idPelanggan, namaPelanggan: namaPelanggan));
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
  String idPelanggan;
  String namaPelanggan;
  ModalMenuPelanggan(
      {Key key, @required this.idPelanggan, @required this.namaPelanggan})
      : super(key: key);

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
                      Text('Pelanggan ${widget.namaPelanggan}',
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
                            children: [
                              ButtonDetail(
                                idPelanggan: widget.idPelanggan,
                                namaPelanggan: widget.namaPelanggan,
                              ),
                              const SizedBox(height: 10),
                              // const ButtonPembayaran(),
                              // const SizedBox(height: 10),
                              const ButtonPaspor(),
                              const SizedBox(height: 10),
                              const ButtonHandling(),
                              const SizedBox(height: 10),
                              const ButtonLunas(),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              const ButtonJadwal(),
                              const SizedBox(height: 10),
                              const ButtonFasilitas(),
                              const SizedBox(height: 10),
                              const ButtonBatal(),
                              const SizedBox(height: 10),
                              ButtonLainnya(
                                idPelanggan: widget.idPelanggan,
                                namaPelanggan: widget.namaPelanggan,
                              ),
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
