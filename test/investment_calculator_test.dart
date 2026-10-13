import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/Utilities/Calculators/investment_calculator.dart';

void main() {
  group('InvestmentCalculator Tests', () {
    test('calculateEstimatedEarnings computes 30-day simple interest accurately', () {
      // Principal = $500, Rate = 7.5%, Duration = 30 days
      // 500 * (7.5 / 100) * (30 / 365) = 3.08219... -> 3.08
      final earnings = InvestmentCalculator.calculateEstimatedEarnings(
        principal: 500,
        annualInterestRate: 7.5,
        durationDays: 30,
      );
      expect(earnings, equals(3.08));
    });

    test('calculateEstimatedEarnings computes 90-day interest accurately', () {
      // Principal = $1,000, Rate = 9.8%, Duration = 90 days
      // 1000 * (9.8 / 100) * (90 / 365) = 24.1643... -> 24.16
      final earnings = InvestmentCalculator.calculateEstimatedEarnings(
        principal: 1000,
        annualInterestRate: 9.8,
        durationDays: 90,
      );
      expect(earnings, equals(24.16));
    });

    test('calculateEstimatedEarnings computes 365-day full year interest accurately', () {
      // Principal = $10,000, Rate = 16.5%, Duration = 365 days
      // 10000 * 0.165 * 1.0 = 1650.00
      final earnings = InvestmentCalculator.calculateEstimatedEarnings(
        principal: 10000,
        annualInterestRate: 16.5,
        durationDays: 365,
      );
      expect(earnings, equals(1650.00));
    });

    test('calculateEstimatedEarnings returns 0 for zero or negative values', () {
      expect(
        InvestmentCalculator.calculateEstimatedEarnings(
          principal: 0,
          annualInterestRate: 10.0,
          durationDays: 30,
        ),
        equals(0.0),
      );

      expect(
        InvestmentCalculator.calculateEstimatedEarnings(
          principal: 500,
          annualInterestRate: 0,
          durationDays: 30,
        ),
        equals(0.0),
      );

      expect(
        InvestmentCalculator.calculateEstimatedEarnings(
          principal: -100,
          annualInterestRate: 7.5,
          durationDays: 30,
        ),
        equals(0.0),
      );

      expect(
        InvestmentCalculator.calculateEstimatedEarnings(
          principal: 500,
          annualInterestRate: 7.5,
          durationDays: -10,
        ),
        equals(0.0),
      );
    });

    test('calculateTotalPayout correctly sums principal and earnings', () {
      final total = InvestmentCalculator.calculateTotalPayout(
        principal: 500,
        estimatedEarnings: 3.08,
      );
      expect(total, equals(503.08));
    });

    test('calculatePeriodYieldPercentage computes effective yield percentage', () {
      // 3.08 / 500 * 100 = 0.616 -> 0.62%
      final yieldPct = InvestmentCalculator.calculatePeriodYieldPercentage(
        principal: 500,
        estimatedEarnings: 3.08,
      );
      expect(yieldPct, equals(0.62));
    });

    test('formatCurrency formats values with proper symbol and commas', () {
      expect(
        InvestmentCalculator.formatCurrency(1250.50, symbol: '\$'),
        equals('\$1,250.50'),
      );
      expect(
        InvestmentCalculator.formatCurrency(1000000, symbol: '\$', decimalDigits: 0),
        equals('\$1,000,000'),
      );
    });

    test('formatRate formats annualized rate strings cleanly', () {
      expect(InvestmentCalculator.formatRate(7.5), equals('7.5% p.a.'));
      expect(InvestmentCalculator.formatRate(13.25), equals('13.25% p.a.'));
    });
  });
}
