import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/marketing/widgets/marketplace/bagikan_button.dart';
import 'package:flutter_web_course/pages/marketing/widgets/marketplace/download_gambar_paket.dart';
import 'package:intl/intl.dart';
import 'package:js/js.dart' as js;

import 'package:flutter_web_course/controllers/func_all.dart';

class DescriptionBoxMarket extends StatefulWidget {
  String idPaket;
  String judul;
  String keterangan;
  int harga;
  String mu;
  String pesawatBgkt = "";
  String pesawatPlng = "";
  String rute;
  String hotelMek;
  String hotelMad;
  String hotelTra;
  String hotelPls;
  int sisa;
  String berangkat;
  String pulang;
  int durasi;
  String foto;
  DescriptionBoxMarket({
    Key key,
    this.idPaket,
    this.judul,
    this.keterangan,
    this.harga,
    this.mu,
    this.pesawatBgkt,
    this.pesawatPlng,
    this.rute,
    this.hotelMek,
    this.hotelMad,
    this.hotelTra,
    this.hotelPls,
    this.sisa,
    this.berangkat,
    this.pulang,
    this.durasi,
    this.foto,
  }) : super(key: key);

  @override
  State<DescriptionBoxMarket> createState() => _DescriptionBoxMarketState();
}

class _DescriptionBoxMarketState extends State<DescriptionBoxMarket> {
  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    String url = Uri.base.origin;
    String urlAgen = "$url/pendaftaran/$kodeAgen/${widget.idPaket}";

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.judul ?? 'Umroh / Haji',
                style: const TextStyle(
                    color: Color.fromARGB(255, 232, 174, 0),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  menuController.changeActiveitemTo('Produk Haji dan Umroh');
                  navigationController.navigateTo('/mrkt/marketplace');
                },
                child: Icon(
                  Icons.arrow_back,
                  color: myBlue,
                  size: 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            "Seat Tersisa : ${widget.sisa ?? 0}",
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 7),
          Text(
            widget.keterangan ?? "Keterangan",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 7),
          Text(
            "${widget.mu ?? 'IDR'}.${myFormat.format(widget.harga ?? 0)}",
            style: const TextStyle(
                color: Colors.red, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          const Divider(thickness: 2, color: Colors.grey),
          const SizedBox(height: 10),
          const Text(
            "Detail Paket",
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 35),
          Row(
            children: [
              const Text(
                "Lama Hari : ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "${widget.durasi ?? 0}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "Keberangkatan : ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                fncGetTanggal(widget.berangkat ?? '01-01-1111'),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "Kepulangan : ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                fncGetTanggal(widget.pulang ?? '01-01-1111'),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "Maskapai : ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              widget.pesawatBgkt != null
                  ? Text(
                      widget.pesawatBgkt == widget.pesawatPlng
                          ? widget.pesawatBgkt ?? '-'
                          : '${widget.pesawatBgkt ?? ""} - ${widget.pesawatPlng ?? ""}',
                      style: const TextStyle(fontSize: 16),
                    )
                  : const Text('-'),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Hotel : ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          widget.hotelMek != null ? const SizedBox(height: 5) : Container(),
          widget.hotelMek != null
              ? Text("- ${widget.hotelMek}",
                  style: const TextStyle(fontSize: 16))
              : Container(),
          widget.hotelMad != null ? const SizedBox(height: 5) : Container(),
          widget.hotelMad != null
              ? Text("- ${widget.hotelMad}",
                  style: const TextStyle(fontSize: 16))
              : Container(),
          widget.hotelTra != null ? const SizedBox(height: 5) : Container(),
          widget.hotelTra != null
              ? Text("- ${widget.hotelTra}",
                  style: const TextStyle(fontSize: 16))
              : Container(),
          widget.hotelPls != null ? const SizedBox(height: 5) : Container(),
          widget.hotelPls != null
              ? Text("- ${widget.hotelPls}",
                  style: const TextStyle(fontSize: 16))
              : Container(),
          const SizedBox(height: 10),
          const Text(
            'Rute : ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            widget.rute ?? '',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              DownloadGambarPaket(
                keberangkatan: fncGetTanggal(widget.berangkat ?? '01-01-1111'),
                foto: widget.foto == "" ? 'NONE' : widget.foto,
              ),
              const SizedBox(width: 10),
              BagikanButtonWidget(
                judul: widget.judul,
                desc: widget.keterangan,
                urlAgen: urlAgen,
                keberangkatan: fncGetTanggal(widget.berangkat ?? '01-01-1111'),
                harga:
                    "${widget.mu ?? 'IDR'}.${myFormat.format(widget.harga ?? 0)}",
                sisa: widget.sisa ?? 0,
                maskapai: widget.pesawatBgkt ?? '-',
              ),
            ],
          )
        ],
      ),
    );
  }
}
