import 'package:anjastore/src/models/model.dart';
import 'package:anjastore/utils/utils.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  static void createPdf({
    required InvoiceM invoice,
    required CustomerM customer,
  }) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Container(
            color: PdfColor.fromHex(Colors.white.toHex()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Column(
                  children: [
                    pw.SizedBox(
                      height: 18,
                    ),
                    pw.Row(
                      children: [
                        pw.Text(
                          "Anjas Group Indonesia",
                          style: pw.TextStyle(
                            color: PdfColor.fromHex(
                              "#000000",
                            ),
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        pw.Spacer(),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              "INVOICE",
                              style: pw.TextStyle(
                                color: PdfColor.fromHex(
                                  "#000000",
                                ),
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            pw.SizedBox(
                              height: 8,
                            ),
                            pw.Text(
                              invoice.noInvoice,
                              style: pw.TextStyle(
                                color: PdfColor.fromHex(
                                  "#28eb5d",
                                ),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    pw.SizedBox(
                      height: 25,
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            "DITERBITKAN ATAS NAMA",
                            style: pw.TextStyle(
                              color: PdfColor.fromHex(
                                "#000000",
                              ),
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            "UNTUK",
                            style: pw.TextStyle(
                              color: PdfColor.fromHex(
                                "#000000",
                              ),
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 14,
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Row(
                            children: [
                              pw.Text(
                                "Penjual ",
                                style: pw.TextStyle(
                                  color: PdfColor.fromHex(
                                    "#828282",
                                  ),
                                  fontSize: 10,
                                ),
                              ),
                              pw.SizedBox(
                                width: 20,
                              ),
                              pw.Text(
                                ": Anjastore",
                                style: pw.TextStyle(
                                  color: PdfColor.fromHex(
                                    "#000000",
                                  ),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 5,
                                child: pw.Text(
                                  "Pembeli",
                                  style: pw.TextStyle(
                                    color: PdfColor.fromHex(
                                      "#828282",
                                    ),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                flex: 8,
                                child: pw.Text(
                                  ": ${customer.name}",
                                  style: pw.TextStyle(
                                    color: PdfColor.fromHex(
                                      "#000000",
                                    ),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.SizedBox(),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 5,
                                child: pw.Text(
                                  "Tanggal",
                                  style: pw.TextStyle(
                                    color: PdfColor.fromHex(
                                      "#828282",
                                    ),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                flex: 8,
                                child: pw.Text(
                                  ": ${DateFormat.yMMMMd('id').format(DateTime.parse(invoice.tanggalTerima))}",
                                  style: pw.TextStyle(
                                    color: PdfColor.fromHex(
                                      "#000000",
                                    ),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.SizedBox(),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 5,
                                child: pw.Text(
                                  "Jatuh Tempo",
                                  style: pw.TextStyle(
                                    color: PdfColor.fromHex(
                                      "#828282",
                                    ),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                flex: 8,
                                child: pw.Text(
                                  ": ${DateFormat.yMMMMd('id').format(DateTime.parse(invoice.jatuhTempo))}",
                                  style: pw.TextStyle(
                                    color: PdfColor.fromHex(
                                      "#000000",
                                    ),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 45,
                    ),
                    pw.Container(
                      height: 2,
                      color: PdfColor.fromHex("#000000"),
                    ),
                    pw.SizedBox(
                      height: 15,
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            "INFO PRODUK",
                            style: pw.TextStyle(
                              color: PdfColor.fromHex(
                                "#000000",
                              ),
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 8,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Row(
                            children: [
                              pw.Container(
                                width: 60,
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                  "JUMLAH",
                                  style: pw.TextStyle(
                                    color: PdfColor.fromHex(
                                      "#000000",
                                    ),
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                              pw.SizedBox(
                                width: 14,
                              ),
                              pw.Expanded(
                                child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    "HARGA SATUAN",
                                    style: pw.TextStyle(
                                      color: PdfColor.fromHex(
                                        "#000000",
                                      ),
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Align(
                                  alignment: pw.Alignment.centerRight,
                                  child: pw.Text(
                                    "TOTAL HARGA",
                                    style: pw.TextStyle(
                                      color: PdfColor.fromHex(
                                        "#000000",
                                      ),
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 15,
                    ),
                    pw.Container(
                      height: 2,
                      color: PdfColor.fromHex("#000000"),
                    ),
                    pw.Column(
                      children: List.generate(
                        invoice.items.length,
                        (index) => pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 10),
                          child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Expanded(
                                flex: 3,
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      invoice.items[index].namaProduk,
                                      style: pw.TextStyle(
                                        color: PdfColor.fromHex(
                                          "#000000",
                                        ),
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 9,
                                        letterSpacing: 1.25,
                                      ),
                                    ),
                                    pw.Text(
                                      "detail : ${invoice.items[index].deskripsi.toLowerCase()}",
                                      style: pw.TextStyle(
                                        color: PdfColor.fromHex(
                                          "#828282",
                                        ),
                                        fontSize: 8,
                                        letterSpacing: 1.05,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Row(
                                  children: [
                                    pw.Container(
                                      width: 60,
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        invoice.items[index].qty.toString(),
                                        style: pw.TextStyle(
                                          color: PdfColor.fromHex(
                                            "#000000",
                                          ),
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      width: 14,
                                    ),
                                    pw.Expanded(
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          AppCurrency.numberToRupiah(
                                              invoice.items[index].satuanHarga),
                                          style: pw.TextStyle(
                                            color: PdfColor.fromHex(
                                              "#000000",
                                            ),
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 8,
                                          ),
                                        ),
                                      ),
                                    ),
                                    pw.Expanded(
                                      child: pw.Align(
                                        alignment: pw.Alignment.centerRight,
                                        child: pw.Text(
                                          AppCurrency.numberToRupiah(
                                              invoice.items[index].jumlahHarga),
                                          style: pw.TextStyle(
                                            color: PdfColor.fromHex(
                                              "#000000",
                                            ),
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 8,
                                          ),
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
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Container(
                      height: 1.5,
                      color: PdfColor.fromHex("#f0f0f0"),
                    ),
                    pw.SizedBox(
                      height: 14,
                    ),
                    pw.Column(
                      children: [
                        pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 3,
                              child: pw.SizedBox(),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Row(
                                children: [
                                  pw.Expanded(
                                    flex: 3,
                                    child: pw.Text(
                                      "TOTAL HARGA (${invoice.items.length} Barang)",
                                      style: pw.TextStyle(
                                        color: PdfColor.fromHex(
                                          "#000000",
                                        ),
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 2,
                                    child: pw.Align(
                                      alignment: pw.Alignment.centerRight,
                                      child: pw.Text(
                                        AppCurrency.numberToRupiah(
                                            invoice.totalHarga),
                                        style: pw.TextStyle(
                                          color: PdfColor.fromHex(
                                            "#000000",
                                          ),
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 3,
                              child: pw.SizedBox(),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Row(
                                children: [
                                  pw.Expanded(
                                    flex: 3,
                                    child: pw.Text(
                                      "Uang Muka (DP)",
                                      style: pw.TextStyle(
                                        color: PdfColor.fromHex(
                                          "#828282",
                                        ),
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 2,
                                    child: pw.Align(
                                      alignment: pw.Alignment.centerRight,
                                      child: pw.Text(
                                        AppCurrency.numberToRupiah(invoice.dp),
                                        style: pw.TextStyle(
                                          color: PdfColor.fromHex(
                                            "#828282",
                                          ),
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 3,
                              child: pw.SizedBox(),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                color: PdfColor.fromHex("#f0f0f0"),
                                width: double.infinity,
                                height: 1.5,
                                child: pw.LayoutBuilder(
                                  builder: (context, constraint) => pw.Flex(
                                    mainAxisSize: pw.MainAxisSize.max,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    direction: pw.Axis.horizontal,
                                    children: List.generate(
                                      (constraint!.constrainWidth() / 8)
                                          .floor(),
                                      (index) => pw.SizedBox(
                                        width: 4,
                                        height: 2,
                                        child: pw.DecoratedBox(
                                          decoration: pw.BoxDecoration(
                                            color: PdfColor.fromHex("#f0f0f0"),
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
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 3,
                              child: pw.SizedBox(),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Row(
                                children: [
                                  pw.Expanded(
                                    flex: 3,
                                    child: pw.Text(
                                      "TOTAL TAGIHAN",
                                      style: pw.TextStyle(
                                        color: PdfColor.fromHex(
                                          "#000000",
                                        ),
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 2,
                                    child: pw.Align(
                                      alignment: pw.Alignment.centerRight,
                                      child: pw.Text(
                                        AppCurrency.numberToRupiah(
                                            invoice.sisaTagihan),
                                        style: pw.TextStyle(
                                          color: PdfColor.fromHex(
                                            "#000000",
                                          ),
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 8,
                                        ),
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
                  ],
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Container(
                  height: 1.5,
                  color: PdfColor.fromHex("#f0f0f0"),
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Invoice ini sah dan diproses oleh komputer.",
                      style: pw.TextStyle(
                        color: PdfColor.fromHex(
                          "#000000",
                        ),
                        fontSize: 7,
                        letterSpacing: 1.1,
                      ),
                    ),
                    pw.RichText(
                      text: pw.TextSpan(
                        text: "Silahkan hubungi ",
                        style: pw.TextStyle(
                          letterSpacing: 1.1,
                          fontSize: 7,
                          color: PdfColor.fromHex("#000000"),
                        ),
                        children: [
                          pw.TextSpan(
                            text: 'Anjastore Care ',
                            style: pw.TextStyle(
                              letterSpacing: 1.1,
                              fontSize: 7,
                              color: PdfColor.fromHex("#28eb5d"),
                            ),
                          ),
                          pw.TextSpan(
                            text: 'apabila kamu membutuhkan bantuan. ',
                            style: pw.TextStyle(
                              letterSpacing: 1.1,
                              fontSize: 7,
                              color: PdfColor.fromHex("#000000"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    final uin = await pdf.save();
    await FileSaver.instance.saveFile(
      name: invoice.noInvoice,
      ext: 'pdf',
      bytes: uin,
      mimeType: MimeType.pdf,
    );
  }
}
