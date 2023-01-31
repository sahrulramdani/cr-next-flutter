import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/lainnya_agensi.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/lainnya_fasilitas.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/lainnya_kepelangganan.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/lainnya_kwitansi.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/lainnya_potongan.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/lainnya_refund.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:flutter_web_course/comp/modal_delete_fail.dart';
// import 'package:flutter_web_course/comp/modal_delete_success.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_web_course/models/http_controller.dart';

class DetailModalLainnya extends StatefulWidget {
  const DetailModalLainnya({Key key}) : super(key: key);

  @override
  State<DetailModalLainnya> createState() => _DetailModalLainnyaState();
}

class _DetailModalLainnyaState extends State<DetailModalLainnya> {
  bool enableKepelangganan = true;
  bool enableKwitansi = false;
  bool enableFasilitas = false;
  bool enableAgency = false;
  bool enablePotongan = false;
  bool enableRefund = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: screenWidth * 0.7,
          height: 700,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Icon(
                      Icons.corporate_fare_rounded,
                      color: Colors.amber[900],
                    ),
                    const SizedBox(width: 10),
                    FittedBox(
                      child: Text('Pelanggan Nanim Sumartini',
                          style: TextStyle(
                              color: myGrey, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: GNav(
                  backgroundColor: Colors.white,
                  color: Colors.grey,
                  activeColor: const Color.fromARGB(255, 14, 116, 199),
                  tabBackgroundColor: const Color.fromARGB(255, 227, 238, 255),
                  gap: 6,
                  padding: const EdgeInsets.all(16),
                  tabs: [
                    GButton(
                      icon: Icons.supervised_user_circle_outlined,
                      text: 'Kepelangganan',
                      onPressed: () {
                        setState(() {
                          enableKepelangganan = true;
                          enableKwitansi = false;
                          enableFasilitas = false;
                          enableAgency = false;
                          enablePotongan = false;
                          enableRefund = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.receipt_long_outlined,
                      text: 'Kwitansi',
                      onPressed: () {
                        setState(() {
                          enableKepelangganan = false;
                          enableKwitansi = true;
                          enableFasilitas = false;
                          enableAgency = false;
                          enablePotongan = false;
                          enableRefund = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.format_line_spacing_outlined,
                      text: 'Fasilitas',
                      onPressed: () {
                        setState(() {
                          enableKepelangganan = false;
                          enableKwitansi = false;
                          enableFasilitas = true;
                          enableAgency = false;
                          enablePotongan = false;
                          enableRefund = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.personal_injury_outlined,
                      text: 'Agency',
                      onPressed: () {
                        setState(() {
                          enableKepelangganan = false;
                          enableKwitansi = false;
                          enableFasilitas = false;
                          enableAgency = true;
                          enablePotongan = false;
                          enableRefund = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.cut_outlined,
                      text: 'Potongan',
                      onPressed: () {
                        setState(() {
                          enableKepelangganan = false;
                          enableKwitansi = false;
                          enableFasilitas = false;
                          enableAgency = false;
                          enablePotongan = true;
                          enableRefund = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.account_balance_wallet_outlined,
                      text: 'Refund',
                      onPressed: () {
                        setState(() {
                          enableKepelangganan = false;
                          enableKwitansi = false;
                          enableFasilitas = false;
                          enableAgency = false;
                          enablePotongan = false;
                          enableRefund = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: screenWidth,
                  child: Column(children: [
                    Visibility(
                      visible: enableKepelangganan,
                      child: const SizedBox(child: LainnyaKepelangganan()),
                    ),
                    Visibility(
                      visible: enableKwitansi,
                      child: const SizedBox(child: LainnyaKwitansi()),
                    ),
                    Visibility(
                      visible: enableFasilitas,
                      child: const SizedBox(child: LainnyaFasilitas()),
                    ),
                    Visibility(
                      visible: enableAgency,
                      child: const SizedBox(child: LainnyaAgensi()),
                    ),
                    Visibility(
                      visible: enablePotongan,
                      child: const SizedBox(child: LainnyaPotongan()),
                    ),
                    Visibility(
                      visible: enableRefund,
                      child: const SizedBox(child: LainnyaRefund()),
                    ),
                  ]),
                ),
              )),
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => const ModalSaveSuccess());
                      },
                      icon: const Icon(Icons.save),
                      label: const Text(
                        'Simpan Data',
                        style: TextStyle(fontFamily: 'Gilroy'),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: myBlue,
                        shadowColor: Colors.grey,
                        elevation: 5,
                      ),
                    ),
                    const SizedBox(width: 10),
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
        )
      ]),
    );
  }
}
