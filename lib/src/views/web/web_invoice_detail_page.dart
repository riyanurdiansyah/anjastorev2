import 'package:anjastore/src/controllers/invoice_detail_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../service/pdf_service.dart';
import '../../../utils/utils.dart';

class WebInvoiceDetailPage extends StatelessWidget {
  WebInvoiceDetailPage({super.key});

  final _iC = Get.find<InvoiceDetailController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Obx(
        () {
          if (_iC.messageError.value.isNotEmpty) {
            return Center(
              child: AppTextNormal.labelW600(
                "Invoice tidak ditemukan",
                18,
                colorPrimaryDark,
              ),
            );
          }
          if (_iC.invoices.value == invoiceEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitRotatingCircle(
                  color: colorPrimaryDark,
                  size: 50.0,
                ),
                const SizedBox(
                  height: 25,
                ),
                AppTextNormal.labelW600(
                  "Loading...",
                  14,
                  Colors.grey.shade600,
                ),
              ],
            );
          }

          return Center(
            child: Container(
              color: Colors.white,
              width: size.width / 2.25,
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      height: kToolbarHeight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {
                                PdfService.createPdf(
                                  invoice: _iC.invoices.value,
                                  customer: _iC.customers.firstWhere(
                                    (e) =>
                                        e.id == _iC.invoices.value.idCustomer,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: AppTextNormal.labelW600(
                                "Cetak",
                                14,
                                Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 2,
                      color: Colors.grey.shade200,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              AppTextNormal.labelW600(
                                "Anjas Group Indonesia",
                                24,
                                Colors.black,
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AppTextNormal.labelBold(
                                    "INVOICE",
                                    18,
                                    Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  AppText.labelW500(
                                    _iC.invoices.value.noInvoice,
                                    16,
                                    Colors.green,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: AppTextNormal.labelW600(
                                  "DITERBITKAN ATAS NAMA",
                                  14,
                                  Colors.black,
                                  letterSpacing: 1.4,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: AppTextNormal.labelW600(
                                  "UNTUK",
                                  14,
                                  Colors.black,
                                  letterSpacing: 1.4,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    AppTextNormal.labelW600(
                                      "Penjual ",
                                      12,
                                      Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    AppTextNormal.labelW600(
                                      ": Anjastore",
                                      12,
                                      Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: AppTextNormal.labelW600(
                                        "Pembeli",
                                        12,
                                        Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: AppTextNormal.labelW600(
                                        ": ${_iC.customers.firstWhere((e) => e.id == _iC.invoices.value.idCustomer).name}",
                                        12,
                                        Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: AppTextNormal.labelW600(
                                        "Tanggal Pembelian",
                                        12,
                                        Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: AppTextNormal.labelW600(
                                        ": ${DateFormat.yMMMMd('id').add_jm().format(DateTime.parse(_iC.invoices.value.tanggalTerima))} WIB",
                                        12,
                                        Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: AppTextNormal.labelW600(
                              "INFO PRODUK",
                              14,
                              Colors.black,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  alignment: Alignment.center,
                                  child: AppTextNormal.labelW600(
                                    "JUMLAH",
                                    14,
                                    Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AppTextNormal.labelW600(
                                      "HARGA SATUAN",
                                      14,
                                      Colors.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: AppTextNormal.labelW600(
                                      "TOTAL HARGA",
                                      14,
                                      Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    Column(
                      children: List.generate(
                        _iC.invoices.value.items.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextNormal.labelW600(
                                      _iC.invoices.value.items[index]
                                          .namaProduk,
                                      16,
                                      Colors.green,
                                      letterSpacing: 1.4,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    AppTextNormal.labelW500(
                                      "Detail : ${_iC.invoices.value.items[index].deskripsi}",
                                      10,
                                      Colors.grey.shade600,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      alignment: Alignment.center,
                                      child: AppTextNormal.labelW600(
                                        _iC.invoices.value.items[index].qty
                                            .toString(),
                                        14,
                                        Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: AppTextNormal.labelW600(
                                          AppCurrency.numberToRupiah(_iC
                                              .invoices
                                              .value
                                              .items[index]
                                              .satuanHarga),
                                          14,
                                          Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: AppTextNormal.labelW600(
                                          AppCurrency.numberToRupiah(
                                            _iC.invoices.value.items[index]
                                                .jumlahHarga,
                                          ),
                                          14,
                                          Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1.5,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: AppTextNormal.labelW600(
                                        "TOTAL HARGA (${_iC.invoices.value.items.length} Barang)",
                                        12,
                                        Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: AppTextNormal.labelW600(
                                          AppCurrency.numberToRupiah(
                                              _iC.invoices.value.totalHarga),
                                          14,
                                          Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: AppTextNormal.labelW600(
                                        "Uang Muka (DP)",
                                        12,
                                        Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: AppTextNormal.labelW600(
                                          AppCurrency.numberToRupiah(
                                              _iC.invoices.value.dp),
                                          14,
                                          Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade200,
                                  width: double.infinity,
                                  height: 2,
                                  child: LayoutBuilder(
                                    builder: (context, constraint) => Flex(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      direction: Axis.horizontal,
                                      children: List.generate(
                                        (constraint.constrainWidth() / 8)
                                            .floor(),
                                        (index) => const SizedBox(
                                          width: 4,
                                          height: 2,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: AppTextNormal.labelW600(
                                        "TOTAL TAGIHAN",
                                        12,
                                        Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: AppTextNormal.labelW600(
                                          AppCurrency.numberToRupiah(
                                              _iC.invoices.value.sisaTagihan),
                                          14,
                                          Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1.5,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextNormal.labelW500(
                            "Invoice ini sah dan diproses oleh komputer.",
                            12,
                            Colors.black54,
                            letterSpacing: 1.1,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Silahkan hubungi ",
                              style: GoogleFonts.sourceSans3(
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Anjastore Care ',
                                  style: GoogleFonts.sourceSans3(
                                    letterSpacing: 1.1,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                                TextSpan(
                                  text: 'apabila kamu membutuhkan bantuan. ',
                                  style: GoogleFonts.sourceSans3(
                                    letterSpacing: 1.1,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
