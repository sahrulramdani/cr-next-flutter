// import 'package:flutter_web_course/pages/404/error_page.dart';

const rootRoute = "/";

// DASHBOARD
const overViewPageDisplayName = "Dashboard";
const overViewPageRoute = "/overview";

// MARKETING
const marketingPageDisplayName = "Marketing";
const marketingPageRoute = "/marketing";

const mrktAgencyPageDisplayName = "Agency";
const mrktAgencyPageRoute = "/mrkt/agency";

const mrktJadwalPageDisplayName = "Jadwal";
const mrktJadwalPageRoute = "/mrkt/jadwal";

const mrktPemberangkatanPageDisplayName = "Marketing";
const mrktPemberangkatanPageRoute = "/mrkt/pemberangkatan";

const mrktTourleadPageDisplayName = "Tour Leader";
const mrktTourleadPageRoute = "/mrkt/tourlead";

const mrktPerolehanTahunPageDisplayName = "Perolehan Per Tahun";
const mrktPerolehanTahunPageRoute = "/mrkt/perolehan-pertahun";

const mrktTransitPageDisplayName = "Master Transit";
const mrktTransitPageRoute = "/mrkt/transit";

const mrktPesawatPageDisplayName = "Master Maskapai";
const mrktPesawatPageRoute = "/mrkt/maskapai";

const mrktHotelPageDisplayName = "Master Hotel";
const mrktHotelPageRoute = "/mrkt/hotel";

const jamaahPageDisplayName = "Jamaah";
const jamaahPageRoute = "/jamaah";

const jmahDataPageDisplayName = "Jamaah";
const jmahDataPageRoute = "/jamaah/master";

const jmahPendaftaranPageDisplayName = "Pendaftaran Paket";
const jmahPendaftaranPageRoute = "/jamaah/pendaftaran";

const jmahPelangganPageDisplayName = "Data Pelanggan";
const jmahPelangganPageRoute = "/jamaah/pelanggan";

const jmahAlumniPageDisplayName = "Data Alumni";
const jmahAlumniPageRoute = "/jamaah/alumni";

const inventoryPageDisplayName = "Inventory";
const inventoryPageRoute = "/inventory";

const invSatuanPageDisplayName = "Satuan";
const invSatuanPageRoute = "/inventory/satuan";

const invBarangPageDisplayName = "Barang";
const invBarangPageRoute = "/inventory/barang";

const invPengeluaranPageDisplayName = "Pengeluaran";
const invPengeluaranPageRoute = "/inventory/pengeluaran";

const invGrupBarangPageDisplayName = "Grup Barang";
const invGrupBarangPageRoute = "/inventory/grup-barang";

const invKirimBarangPageDisplayName = "Kirim Barang";
const invKirimBarangPageRoute = "/inventory/kirim-barang";

const hrPageDisplayName = "HR";
const hrPageRoute = "/hr";

const hrKaryawanPageDisplayName = "Karyawan";
const hrKaryawanPageRoute = "/hr/karyawan";

const financePageDisplayName = "Finance";
const financePageRoute = "/finance";

const fincPembayaranPageDisplayName = "Pembayaran";
const fincPembayaranPageRoute = "/finance/pembayaran-jamaah";

const fincBayarFormPageDisplayName = "Form Bayar";
const fincBayarFormPageRoute = "/finance/form-bayar";

const fincUjrahPageDisplayName = "Ujrah";
const fincUjrahPageRoute = "/finance/pembayaran-ujrah";

const fincPenerbanganPageDisplayName = "Penerbangan";
const fincPenerbanganPageRoute = "/finance/profit-penerbangan";
// ----------------

// const mrktDealTrackPageDisplayName = "DealTrack";
// const mrktDealTrackPageRoute = "/mrkt/track";

// const projectPageDisplayName = "PM";
// const projectPageRoute = "/client";

// const clientPageDisplayName = "Engineering";
// const clientPageRoute = "/engginer";

// const ppicPageDisplayName = "PPIC";
// const ppicPageRoute = "/client";

// const orderPageDisplayName = "Purchasing";
// const orderPageRoute = "/client";

// const whPageDisplayName = "Warehouse";
// const whPageRoute = "/client";

// const prodPageDisplayName = "Produksi";
// const prodPageRoute = "/client";

// const qcPageDisplayName = "QC";
// const qcPageRoute = "/client";

const mrktLeadsPageDisplayName = "Leads";
const mrktLeadsPageRoute = "/mrkt/leads";

const authenticationPageDisplayName = "Log Out";
const authenticationPageRoute = "/auth";

// MENU ASLI

const purchasingPageDisplayName = "Purchasing";
const purchasingPageRoute = "/client";

const crmPageDisplayName = "CRM";
const crmPageRoute = "/client";

// const PageNotFoundName = "not-found";
// const PageNotFoundRoute = "/not-found";

class MenuItem {
  final String name;
  final String route;
  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(overViewPageDisplayName, overViewPageRoute),
  MenuItem(marketingPageDisplayName, marketingPageRoute),
  // ASLI
  MenuItem(jamaahPageDisplayName, jamaahPageRoute),
  MenuItem(inventoryPageDisplayName, inventoryPageRoute),
  MenuItem(financePageDisplayName, financePageRoute),
  MenuItem(purchasingPageDisplayName, purchasingPageRoute),
  MenuItem(crmPageDisplayName, crmPageRoute),
  MenuItem(hrPageDisplayName, hrPageRoute),
  // ASLI
  //-------------------------------------------------------------
  //MARKETING
  //MenuItem(Mrkt_LeadsPageDisplayName, Mrkt_LeadsPageRoute),

  //MARKETING
  //-------------------------------------------------------------
  // MenuItem(projectPageDisplayName, projectPageRoute),
  // MenuItem(clientPageDisplayName, clientPageRoute),
  // MenuItem(ppicPageDisplayName, ppicPageRoute),
  // MenuItem(orderPageDisplayName, orderPageRoute),
  // MenuItem(whPageDisplayName, whPageRoute),
  // MenuItem(prodPageDisplayName, prodPageRoute),
  // MenuItem(qcPageDisplayName, qcPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
