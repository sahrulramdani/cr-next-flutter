// ignore_for_file: avoid_print, prefer_is_empty, missing_return, deprecated_member_use

import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/models/http_account.dart';
import 'package:flutter_web_course/pages/finance/widgets/account/modal_hapus_account.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';

import 'dart:convert';
import 'package:animated_tree_view/animated_tree_view.dart';

class FinanceMasterAccount extends StatefulWidget {
  const FinanceMasterAccount({Key key}) : super(key: key);

  @override
  State<FinanceMasterAccount> createState() => _FinanceMasterAccountState();
}

class _FinanceMasterAccountState extends State<FinanceMasterAccount> {
  List<Map<String, dynamic>> listAccount = [];
  List<Map<String, dynamic>> listKategoriAccount = [];
  List<Map<String, dynamic>> listMataUang = [];

  String kodeAkun;
  bool statusAktif = false;
  String namaAkun;
  String indukAkun;
  String descIndukAkun;
  String kategoriAkun;
  String descKategoriAkun;
  String dk;
  String mataUang;
  String idMataUang;
  bool statusBudget = false;
  bool statusDebetKredit = false;
  String idTipe;
  String namaTipe;
  String levelAkun;

  String enableAdd = '1';
  String enableEdit = '1';
  String enableDelete = '1';
  String enableSave = '0';
  String enableBatal = '0';

  bool enabledForm = true;
  String formType = 'N';

  var sampleTree = TreeNode(key: "CHART OF ACCOUNT");

  void getAuth() async {
    loadStart();

    var response = await http.get(
        Uri.parse("$urlAddress/get-permission/$menuKode/$username"),
        headers: {
          'pte-token': kodeToken,
        });

    var auth = json.decode(response.body);
    setState(() {
      authAddx = auth['AUTH_ADDX'];
      authEdit = auth['AUTH_EDIT'];
      authDelt = auth['AUTH_DELT'];
      authInqu = auth['AUTH_INQU'];
      authPrnt = auth['AUTH_PRNT'];
      authExpt = auth['AUTH_EXPT'];
    });
  }

  getAllAccount() async {
    var response =
        await http.get(Uri.parse("$urlAddress/finance/all-account"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listAccount = dataStatus;
    });
  }

  getAllKategoriAccount() async {
    var response = await http
        .get(Uri.parse("$urlAddress/setup/kategori-account"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKategoriAccount = dataStatus;
    });
  }

  void getMataUang() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/getmatauang"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listMataUang = data;
    });
  }

  void getAccountTreeview() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/gettree-account"), headers: {
      'pte-token': kodeToken,
    });

    List<dynamic> variabel = json.decode(response.body);

    final listTreeView = [];

    for (var i = 0; i < variabel.length; i++) {
      List<Map<String, dynamic>> child =
          List.from(variabel[i]['children'] as List);

      listTreeView
          .add(TreeNode(key: variabel[i]['COAX_LBEL'], data: variabel[i])
            ..addAll(child.isNotEmpty
                ? child.map(
                    (e) {
                      return setTreeView(e);
                    },
                  )
                : []));
    }

    setState(() {
      sampleTree = TreeNode(key: "CHART OF ACCOUNT")
        ..addAll(listTreeView.map((e) {
          return e;
        }));
    });

    loadEnd();
  }

  setTreeView(children) {
    List<dynamic> data = [children];
    if (data.length != 0) {
      for (var i = 0; i < data.length; i++) {
        List<Map<String, dynamic>> child =
            List.from(data[i]['children'] as List);

        return TreeNode(key: data[i]['COAX_LBEL'], data: data[i])
          ..addAll(child.isNotEmpty
              ? child.map(
                  (e) {
                    return setTreeView(e);
                  },
                )
              : []);
      }
    }
  }

  @override
  void initState() {
    getAuth();
    getAllAccount();
    getMataUang();
    getAllKategoriAccount();
    getAccountTreeview();
    super.initState();
  }

  // INPUT
  Widget inputKodeAccount() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(label: Text('Kode Account')),
      initialValue: kodeAkun ?? 'Auto Generate',
    );
  }

  Widget inputNamaAccount() {
    return TextFormField(
      readOnly: enabledForm,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text('Nama Account', style: TextStyle(color: Colors.red))),
      onChanged: (value) {
        namaAkun = value;
      },
      initialValue: namaAkun,
      validator: (value) {
        if (value.isEmpty) {
          return "Nama Akun masih kosong !";
        }
      },
    );
  }

  Widget inputIndukAccount() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        enabled: !enabledForm,
        mode: Mode.BOTTOM_SHEET,
        label: "Induk Account",
        items: listAccount,
        onChanged: (value) {
          indukAkun = value['KDXX_PARENT'];
          descIndukAkun = value['COAX_LBEL'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['COAX_LBEL'].toString() ?? '-'),
        ),
        dropdownBuilder: (context, selectedItem) => Text(descIndukAkun ?? ""),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputStatusAktif() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        Checkbox(
            value: statusAktif,
            onChanged: (value) {
              if (enabledForm == false) {
                setState(() {
                  statusAktif = !statusAktif;
                });
              }
            }),
        const Text('Status Aktif')
      ]),
    );
  }

  Widget inputKategoriAccount() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        enabled: !enabledForm,
        mode: Mode.BOTTOM_SHEET,
        label: "Kategori Account",
        items: listKategoriAccount,
        onChanged: (value) {
          kategoriAkun = value['KDXX_KATC'];
          descKategoriAkun = value['NAMA_KATC'] + ' - ' + value['JENS_KATC'];
          dk = value['JENS_KATC'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_KATC'] + ' - ' + item['JENS_KATC'] ?? '-'),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            descKategoriAkun ?? "Kategori Account",
            style: TextStyle(
                color: descKategoriAkun == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputMataUang() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        enabled: !enabledForm,
        label: "Mata Uang",
        mode: Mode.MENU,
        items: listMataUang,
        onChanged: (value) {
          mataUang = value["CODD_DESC"];
          idMataUang = value["CODD_VALU"];
        },
        selectedItem: "Pilih Mata Uang",
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
          mataUang ?? "Pilih Mata Uang",
          style: TextStyle(color: mataUang == null ? Colors.red : Colors.black),
        ),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Mata Uang") {
            return "Mata Uang masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputBudget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        Checkbox(
            value: statusBudget,
            onChanged: (value) {
              if (enabledForm == false) {
                setState(() {
                  statusBudget = !statusBudget;
                });
              }
            }),
        const Text('Budget')
      ]),
    );
  }

  Widget inputDebetKredit() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        Checkbox(
            value: statusDebetKredit,
            onChanged: (value) {
              if (enabledForm == false) {
                setState(() {
                  statusDebetKredit = !statusDebetKredit;
                });
              }
            }),
        const Text('Debet/Kredit')
      ]),
    );
  }

  Widget inputTipeAccount() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        enabled: !enabledForm,
        label: "Tipe Account",
        mode: Mode.MENU,
        items: const ["Judul", "Transaksi"],
        onChanged: (value) {
          if (value == "Pria") {
            idTipe = '1';
            namaTipe = value;
          } else {
            idTipe = '2';
            namaTipe = value;
          }
        },
        dropdownBuilder: (context, selectedItem) => Text(
            namaTipe ?? "Pilih Tipe Account",
            style:
                TextStyle(color: namaTipe == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Tipe Account") {
            return "Tipe masih kosong !";
          }
        },
      ),
    );
  }

  // INPUT

  Widget cmdTambah() {
    return ElevatedButton.icon(
      onPressed: () async {
        setState(() {
          formType = 'T';
          enabledForm = false;

          enableAdd = '0';
          enableEdit = '0';
          enableDelete = '0';
          enableSave = '1';
          enableBatal = '1';

          indukAkun = kodeAkun;
          descIndukAkun = kodeAkun != null ? "$kodeAkun - $namaAkun" : null;
          kodeAkun = null;
          statusAktif = true;
          namaAkun = null;
          kategoriAkun = null;
          descKategoriAkun = null;
          dk = null;
          mataUang = null;
          idMataUang = null;
          statusBudget = false;
          statusDebetKredit = false;
          idTipe = null;
          namaTipe = null;
          levelAkun = null;
        });
      },
      icon: const Icon(Icons.add),
      style: fncButtonAuthStyle(enableAdd, context),
      label: fncLabelButtonStyle('Tambah', context),
    );
  }

  Widget cmdEdit() {
    return ElevatedButton.icon(
      onPressed: () async {
        if (kodeAkun != null) {
          setState(() {
            formType = 'E';
            enabledForm = false;

            enableAdd = '0';
            enableEdit = '0';
            enableDelete = '0';
            enableSave = '1';
            enableBatal = '1';
          });
        } else {
          showDialog(
              context: context,
              builder: (context) => const ModalInfo(
                    deskripsi: "Pilih Account Sebelum Mengedit",
                  ));
        }
      },
      icon: const Icon(Icons.edit_outlined),
      style: fncButtonAuthStyle(enableEdit, context),
      label: fncLabelButtonStyle('Edit', context),
    );
  }

  Widget cmdHapus() {
    return ElevatedButton.icon(
      onPressed: () async {
        if (kodeAkun != null) {
          showDialog(
              context: context,
              builder: (context) => ModalHapusAccount(idAccount: kodeAkun));
        } else {
          showDialog(
              context: context,
              builder: (context) => const ModalInfo(
                    deskripsi: "Pilih Account Sebelum Menghapus",
                  ));
        }
      },
      icon: const Icon(Icons.delete_outline),
      style: fncButtonAuthStyle(enableDelete, context),
      label: fncLabelButtonStyle('Hapus', context),
    );
  }

  Widget cmdSave() {
    return ElevatedButton.icon(
      onPressed: () async {
        // print(kodeAkun);
        // print(namaAkun);
        // print(indukAkun);
        // print(kategoriAkun);
        // print(dk);
        // print(idMataUang);
        // print(statusBudget == true ? '1' : '0');
        // print(statusDebetKredit == true ? '1' : '0');
        // print(idTipe);
        // print(levelAkun);

        if (formType == 'T') {
          var id = indukAkun ?? 'KOSONG';
          var response1 = await http.get(
              Uri.parse("$urlAddress/finance/master-account/generate-kode/$id"),
              headers: {
                'pte-token': kodeToken,
              });
          dynamic body1 = json.decode(response1.body);
          kodeAkun = body1['KDXX_COAX'];
          levelAkun = body1['LVEL_COAX'];

          // print(kodeAkun);
          // print(namaAkun);
          // print(indukAkun);
          // print(kategoriAkun);
          // print(idMataUang);
          // print(statusBudget == true ? '1' : '0');
          // print(statusDebetKredit == true ? '1' : '0');
          // print(idTipe);
          // print(dk);
          // print(levelAkun);

          HttpAccount.saveAccount(
            kodeAkun,
            namaAkun,
            indukAkun ?? '',
            kategoriAkun,
            idMataUang,
            statusBudget == true ? '1' : '0',
            statusDebetKredit == true ? '1' : '0',
            idTipe,
            dk,
            levelAkun,
          ).then(
            (value) {
              if (value.status == true) {
                showDialog(
                    context: context,
                    builder: (context) => const ModalSaveSuccess());

                menuController.changeActiveitemTo('Master Account');
                navigationController.navigateTo('/finance/master-account');
              } else {
                showDialog(
                    context: context,
                    builder: (context) => const ModalSaveFail());
              }
            },
          );
        } else {
          HttpAccount.updateAccount(
            kodeAkun,
            namaAkun,
            indukAkun,
            kategoriAkun,
            idMataUang,
            statusBudget == true ? '1' : '0',
            statusDebetKredit == true ? '1' : '0',
            idTipe,
            dk,
            levelAkun,
          ).then(
            (value) {
              if (value.status == true) {
                showDialog(
                    context: context,
                    builder: (context) => const ModalSaveSuccess());

                menuController.changeActiveitemTo('Master Account');
                navigationController.navigateTo('/finance/master-account');
              } else {
                showDialog(
                    context: context,
                    builder: (context) => const ModalSaveFail());
              }
            },
          );
        }
      },
      icon: const Icon(Icons.save_outlined),
      style: fncButtonAuthStyle(enableSave, context),
      label: fncLabelButtonStyle('Save', context),
    );
  }

  Widget cmdBatal() {
    return ElevatedButton.icon(
      onPressed: () async {
        setState(() {
          formType = 'N';
          enabledForm = true;

          enableAdd = '1';
          enableEdit = '1';
          enableDelete = '1';
          enableSave = '0';
          enableBatal = '0';
        });
      },
      icon: const Icon(Icons.restart_alt),
      style: fncButtonAuthStyle(enableBatal, context),
      label: fncLabelButtonStyle('Batal', context),
    );
  }

  Widget cmdPrint() {
    return ElevatedButton.icon(
      onPressed: () async {},
      icon: const Icon(Icons.print_outlined),
      style: fncButtonAuthStyle(authDelt, context),
      label: fncLabelButtonStyle('Print', context),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final GlobalKey<TreeViewState> treeKey = GlobalKey<TreeViewState>();
    final screenHeight = MediaQuery.of(context).size.height;
    final styleTreeText = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey[900]);
    final formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: 'Finance - ${menuController.activeItem.value}',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 6),
                            color: lightGrey.withOpacity(0.2),
                            blurRadius: 12)
                      ],
                    ),
                    child: Row(
                      children: [
                        cmdTambah(),
                        const SizedBox(width: 5),
                        cmdEdit(),
                        const SizedBox(width: 5),
                        cmdHapus()
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: screenHeight * 0.72,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 6),
                            color: lightGrey.withOpacity(0.2),
                            blurRadius: 12)
                      ],
                    ),
                    child: TreeView.simple(
                      key: treeKey,
                      tree: sampleTree,
                      expansionIndicator: ExpansionIndicator.RightUpChevron,
                      builder: (context, level, item) => Card(
                          color: Colors.grey[200],
                          child: ListTile(
                              onLongPress: () {
                                if (formType != 'T') {
                                  setState(() {
                                    kodeAkun =
                                        item.data['KDXX_COAX'].toString();
                                    namaAkun =
                                        item.data['DESKRIPSI'].toString();
                                    indukAkun =
                                        item.data['KDXX_PARENT'].toString();
                                    descIndukAkun =
                                        item.data['PRENT_LBEL'] ?? '';
                                    kategoriAkun = item.data['KATX_COAX'];
                                    descKategoriAkun = item.data['NAMA_KATC'] +
                                            ' - ' +
                                            item.data['JENS_KATC'] ??
                                        '';
                                    mataUang = item.data['CODD_DESC'];
                                    idMataUang = item.data['CODD_VALU'];
                                    statusBudget = item.data['BUDGET'] == '1'
                                        ? true
                                        : false;
                                    statusDebetKredit =
                                        item.data['STAS_DKXX'] == '1'
                                            ? true
                                            : false;
                                    idTipe = item.data['TYPE_COAX'];
                                    namaTipe = item.data['TYPE_COAX'] == '1'
                                        ? 'Judul'
                                        : 'Transaksi';
                                    statusAktif = item.data['STAS_AKTF'] == '1'
                                        ? true
                                        : false;
                                    levelAkun =
                                        item.data['COAX_LVEL'].toString();
                                    dk = item.data['COAX_DKXX'].toString();
                                  });
                                }
                              },
                              title: Text(
                                item.key,
                                style: styleTreeText,
                              ),
                              leading: Icon(
                                item.level == 0
                                    ? Icons.folder_copy_outlined
                                    : Icons.arrow_circle_right_outlined,
                                color: item.level == 0
                                    ? Colors.orange[900]
                                    : Colors.green[700],
                              ))),
                    ),
                  ),
                ],
              )),
              const SizedBox(width: 5),
              Container(
                width: 700,
                height: screenHeight * 0.82,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 6),
                        color: lightGrey.withOpacity(0.2),
                        blurRadius: 12)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        cmdSave(),
                        const SizedBox(width: 5),
                        cmdBatal(),
                        Expanded(child: Container()),
                        cmdPrint()
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                        formType == 'T' || formType == 'N'
                            ? "Tambah Data"
                            : "Edit Data",
                        style: fncTextHeaderModalStyle(context)),
                    const SizedBox(height: 5),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 500, child: inputKodeAccount()),
                              const SizedBox(width: 10),
                              inputStatusAktif()
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(width: 670, child: inputNamaAccount()),
                          const SizedBox(height: 10),
                          SizedBox(width: 670, child: inputIndukAccount()),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 330, child: inputKategoriAccount()),
                              const SizedBox(width: 10),
                              SizedBox(width: 330, child: inputMataUang()),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              inputBudget(),
                              const SizedBox(width: 270),
                              inputDebetKredit()
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(width: 670, child: inputTipeAccount()),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
