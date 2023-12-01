import 'package:equatable/equatable.dart';

class InvoiceItemM extends Equatable {
  final String idProduk;
  final String deskripsi;
  final int jumlahHarga;
  final String namaProduk;
  final int qty;
  final int satuanHarga;

  const InvoiceItemM({
    required this.idProduk,
    required this.deskripsi,
    required this.jumlahHarga,
    required this.namaProduk,
    required this.qty,
    required this.satuanHarga,
  });

  InvoiceItemM copyWith({
    String? idProduk,
    String? deskripsi,
    int? jumlahHarga,
    String? namaProduk,
    int? qty,
    int? satuanHarga,
  }) =>
      InvoiceItemM(
        idProduk: idProduk ?? this.idProduk,
        deskripsi: deskripsi ?? this.deskripsi,
        jumlahHarga: jumlahHarga ?? this.jumlahHarga,
        namaProduk: namaProduk ?? this.namaProduk,
        qty: qty ?? this.qty,
        satuanHarga: satuanHarga ?? this.satuanHarga,
      );

  factory InvoiceItemM.fromJson(Map<String, dynamic> json) => InvoiceItemM(
        idProduk: json["id_produk"],
        deskripsi: json["deskripsi"],
        jumlahHarga: json["jumlah_harga"],
        namaProduk: json["nama_produk"],
        qty: json["qty"],
        satuanHarga: json["satuan_harga"],
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "deskripsi": deskripsi,
        "jumlah_harga": jumlahHarga,
        "nama_produk": namaProduk,
        "qty": qty,
        "satuan_harga": satuanHarga,
      };

  @override
  List<Object?> get props => [
        idProduk,
        deskripsi,
        jumlahHarga,
        namaProduk,
        qty,
        satuanHarga,
      ];
}
