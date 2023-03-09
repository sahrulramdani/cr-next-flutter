import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/detail_jadwal_tourlead.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/detail_jadwal_pelanggan.dart';

class ModalEditTourlead extends StatefulWidget {
  const ModalEditTourlead({Key key}) : super(key: key);

  @override
  State<ModalEditTourlead> createState() => _ModalEditTourleadState();
}

class _ModalEditTourleadState extends State<ModalEditTourlead> {
  Widget cmdPrint() {
    return ElevatedButton.icon(
      onPressed: () {
        authPrnt == '1'
            ? ''
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.print_outlined),
      label: const Text(
        'Print Akumulatif',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: authInqu == '1' ? myBlue : Colors.blue[200],
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdRefresh() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.restart_alt_outlined),
      label: const Text(
        'Refresh',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget menuButton() => SizedBox(
        height: 50,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            cmdPrint(),
          ],
        ),
      );

  Widget menuRefresh() => SizedBox(
        height: 50,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            cmdRefresh(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.9,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.personal_injury_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('TL. Billy Syahputra',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.44,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jadwal Keberangkatan',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            menuButton(),
                            const Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DetailJadwalTourlead()),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.44,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Daftar Pelanggan',
                                style: TextStyle(
                                    color: myGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            menuRefresh(),
                            const Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DetailJadwalPelanggan()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                          child: const Text('Kembali'))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
