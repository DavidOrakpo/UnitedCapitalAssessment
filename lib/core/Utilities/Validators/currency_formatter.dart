import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Formats numeric input as currency with thousands separator grouping (e.g. 12000 -> 12,000).
class CurrencyInputFormatter extends TextInputFormatter {
  final String currencySymbol;
  final int decimalDigits;
  final NumberFormat _formatter;
  String numericalValue = "";
  double amount = 0;
  final bool isBtc;

  CurrencyInputFormatter({
    this.currencySymbol = '',
    this.decimalDigits = 0,
    this.isBtc = false,
  }) : _formatter = decimalDigits > 0 || isBtc
            ? NumberFormat.currency(
                locale: 'en_US',
                symbol: currencySymbol,
                decimalDigits: isBtc ? 8 : decimalDigits,
              )
            : NumberFormat.currency(
                locale: 'en_US',
                symbol: currencySymbol,
                decimalDigits: 0,
              );

  /// Helper to format a raw numeric value into the formatted string (e.g. 12000 -> "12,000")
  String format(num value) {
    amount = value.toDouble();
    return _formatter.format(value).trim();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Strip non-digit characters to get pure numerical string
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    numericalValue = newText;

    if (newText.isEmpty) {
      amount = 0;
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    double value;
    if (isBtc) {
      value = double.parse(newText) / 100000000;
    } else if (decimalDigits > 0) {
      value = double.parse(newText) / 100;
    } else {
      value = double.parse(newText);
    }

    amount = value;
    String formattedText = _formatter.format(value).trim();

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
