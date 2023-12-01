import 'package:intl/intl.dart';

class AppCurrency {
  static int rupiahToNumber(String currencyString) {
    // Menghilangkan karakter non-digit dari string
    String cleanString = currencyString.replaceAll(RegExp(r'[^0-9]'), '');

    // Mengonversi string yang telah dibersihkan menjadi integer
    return int.parse(cleanString);
  }

  static String numberToRupiah(int currencyNumber) {
    final formatter = NumberFormat.currency(
      locale: "id_ID",
      symbol: "Rp ",
      decimalDigits: 0,
    );

    return formatter.format(currencyNumber);
  }
}
