import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/detail_comp_agency.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/detail_pelanggan_agency.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/detail_bank_agency.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/detail_card_agency.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/detail_upline_agency.dart';
// import 'package:flutter_web_course/comp/modal_delete_fail.dart';
// import 'package:flutter_web_course/comp/modal_delete_success.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_web_course/models/http_controller.dart';

class ModalEditAgency extends StatefulWidget {
  final String idAgency;

  const ModalEditAgency({
    Key key,
    @required this.idAgency,
  }) : super(key: key);

  @override
  State<ModalEditAgency> createState() => _ModalEditAgencyState();
}

class _ModalEditAgencyState extends State<ModalEditAgency> {
  bool enableDetail = true;
  bool enablePelanggan = false;
  bool enableTransaksi = false;
  bool enableBank = false;
  bool enableUpline = false;
  bool enableCard = false;

  @override
  Widget build(BuildContext context) {
    String idAgen = widget.idAgency;
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
                      icon: Icons.info_outline,
                      text: 'Detail',
                      onPressed: () {
                        setState(() {
                          enableDetail = true;
                          enablePelanggan = false;
                          enableTransaksi = false;
                          enableBank = false;
                          enableUpline = false;
                          enableCard = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.people_alt_outlined,
                      text: 'Pelanggan',
                      onPressed: () {
                        setState(() {
                          enableDetail = false;
                          enablePelanggan = true;
                          enableTransaksi = false;
                          enableBank = false;
                          enableUpline = false;
                          enableCard = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.credit_card_outlined,
                      text: 'Transaksi',
                      onPressed: () {
                        setState(() {
                          enableDetail = false;
                          enablePelanggan = false;
                          enableTransaksi = true;
                          enableBank = false;
                          enableUpline = false;
                          enableCard = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.wallet_membership_outlined,
                      text: 'Bank',
                      onPressed: () {
                        setState(() {
                          enableDetail = false;
                          enablePelanggan = false;
                          enableTransaksi = false;
                          enableBank = true;
                          enableUpline = false;
                          enableCard = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.personal_injury_outlined,
                      text: 'Downline',
                      onPressed: () {
                        setState(() {
                          enableDetail = false;
                          enablePelanggan = false;
                          enableTransaksi = false;
                          enableBank = false;
                          enableUpline = true;
                          enableCard = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.badge_outlined,
                      text: 'ID Card',
                      onPressed: () {
                        setState(() {
                          enableDetail = false;
                          enablePelanggan = false;
                          enableTransaksi = false;
                          enableBank = false;
                          enableUpline = false;
                          enableCard = true;
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
                      visible: enableDetail,
                      child: SizedBox(
                        height: 620,
                        child: DetailCompAgency(idAgency: idAgen),
                      ),
                    ),
                    Visibility(
                      visible: enablePelanggan,
                      child: SizedBox(
                        child: DetailPelangganAgency(idAgency: idAgen),
                      ),
                    ),
                    Visibility(
                      visible: enableTransaksi,
                      child: const SizedBox(
                          // child: Text('Modal Transaksi Tidak Ada Data'),
                          ),
                    ),
                    Visibility(
                      visible: enableBank,
                      child: const SizedBox(
                        child: DetailBankAgency(),
                      ),
                    ),
                    Visibility(
                      visible: enableUpline,
                      child: SizedBox(
                        child: DetailUplineAgency(idAgency: idAgen),
                      ),
                    ),
                    Visibility(
                      visible: enableCard,
                      child: const SizedBox(
                        child: DetailCardAgency(),
                      ),
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
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Simpan')),
                    const SizedBox(
                      width: 10,
                    ),
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
