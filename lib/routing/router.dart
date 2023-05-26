import 'package:flutter/material.dart';
import 'package:flutter_web_course/pages/authentication/authentication.dart';
import 'package:flutter_web_course/pages/clients/clients.dart';
import 'package:flutter_web_course/pages/finance/finance_cost_stucture.dart';
import 'package:flutter_web_course/pages/finance/finance_dash.dart';
import 'package:flutter_web_course/pages/finance/finance_estimasi_paket.dart';
import 'package:flutter_web_course/pages/finance/finance_kas_pendapatan.dart';
import 'package:flutter_web_course/pages/finance/finance_kas_pengeluaran.dart';
import 'package:flutter_web_course/pages/finance/finance_kasbank_harian.dart';
import 'package:flutter_web_course/pages/finance/finance_laporan_tagihan.dart';
import 'package:flutter_web_course/pages/finance/finance_master_account.dart';
import 'package:flutter_web_course/pages/finance/finance_pembayaran.dart';
import 'package:flutter_web_course/pages/finance/finance_pembayaran_harian.dart';
import 'package:flutter_web_course/pages/finance/finance_pembuatan_bayar.dart';
import 'package:flutter_web_course/pages/finance/finance_pembuatan_kas.dart';
import 'package:flutter_web_course/pages/finance/finance_pendapatan_biaya.dart';
import 'package:flutter_web_course/pages/finance/finance_penerbangan.dart';
import 'package:flutter_web_course/pages/finance/finance_ujrah.dart';
import 'package:flutter_web_course/pages/finance/widgets/pembayaran/pembayaran_page.dart';
import 'package:flutter_web_course/pages/hr/hr_dash.dart';
import 'package:flutter_web_course/pages/hr/hr_kantor.dart';
import 'package:flutter_web_course/pages/hr/setting_grup_user.dart';
import 'package:flutter_web_course/pages/hr/setting_menu.dart';
import 'package:flutter_web_course/pages/hr/setting_pengguna.dart';
import 'package:flutter_web_course/pages/inventory/inventory_barang.dart';
import 'package:flutter_web_course/pages/inventory/inventory_dash.dart';
import 'package:flutter_web_course/pages/inventory/inventory_grup_barang.dart';
import 'package:flutter_web_course/pages/inventory/inventory_handling.dart';
import 'package:flutter_web_course/pages/inventory/inventory_kirim_barang.dart';
import 'package:flutter_web_course/pages/inventory/inventory_pengeluaran.dart';
import 'package:flutter_web_course/pages/inventory/inventory_satuan.dart';
import 'package:flutter_web_course/pages/jamaah/jamaah_alumni.dart';
import 'package:flutter_web_course/pages/jamaah/jamaah_dash.dart';
import 'package:flutter_web_course/pages/marketing/marketing_bandara.dart';
import 'package:flutter_web_course/pages/marketing/marketing_detail_marketplace.dart';
import 'package:flutter_web_course/pages/marketing/marketing_jadwal.dart';
import 'package:flutter_web_course/pages/jamaah/jamaah_master.dart';
import 'package:flutter_web_course/pages/jamaah/jamaah_pelanggan.dart';
import 'package:flutter_web_course/pages/jamaah/jamaah_pendaftaran.dart';
//import 'package:flutter_web_course/pages/drivers/driver.dart';
import 'package:flutter_web_course/pages/marketing/marketing_dash.dart';
import 'package:flutter_web_course/pages/marketing/marketing_agency.dart';
import 'package:flutter_web_course/pages/hr/hr_karyawan.dart';
import 'package:flutter_web_course/pages/marketing/marketing_marketplace.dart';
import 'package:flutter_web_course/pages/marketing/marketing_pemberangkatan.dart';
import 'package:flutter_web_course/pages/marketing/marketing_perolehan_tahun.dart';
import 'package:flutter_web_course/pages/marketing/marketing_tourlead.dart';
import 'package:flutter_web_course/pages/marketing/marketing_trasit.dart';
import 'package:flutter_web_course/pages/marketing/marketing_maskapai.dart';
import 'package:flutter_web_course/pages/marketing/marketing_hotel.dart';
// import 'package:flutter_web_course/pages/marketing/marketing_02dealtrack.dart';
import 'package:flutter_web_course/pages/overview/overview.dart';
import 'package:flutter_web_course/pages/pengaturan/setting_biaya.dart';
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
    case mrktMarketplacePageRoute:
      return _getPageRoute(const MarketingMarketplacePage());
    case mrktDetMrktPageRoute:
      return _getPageRoute(const MarketingDetailMarketplace());
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
    case mrktBandaraPageRoute:
      return _getPageRoute(const MarketingBandaraPage());
    // MARKETING
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
    // INVERTORY
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
    case invHandlingPageRoute:
      return _getPageRoute(const InventoryHandlingPage());
    // FINANCE
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
    case fincPembayaranHariPageRoute:
      return _getPageRoute(const FinancePembayaranHarian());
    case fincKasPendapatanPageRoute:
      return _getPageRoute(const KasPendapatan());
    case fincKasPengeluaranPageRoute:
      return _getPageRoute(const KasPengeluaran());
    case fincMasterAccountPageRoute:
      return _getPageRoute(const FinanceMasterAccount());
    case fincKasDanBankPageRoute:
      return _getPageRoute(const FinanceKasDanBankPage());
    case fincCaraBayarPageRoute:
      return _getPageRoute(const FinanceCaraBayar());
    case fincKasBankHariPageRoute:
      return _getPageRoute(const FinanceKasBankHarian());
    case fincEstimasiPaketPageRoute:
      return _getPageRoute(const FinanceEstimasiPaket());
    case fincLaporanTagihanRoute:
      return _getPageRoute(const FinanceLaporanTagihan());
    case fincPendapatanBiayaPageRoute:
      return _getPageRoute(const FinancePendapatanBiaya());
    case fincCostStructurePageRoute:
      return _getPageRoute(const FinanceCostStructure());
    // HUMAN RESOURCE
    case hrPageRoute:
      return _getPageRoute(const HumanResourceDashPage());
    case hrKaryawanPageRoute:
      return _getPageRoute(const HrKaryawanPage());
    case hrKantorPageRoute:
      return _getPageRoute(const HrKantorPage());
    // SETTING
    case settingGrupUserRoute:
      return _getPageRoute(const SettingGrupUser());
    case settingPenggunaRoute:
      return _getPageRoute(const SettingUser());
    case settingMenuRoute:
      return _getPageRoute(const SettingMenu());
    case settingBiayaRoute:
      return _getPageRoute(const SettingBiaya());
      return _getPageRoute(ClientsPage());
    // AUTHENTICATION
    case authenticationPageRoute:
      return _getPageRoute(const AuthenticationPage());
    default:
      return _getPageRoute(const OverViewPage());
  }
}

      // ------------------
      // case mrktDealTrackPageRoute:
      //   return _getPageRoute(DealTrackPage());
      // case projectPageRoute:
      //   return _getPageRoute(PmPage());
      // case clientPageRoute: