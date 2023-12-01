import 'dart:convert';

import 'package:anjastore/src/models/invoice_item_m.dart';
import 'package:equatable/equatable.dart';

InvoiceM invoiceMFromJson(String str) => InvoiceM.fromJson(json.decode(str));

String invoiceMToJson(InvoiceM data) => json.encode(data.toJson());

class InvoiceM extends Equatable {
  final int dp;
  final String id;
  final String idCustomer;
  final int no;
  final String noInvoice;
  final int sisaTagihan;
  final String jatuhTempo;
  final String tanggalTerima;
  final int totalHarga;
  final List<InvoiceItemM> items;
  final int page;

  const InvoiceM({
    required this.dp,
    required this.id,
    required this.idCustomer,
    required this.no,
    required this.noInvoice,
    required this.sisaTagihan,
    required this.jatuhTempo,
    required this.tanggalTerima,
    required this.totalHarga,
    required this.items,
    required this.page,
  });

  InvoiceM copyWith({
    int? dp,
    String? id,
    String? idCustomer,
    int? no,
    String? noInvoice,
    int? sisaTagihan,
    String? jatuhTempo,
    String? tanggalTerima,
    int? totalHarga,
    List<InvoiceItemM>? items,
    int? page,
  }) =>
      InvoiceM(
        dp: dp ?? this.dp,
        id: id ?? this.id,
        idCustomer: idCustomer ?? this.idCustomer,
        no: no ?? this.no,
        noInvoice: noInvoice ?? this.noInvoice,
        sisaTagihan: sisaTagihan ?? this.sisaTagihan,
        jatuhTempo: jatuhTempo ?? this.jatuhTempo,
        tanggalTerima: tanggalTerima ?? this.tanggalTerima,
        totalHarga: totalHarga ?? this.totalHarga,
        items: items ?? this.items,
        page: page ?? this.page,
      );

  factory InvoiceM.fromJson(Map<String, dynamic> json) => InvoiceM(
        dp: json["dp"],
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
        page: json["page"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "dp": dp,
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

  @override
  List<Object?> get props => [
        dp,
        id,
        idCustomer,
        no,
        noInvoice,
        sisaTagihan,
        jatuhTempo,
        tanggalTerima,
        totalHarga,
        items,
        page,
      ];
}
