import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/Utilities/Validators/investment_validator.dart';

void main() {
  group('InvestmentValidator Tests', () {
    test('validateAmount returns error for empty or null strings', () {
      expect(
        InvestmentValidator.validateAmount(null, minAmount: 100),
        equals('Please enter an investment amount'),
      );
      expect(
        InvestmentValidator.validateAmount('', minAmount: 100),
        equals('Please enter an investment amount'),
      );
      expect(
        InvestmentValidator.validateAmount('   ', minAmount: 100),
        equals('Please enter an investment amount'),
      );
    });

    test('validateAmount returns error for non-numeric input', () {
      expect(
        InvestmentValidator.validateAmount('abc', minAmount: 100),
        equals('Please enter a valid numeric amount'),
      );
      expect(
        InvestmentValidator.validateAmount('12.3.4', minAmount: 100),
        equals('Please enter a valid numeric amount'),
      );
    });

    test('validateAmount returns error for zero or negative numbers', () {
      expect(
        InvestmentValidator.validateAmount('0', minAmount: 100),
        equals('Amount must be greater than 0'),
      );
      expect(
        InvestmentValidator.validateAmount('-50', minAmount: 100),
        equals('Amount must be greater than 0'),
      );
    });

    test('validateAmount enforces minimum amount requirement', () {
      expect(
        InvestmentValidator.validateAmount('50', minAmount: 100),
        equals('Minimum investment is \$100'),
      );
      expect(
        InvestmentValidator.validateAmount('99', minAmount: 100),
        equals('Minimum investment is \$100'),
      );
      // Equal to min is valid
      expect(
        InvestmentValidator.validateAmount('100', minAmount: 100),
        isNull,
      );
    });

    test('validateAmount enforces maximum amount requirement when specified', () {
      expect(
        InvestmentValidator.validateAmount(
          '300000',
          minAmount: 100,
          maxAmount: 250000,
        ),
        equals('Maximum investment is \$250,000'),
      );
      // Valid amount within range
      expect(
        InvestmentValidator.validateAmount(
          '150000',
          minAmount: 100,
          maxAmount: 250000,
        ),
        isNull,
      );
    });

    test('validateAmount correctly parses comma and currency formatted strings', () {
      expect(
        InvestmentValidator.validateAmount(
          '1,000',
          minAmount: 100,
        ),
        isNull,
      );
      expect(
        InvestmentValidator.validateAmount(
          '12,000',
          minAmount: 100,
        ),
        isNull,
      );
      expect(
        InvestmentValidator.validateAmount(
          '\$ 12,000',
          minAmount: 100,
        ),
        isNull,
      );
      expect(
        InvestmentValidator.validateAmount(
          '\$12,000.00',
          minAmount: 100,
        ),
        isNull,
      );
      expect(
        InvestmentValidator.validateAmount(
          '₦12,000',
          minAmount: 100,
        ),
        isNull,
      );
      expect(
        InvestmentValidator.validateAmount(
          '50,000',
          minAmount: 100,
          maxAmount: 100000,
        ),
        isNull,
      );
    });

    test('parseAmount correctly sanitizes and parses integer amounts from formatted text', () {
      expect(InvestmentValidator.parseAmount('1,500'), equals(1500));
      expect(InvestmentValidator.parseAmount('12,000'), equals(12000));
      expect(InvestmentValidator.parseAmount('\$ 12,000'), equals(12000));
      expect(InvestmentValidator.parseAmount('25000'), equals(25000));
      expect(InvestmentValidator.parseAmount('invalid'), isNull);
      expect(InvestmentValidator.parseAmount(null), isNull);
    });
  });
}
