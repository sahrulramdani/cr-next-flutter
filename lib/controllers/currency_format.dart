import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToIdr(
      String mataUangNegara, String simbol, dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: mataUangNegara,
      symbol: simbol,
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
