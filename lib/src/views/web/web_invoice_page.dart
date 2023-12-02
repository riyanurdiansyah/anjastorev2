import 'package:anjastore/config/app_route_name.dart';
import 'package:anjastore/src/controllers/controller.dart';
import 'package:anjastore/src/models/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/utils.dart';
import 'widgets/custom_pagination.dart';

class WebInvoicePage extends StatelessWidget {
  WebInvoicePage({super.key});

  final _iC = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                color: colorPrimaryDark.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Invoice",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Customer",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Tgl. Masuk",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Tgl. Tempo",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Total",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "DP",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Sisa",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 130,
                  ),
                ],
              ),
            ),
            Obx(
              () {
                List<InvoiceM> invoices = [];
                if (_iC.invoicesSearch.isNotEmpty ||
                    _iC.tcSearch.text.isNotEmpty) {
                  invoices = _iC.invoicesSearch
                      .where((e) => e.page == _iC.page.value)
                      .toList();
                } else {
                  invoices = _iC.invoices
                      .where((e) => e.page == _iC.page.value)
                      .toList();
                }

                return Column(
                  children: List.generate(
                    invoices.length,
                    (i) => Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  invoices[i].noInvoice,
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  _iC.customers
                                      .firstWhere(
                                          (e) => e.id == invoices[i].idCustomer)
                                      .name,
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(invoices[i].tanggalTerima))} WIB",
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(invoices[i].jatuhTempo))} WIB",
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  AppCurrency.numberToRupiah(
                                      invoices[i].totalHarga),
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  AppCurrency.numberToRupiah(invoices[i].dp),
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  AppCurrency.numberToRupiah(
                                      invoices[i].sisaTagihan),
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: InkWell(
                                  onTap: () => AppDialog.dialogAddInvoice(
                                    oldCustomer: _iC.customers.firstWhere(
                                      (e) => e.id == invoices[i].idCustomer,
                                    ),
                                    oldInvoice: invoices[i],
                                  ),
                                  child: const Icon(
                                    Icons.mode_edit_rounded,
                                    size: 20,
                                    color: colorPrimaryDark,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 2,
                                height: 30,
                                color: Colors.grey.shade200,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: InkWell(
                                  onTap: () => AppDialog.dialogDanger(
                                    title: "Hapus",
                                    subtitle: "Yakin ingin menghapus data ini?",
                                    ontap: () =>
                                        _iC.deleteInvoice(invoices[i].id),
                                  ),
                                  child: const Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 2,
                                height: 30,
                                color: Colors.grey.shade200,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: InkWell(
                                  onTap: () {
                                    if (kDebugMode) {
                                      launchUrl(Uri.parse(
                                          'http://localhost:57264/#/invoice/${invoices[i].kodeInvoice}'));
                                    } else {
                                      launchUrl(Uri.parse(
                                          'https://anjastore.vercel.app/#/invoice/${invoices[i].kodeInvoice}'));
                                    }
                                  },
                                  child: const Icon(
                                    Icons.double_arrow_rounded,
                                    color: colorPrimaryDark,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 0.6,
                          width: double.infinity,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 45,
                    width: size.width / 6,
                    child: TextFormField(
                      controller: _iC.tcSearch,
                      onChanged: _iC.onSearchInvoices,
                      style: GoogleFonts.poppins(
                        height: 1.4,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "Cari invoice disini..",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          wordSpacing: 4,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(() {
                    List<InvoiceM> invoices = [];
                    if (_iC.invoicesSearch.isNotEmpty ||
                        _iC.tcSearch.text.isNotEmpty) {
                      invoices = _iC.invoicesSearch;
                    } else {
                      invoices = _iC.invoices;
                    }
                    return CustomPagination(
                      currentPage: _iC.page.value,
                      totalPage: (invoices.length / 8).ceil() == 0
                          ? 1
                          : (invoices.length / 8).ceil(),
                      onPageChanged: _iC.onChangepage,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    );
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => AppDialog.dialogAddInvoice(),
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
