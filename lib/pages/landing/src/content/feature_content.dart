// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/card_icon_widget.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/responsive_widget.dart';

// const youtubeVideo = 'https://www.youtube.com/embed/k32xyP3KuWE';

class FeaturesContent extends ResponsiveWidget {
  FeaturesContent({Key key}) : super(key: key) {
    // ui.platformViewRegistry.registerViewFactory(
    //   'youtube-video',
    //   (int viewId) => IFrameElement()
    //     ..src = youtubeVideo
    //     ..style.border = 'none',
    // );
  }

  @override
  Widget buildDesktop(BuildContext context) =>
      const FeaturesContentResponsive(200);

  @override
  Widget buildMobile(BuildContext context) =>
      const FeaturesContentResponsive(24);
}

class FeaturesContentResponsive extends StatelessWidget {
  final horizontalPadding;

  const FeaturesContentResponsive(this.horizontalPadding, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Travel Haji dan Umroh",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth < 500 ? 17 : 30),
                ),
                Text(
                  " Terpercaya",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth < 500 ? 17 : 30,
                      color: Colors.red),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    "Dengan ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth < 500 ? 17 : 30),
                  ),
                ),
                FittedBox(
                  child: Text(
                    "Pelayanan Terbaik",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth < 500 ? 17 : 30,
                        color: myBlue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                screenWidth < 500
                    ? Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            width: screenWidth,
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Image.asset(
                                  'assets/images/tentang-kami-foto.png',
                                )),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: screenHeight * 0.8,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                      "Mengenal Lebih Dekat Dengan PT. Cahaya Raudhah",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 30),
                                  Text(
                                      "Berawal dari KBIH Al lkhlas Yang didirikan Sejak tahun 1990. kemudian tumbuh dan berkembang. Dibawah pimpinan Bapak H.Wawan Hermawan tahun 2010 KBIH Al ikhlas semakin melebarkan sayap dan berkembang sehingga mampu mendirikan Perusahaan travel Haji dan Umrah sendiri yang diberi nama PT Cahaya Raudhah. Tidak hanya melayani umrah dan haji kami juga melayani penjualan tiket serta paket wisata halal baik domestic dan international. Untuk memperkuat bisnis kami telah menjadi anggota dari Association Of The Indonesian Tours & Travels Agencies (ASITA), Kesatuan Tour Travel Haji Umroh Republik Indonesia (KESTHURI). Selain sebagai komitmen legalitas perusahaan dalam melayani custumer serta jamaah secara professional kami telah memiliki izin resmi sebagai Biro Perjalanan Wisata dan sebagai Penyelenggara lbadah Umrah dari Kementrian Agama RI.",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Gilroy',
                                      )),
                                ]),
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            width: screenWidth * 0.5,
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Image.asset(
                                  'assets/images/tentang-kami-foto.png',
                                )),
                          ),
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                      "Mengenal Lebih Dekat Dengan PT. Cahaya Raudhah",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 30),
                                  Text(
                                      "Berawal dari KBIH Al lkhlas Yang didirikan Sejak tahun 1990. kemudian tumbuh dan berkembang. Dibawah pimpinan Bapak H.Wawan Hermawan tahun 2010 KBIH Al ikhlas semakin melebarkan sayap dan berkembang sehingga mampu mendirikan Perusahaan travel Haji dan Umrah sendiri yang diberi nama PT Cahaya Raudhah. Tidak hanya melayani umrah dan haji kami juga melayani penjualan tiket serta paket wisata halal baik domestic dan international. Untuk memperkuat bisnis kami telah menjadi anggota dari Association Of The Indonesian Tours & Travels Agencies (ASITA), Kesatuan Tour Travel Haji Umroh Republik Indonesia (KESTHURI). Selain sebagai komitmen legalitas perusahaan dalam melayani custumer serta jamaah secara professional kami telah memiliki izin resmi sebagai Biro Perjalanan Wisata dan sebagai Penyelenggara lbadah Umrah dari Kementrian Agama RI.",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Gilroy',
                                      )),
                                ]),
                          ))
                        ],
                      ),
                const SizedBox(height: 50),
                Divider(
                  thickness: 2,
                  color: myBlue,
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        "Kenapa Harus Memilih ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth < 500 ? 17 : 30),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        "Kami",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth < 500 ? 17 : 30,
                            color: myBlue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CardIconLanding(
                      judul: "Memiliki Cabang Puluhan Tempat",
                      deskripsi:
                          "Alhamdulillah biidznillah terdapat puluhan cabang di Indonesia yang Allah amanahkan kepada kami sebagai bentuk pelayanan kami terhadap calon jamaah undangan Allah Subhanahu Wata'ala.",
                      icon: "0xf114",
                    ),
                    SizedBox(width: 30),
                    CardIconLanding(
                      judul: "Memiliki Legalitas Yang Sah",
                      deskripsi:
                          "PT Cahaya Raudhah telah resmi terdaftar sebagai penyelenggara umroh oleh Kementrian Agama RI No 817 Tahun 2019, SK Menteri Kehakiman AHU-52007.AH.01.01 TH 2011/26 Oktober 2011, TDP 10.10.1.60.00456, Anggota ASITA (Association of The Indonesian Tours and Travel Agencies) 0597/IX/DPP/2014, Anggota KESTHURI (Kesatuan Tour Travel Haji Umroh Republik Indonesia) 60/kesthuri/2014.",
                      icon: "0xf058",
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CardIconLanding(
                      judul: "Pembimbing Yang Bersertifikat Nasional",
                      deskripsi:
                          "Pembimbing dan Tour Leader telah mengikuti berbagai pelatihan serta sertifikasi nasional sehingga diharapkan mampu memberikan kenyamanan dan pelayanan yang maksimal kepada para jamaah tamu undangan Allah.",
                      icon: "0xe488",
                    ),
                    SizedBox(width: 30),
                    CardIconLanding(
                      judul: "Booking & Konsultasi Online",
                      deskripsi:
                          "Bagi anda yang memiliki kesibukan dan tidak bisa mendatangi kantor pusat atau cabang PT Cahaya Raudhah, anda dapat booking dan konsultasi online melalui website dan whatsapp support yang kami sediakan.",
                      icon: "0xeede",
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CardIconLanding(
                      judul: "Dapat Memilih Paket Sesuai Kebutuhan",
                      deskripsi:
                          "Kami menyediakan beragam paket umrah dengan harga dan paket yang bervariasi, sehingga Anda bisa memilih paket yang sesuai dengan kebutuhan Anda. Terdapat pilihan maskapai, tanggal keberangkatan, hotel, serta kamar yang bisa anda sesuaikan.",
                      icon: "0xee6e",
                    ),
                    SizedBox(width: 30),
                    CardIconLanding(
                      judul: "Fasilitas & Pelayanan Lengkap",
                      deskripsi:
                          "Kami berusaha menyediakan pelayanan terbaik dan terlengkap bagi para jamaah yang bepergian bersama kami, mulai dari perlengkapan umroh & Haji, bimbingan manasik sebelum berangkat hingga layanan dari Tour Leader dan Muthowif yang insya Allah selalu siap membantu Anda selama perjalanan.",
                      icon: "0xeeb4",
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
