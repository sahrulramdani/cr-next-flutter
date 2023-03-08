import 'package:flutter/material.dart';
import 'package:flutter_web_course/pages/authentication/authentication.dart';
import 'package:flutter_web_course/pages/clients/clients.dart';
import 'package:flutter_web_course/pages/finance/finance_dash.dart';
import 'package:flutter_web_course/pages/finance/finance_pembayaran.dart';
import 'package:flutter_web_course/pages/finance/finance_penerbangan.dart';
import 'package:flutter_web_course/pages/finance/finance_ujrah.dart';
import 'package:flutter_web_course/pages/finance/widgets/pembayaran/pembayaran_page.dart';
import 'package:flutter_web_course/pages/hr/hr_dash.dart';
import 'package:flutter_web_course/pages/hr/setting_grup_user.dart';
import 'package:flutter_web_course/pages/hr/setting_menu.dart';
import 'package:flutter_web_course/pages/hr/setting_pengguna.dart';
import 'package:flutter_web_course/pages/inventory/inventory_barang.dart';
import 'package:flutter_web_course/pages/inventory/inventory_dash.dart';
import 'package:flutter_web_course/pages/inventory/inventory_grup_barang.dart';
import 'package:flutter_web_course/pages/inventory/inventory_kirim_barang.dart';
import 'package:flutter_web_course/pages/inventory/inventory_pengeluaran.dart';
import 'package:flutter_web_course/pages/inventory/inventory_satuan.dart';
import 'package:flutter_web_course/pages/jamaah/jamaah_alumni.dart';
import 'package:flutter_web_course/pages/jamaah/jamaah_dash.dart';
import 'package:flutter_web_course/pages/marketing/marketing_jadwal.dart';
import 'package:flutter_web_course/pages/jamaah/jamaah_master.dart';
import 'package:flutter_web_course/pages/jamaah/jamaah_pelanggan.dart';
import 'package:flutter_web_course/pages/jamaah/jamaah_pendaftaran.dart';
//import 'package:flutter_web_course/pages/drivers/driver.dart';
import 'package:flutter_web_course/pages/marketing/marketing_dash.dart';
import 'package:flutter_web_course/pages/marketing/marketing_agency.dart';
import 'package:flutter_web_course/pages/hr/hr_karyawan.dart';
import 'package:flutter_web_course/pages/marketing/marketing_pemberangkatan.dart';
import 'package:flutter_web_course/pages/marketing/marketing_perolehan_tahun.dart';
import 'package:flutter_web_course/pages/marketing/marketing_tourlead.dart';
import 'package:flutter_web_course/pages/marketing/marketing_trasit.dart';
import 'package:flutter_web_course/pages/marketing/marketing_maskapai.dart';
import 'package:flutter_web_course/pages/marketing/marketing_hotel.dart';
// import 'package:flutter_web_course/pages/marketing/marketing_02dealtrack.dart';
import 'package:flutter_web_course/pages/overview/overview.dart';
// import 'package:flutter_web_course/pages/pm/pm.dart';
import 'package:flutter_web_course/routing/routes.dart';
//import 'package:get/get.dart';

MaterialPageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // DASHBOARD
    case overViewPageRoute:
      return _getPageRoute(const OverViewPage());
    // MARKETING
    case marketingPageRoute:
      return _getPageRoute(const MarketingDashboardPage());
    case mrktAgencyPageRoute:
      return _getPageRoute(const MarketingAgencyPage());
    case mrktJadwalPageRoute:
      return _getPageRoute(const MarketingJadwalPage());
    case mrktPemberangkatanPageRoute:
      return _getPageRoute(const MarketingBerangkatPage());
    case mrktTourleadPageRoute:
      return _getPageRoute(const MarketingTourleadPage());
    case mrktPerolehanTahunPageRoute:
      return _getPageRoute(const MarketingPerolehanTahunan());
    case mrktTransitPageRoute:
      return _getPageRoute(const MarketingTransitPage());
    case mrktPesawatPageRoute:
      return _getPageRoute(const MarketingMaskapai());
    case mrktHotelPageRoute:
      return _getPageRoute(const MarketingHotel());
    case jamaahPageRoute:
      return _getPageRoute(const JamaahDashboardPage());
    case jmahDataPageRoute:
      return _getPageRoute(const JamaahDataPage());
    case jmahPendaftaranPageRoute:
      return _getPageRoute(const JamaahPendaftaranPage());
    case jmahPelangganPageRoute:
      return _getPageRoute(const JamaahPelangganPage());
    case jmahAlumniPageRoute:
      return _getPageRoute(const JamaahAlumniPage());
    case inventoryPageRoute:
      return _getPageRoute(const InventoryDashboardPage());
    case invSatuanPageRoute:
      return _getPageRoute(const InventorySatuanPage());
    case invBarangPageRoute:
      return _getPageRoute(const InventoryBarangPage());
    case invPengeluaranPageRoute:
      return _getPageRoute(const InventoryPengeluaranPage());
    case invGrupBarangPageRoute:
      return _getPageRoute(const InventoryGrupBarangPage());
    case invKirimBarangPageRoute:
      return _getPageRoute(const InventoryKirimBarang());
    case financePageRoute:
      return _getPageRoute(const FinanceDashboardPage());
    case fincPembayaranPageRoute:
      return _getPageRoute(const FinancePembayaranPage());
    case fincBayarFormPageRoute:
      return _getPageRoute(const PembayaranFormPage());
    case fincUjrahPageRoute:
      return _getPageRoute(const FinanceUjrahPage());
    case fincPenerbanganPageRoute:
      return _getPageRoute(const FinancePenerbanganPage());
    case hrPageRoute:
      return _getPageRoute(const HumanResourceDashPage());
    case hrKaryawanPageRoute:
      return _getPageRoute(const HrKaryawanPage());
    case settingGrupUserRoute:
      return _getPageRoute(const SettingGrupUser());
    case settingPenggunaRoute:
      return _getPageRoute(const SettingUser());
    case settingMenuRoute:
      return _getPageRoute(const SettingMenu());
      // ------------------
      // case mrktDealTrackPageRoute:
      //   return _getPageRoute(DealTrackPage());
      // case projectPageRoute:
      //   return _getPageRoute(PmPage());
      // case clientPageRoute:
      return _getPageRoute(ClientsPage());
    case authenticationPageRoute:
      return _getPageRoute(const AuthenticationPage());

    default:
      return _getPageRoute(const OverViewPage());
  }
}
