import 'dart:convert';

import 'package:anjastore/src/models/invoice_item_m.dart';

InvoiceM invoiceMFromJson(String str) => InvoiceM.fromJson(json.decode(str));

String invoiceMToJson(InvoiceM data) => json.encode(data.toJson());

class InvoiceM {
  final int dp;
  final String emailCustomer;
  final String id;
  final String idCustomer;
  final int no;
  final String noInvoice;
  final int sisaTagihan;
  final String jatuhTempo;
  final String tanggalTerima;
  final int totalHarga;
  final List<InvoiceItemM> items;

  InvoiceM({
    required this.dp,
    required this.emailCustomer,
    required this.id,
    required this.idCustomer,
    required this.no,
    required this.noInvoice,
    required this.sisaTagihan,
    required this.jatuhTempo,
    required this.tanggalTerima,
    required this.totalHarga,
    required this.items,
  });

  InvoiceM copyWith({
    int? dp,
    String? emailCustomer,
    String? id,
    String? idCustomer,
    int? no,
    String? noInvoice,
    int? sisaTagihan,
    String? jatuhTempo,
    String? tanggalTerima,
    int? totalHarga,
    List<InvoiceItemM>? items,
  }) =>
      InvoiceM(
        dp: dp ?? this.dp,
        emailCustomer: emailCustomer ?? this.emailCustomer,
        id: id ?? this.id,
        idCustomer: idCustomer ?? this.idCustomer,
        no: no ?? this.no,
        noInvoice: noInvoice ?? this.noInvoice,
        sisaTagihan: sisaTagihan ?? this.sisaTagihan,
        jatuhTempo: jatuhTempo ?? this.jatuhTempo,
        tanggalTerima: tanggalTerima ?? this.tanggalTerima,
        totalHarga: totalHarga ?? this.totalHarga,
        items: items ?? this.items,
      );

  factory InvoiceM.fromJson(Map<String, dynamic> json) => InvoiceM(
        dp: json["dp"],
        emailCustomer: json["email_customer"],
        id: json["id"],
        idCustomer: json["id_customer"],
        no: json["no"],
        noInvoice: json["no_invoice"],
        sisaTagihan: json["sisa_tagihan"],
        jatuhTempo: json["jatuh_tempo"],
        tanggalTerima: json["tanggal_terima"],
        totalHarga: json["total_harga"],
        items: List<InvoiceItemM>.from(
            json["items"].map((x) => InvoiceItemM.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dp": dp,
        "email_customer": emailCustomer,
        "id": id,
        "id_customer": idCustomer,
        "no": no,
        "no_invoice": noInvoice,
        "sisa_tagihan": sisaTagihan,
        "jatuh_tempo": jatuhTempo,
        "tanggal_terima": tanggalTerima,
        "total_harga": totalHarga,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}