import 'package:template/core/Utilities/Calculators/investment_calculator.dart';

/// Validation logic for investment forms and inputs.
class InvestmentValidator {
  /// Validates investment amount entered by user.
  /// Handles formatted strings (e.g. "12,000", "$ 12,000", "₦12,000", "-50").
  /// Returns null if valid, or an error message string if invalid.
  static String? validateAmount(
    String? input, {
    required num minAmount,
    num? maxAmount,
    String currencySymbol = '\$',
  }) {
    if (input == null || input.trim().isEmpty) {
      return 'Please enter an investment amount';
    }

    final trimmed = input.trim();
    final isNegative = trimmed.startsWith('-');

    // Strip currency symbols, commas, and whitespace, keeping numbers and decimal
    final sanitizedDigits = trimmed.replaceAll(RegExp(r'[^0-9.]'), '').trim();

    if (sanitizedDigits.isEmpty) {
      return 'Please enter a valid numeric amount';
    }

    num? parsed = num.tryParse(sanitizedDigits);

    if (parsed == null) {
      return 'Please enter a valid numeric amount';
    }

    if (isNegative) {
      parsed = -parsed;
    }

    if (parsed <= 0) {
      return 'Amount must be greater than 0';
    }

    if (parsed < minAmount) {
      final minFormatted = InvestmentCalculator.formatCurrency(
        minAmount,
        symbol: currencySymbol,
        decimalDigits: 0,
      );
      return 'Minimum investment is $minFormatted';
    }

    if (maxAmount != null && parsed > maxAmount) {
      final maxFormatted = InvestmentCalculator.formatCurrency(
        maxAmount,
        symbol: currencySymbol,
        decimalDigits: 0,
      );
      return 'Maximum investment is $maxFormatted';
    }

    return null;
  }

  /// Parses sanitized amount string to an integer, or returns null if invalid.
  static int? parseAmount(String? input) {
    if (input == null || input.trim().isEmpty) return null;
    final trimmed = input.trim();
    final isNegative = trimmed.startsWith('-');
    final sanitizedDigits = trimmed.replaceAll(RegExp(r'[^0-9.]'), '').trim();
    if (sanitizedDigits.isEmpty) return null;
    final numVal = num.tryParse(sanitizedDigits);
    if (numVal == null) return null;
    final intVal = numVal.toInt();
    return isNegative ? -intVal : intVal;
  }
}
