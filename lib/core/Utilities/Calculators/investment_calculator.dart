import 'package:intl/intl.dart';

/// Handles financial math and display formatting for investments.
class InvestmentCalculator {
  /// Calculates the expected earnings based on simple interest over duration days:
  /// earnings = principal * (annualInterestRate / 100) * (durationDays / 365)
  static double calculateEstimatedEarnings({
    required num principal,
    required double annualInterestRate,
    required int durationDays,
  }) {
    if (principal <= 0 || annualInterestRate <= 0 || durationDays <= 0) {
      return 0.0;
    }
    final rawEarnings = principal * (annualInterestRate / 100.0) * (durationDays / 365.0);
    // Round to 2 decimal places to match financial standard
    return (rawEarnings * 100).roundToDouble() / 100;
  }

  /// Calculates the total payout at maturity: principal + expected earnings.
  static double calculateTotalPayout({
    required num principal,
    required double estimatedEarnings,
  }) {
    final total = principal + estimatedEarnings;
    return (total * 100).roundToDouble() / 100;
  }

  /// Calculates the effective period yield percentage: (earnings / principal) * 100
  static double calculatePeriodYieldPercentage({
    required num principal,
    required double estimatedEarnings,
  }) {
    if (principal <= 0) return 0.0;
    final yieldPct = (estimatedEarnings / principal) * 100.0;
    return (yieldPct * 100).roundToDouble() / 100;
  }

  /// Formats currency with commas and 2 decimals (e.g. $1,250.00)
  static String formatCurrency(
    num amount, {
    String symbol = '\$',
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  /// Formats rate display (e.g. 7.5% p.a. or 13.25% p.a.)
  static String formatRate(double rate) {
    final formatted = NumberFormat('0.##').format(rate);
    return '$formatted% p.a.';
  }
}
