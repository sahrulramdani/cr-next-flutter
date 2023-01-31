import 'dart:convert';

List<Leads> leadsFromJson(String str) =>
    List<Leads>.from(json.decode(str).map((x) => Leads.fromJson(x)));

String leadsToJson(List<Leads> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Leads {
  Leads({
    this.kodeCust,
    this.kodeMrkt,
    this.kontCust,
    this.mailCust,
    this.namaProj,
    this.noxxDocx,
    this.noxxLead,
    this.picxSale,
    this.scopDesc,
    this.spekDesc,
    this.statLead,
    this.telpCust,
    this.tglxEstm,
    this.tglxUpdt,
    this.valxProj,
  });

  String kodeCust;
  String kodeMrkt;
  String kontCust;
  String mailCust;
  String namaProj;
  String noxxDocx;
  String noxxLead;
  String picxSale;
  String scopDesc;
  String spekDesc;
  String statLead;
  String telpCust;
  DateTime tglxEstm;
  DateTime tglxUpdt;
  int valxProj;

  factory Leads.fromJson(Map<String, dynamic> json) => Leads(
        kodeCust: json["KODE_CUST"],
        kodeMrkt: json["KODE_MRKT"],
        kontCust: json["KONT_CUST"],
        mailCust: json["MAIL_CUST"],
        namaProj: json["NAMA_PROJ"],
        noxxDocx: json["NOXX_DOCX"],
        noxxLead: json["NOXX_LEAD"],
        picxSale: json["PICX_SALE"],
        scopDesc: json["SCOP_DESC"],
        spekDesc: json["SPEK_DESC"],
        statLead: json["STAT_LEAD"],
        telpCust: json["TELP_CUST"],
        tglxEstm: DateTime.parse(json["TGLX_ESTM"]),
        tglxUpdt: DateTime.parse(json["TGLX_UPDT"]),
        valxProj: json["VALX_PROJ"],
      );

  Map<String, dynamic> toJson() => {
        "KODE_CUST": kodeCust,
        "KODE_MRKT": kodeMrkt,
        "KONT_CUST": kontCust,
        "MAIL_CUST": mailCust,
        "NAMA_PROJ": namaProj,
        "NOXX_DOCX": noxxDocx,
        "NOXX_LEAD": noxxLead,
        "PICX_SALE": picxSale,
        "SCOP_DESC": scopDesc,
        "SPEK_DESC": spekDesc,
        "STAT_LEAD": statLead,
        "TELP_CUST": telpCust,
        "TGLX_ESTM":
            "${tglxEstm.year.toString().padLeft(4, '0')}-${tglxEstm.month.toString().padLeft(2, '0')}-${tglxEstm.day.toString().padLeft(2, '0')}",
        "TGLX_UPDT":
            "${tglxUpdt.year.toString().padLeft(4, '0')}-${tglxUpdt.month.toString().padLeft(2, '0')}-${tglxUpdt.day.toString().padLeft(2, '0')}",
        "VALX_PROJ": valxProj,
      };
}
