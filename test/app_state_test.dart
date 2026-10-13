import 'package:flutter_test/flutter_test.dart';
import 'package:template/api/Models/investments/investment_model.dart';
import 'package:template/api/Models/products/products_model.dart';
import 'package:template/core/Controllers/user_controller.dart';
import 'package:template/core/Utilities/Enums/enums.dart';

void main() {
  group('AppState Tests', () {
    final sampleProducts = [
      const Productsmodelresponse(
        id: 'p1',
        name: 'Federal Treasury 30-Day Note',
        category: 'Government Bonds',
        riskLevel: 'Low',
        annualInterestRate: 7.5,
        returnRateDisplay: '7.5% p.a.',
        durationDays: 30,
        durationLabel: '30 Days',
        minimumAmount: 100,
        maximumAmount: 250000,
        currency: 'USD',
        currencySymbol: '\$',
        shortDescription: 'Backed by sovereign treasury assets.',
        fullDescription: 'Full treasury note description.',
        maturityTerms: 'Settled on 30th day.',
        payoutFrequency: 'At Maturity',
        iconName: 'account_balance',
        highlights: ['Safe', 'Guaranteed'],
        isActive: true,
      ),
      const Productsmodelresponse(
        id: 'p2',
        name: 'Clean Energy Infrastructure Bond',
        category: 'Renewable Infrastructure',
        riskLevel: 'Medium',
        annualInterestRate: 13.2,
        returnRateDisplay: '13.2% p.a.',
        durationDays: 180,
        durationLabel: '180 Days',
        minimumAmount: 500,
        maximumAmount: 1000000,
        currency: 'USD',
        currencySymbol: '\$',
        shortDescription: 'Finance solar and wind projects.',
        fullDescription: 'Green bond description.',
        maturityTerms: 'Paid in full on maturity.',
        payoutFrequency: 'At Maturity',
        iconName: 'eco',
        highlights: ['ESG certified', 'High yield'],
        isActive: true,
      ),
      const Productsmodelresponse(
        id: 'p3',
        name: 'Tech Innovators Alpha Fund',
        category: 'Equity Fund',
        riskLevel: 'High',
        annualInterestRate: 21.5,
        returnRateDisplay: '21.5% p.a.',
        durationDays: 180,
        durationLabel: '180 Days',
        minimumAmount: 2500,
        maximumAmount: 5000000,
        currency: 'USD',
        currencySymbol: '\$',
        shortDescription: 'Aggressive alpha fund.',
        fullDescription: 'High risk tech fund.',
        maturityTerms: 'Variable return lockup.',
        payoutFrequency: 'At Maturity',
        iconName: 'trending_up',
        highlights: ['High alpha'],
        isActive: true,
      ),
    ];

    final sampleInvestments = [
      const Investmentmodel(
        referenceNumber: 'INV-001',
        status: 'Active',
        productId: 'p1',
        productName: 'Federal Treasury 30-Day Note',
        category: 'Government Bonds',
        riskLevel: 'Low',
        investedAmount: 500,
        annualInterestRate: 7.5,
        returnRateDisplay: '7.5% p.a.',
        durationDays: 30,
        durationLabel: '30 Days',
        expectedReturnAmount: 3.08,
        totalPayoutAtMaturity: 503.08,
        createdAtUtc: '2026-10-08T00:00:00Z',
        maturityDateUtc: '2026-11-07T00:00:00Z',
        formattedCreatedAt: 'Oct 08, 2026',
        formattedMaturityDate: 'Nov 07, 2026',
        currency: 'USD',
        currencySymbol: '\$',
        investorName: 'Demo Investor',
        fundingSource: 'Primary Wallet',
        idempotencyKey: 'key-1',
        wasDuplicatePrevented: false,
        message: 'Success',
      ),
      const Investmentmodel(
        referenceNumber: 'INV-002',
        status: 'Active',
        productId: 'p2',
        productName: 'Clean Energy Infrastructure Bond',
        category: 'Renewable Infrastructure',
        riskLevel: 'Medium',
        investedAmount: 1000,
        annualInterestRate: 13.2,
        returnRateDisplay: '13.2% p.a.',
        durationDays: 180,
        durationLabel: '180 Days',
        expectedReturnAmount: 65.10,
        totalPayoutAtMaturity: 1065.10,
        createdAtUtc: '2026-10-08T00:00:00Z',
        maturityDateUtc: '2027-04-06T00:00:00Z',
        formattedCreatedAt: 'Oct 08, 2026',
        formattedMaturityDate: 'Apr 06, 2027',
        currency: 'USD',
        currencySymbol: '\$',
        investorName: 'Demo Investor',
        fundingSource: 'Primary Wallet',
        idempotencyKey: 'key-2',
        wasDuplicatePrevented: false,
        message: 'Success',
      ),
    ];

    test('filteredProducts returns all products when no filter or search applied', () {
      final state = AppState(listOfProducts: sampleProducts);
      expect(state.filteredProducts.length, equals(3));
    });

    test('filteredProducts correctly filters by RiskLevel', () {
      var state = AppState(
        listOfProducts: sampleProducts,
        selectedRiskFilter: RiskLevel.Low,
      );
      expect(state.filteredProducts.length, equals(1));
      expect(state.filteredProducts.first.name, contains('Treasury'));

      state = AppState(
        listOfProducts: sampleProducts,
        selectedRiskFilter: RiskLevel.High,
      );
      expect(state.filteredProducts.length, equals(1));
      expect(state.filteredProducts.first.name, contains('Tech'));
    });

    test('filteredProducts correctly filters by search keyword', () {
      final state = AppState(
        listOfProducts: sampleProducts,
        searchQuery: 'Energy',
      );
      expect(state.filteredProducts.length, equals(1));
      expect(state.filteredProducts.first.id, equals('p2'));
    });

    test('portfolio summary getters calculate correct totals across investments', () {
      final state = AppState(listOfUsersInvestments: sampleInvestments);
      expect(state.totalInvested, equals(1500.0));
      expect(state.totalExpectedReturns, equals(68.18));
      expect(state.totalPortfolioValue, equals(1568.18));
      expect(state.activeInvestmentsCount, equals(2));
    });

    test('portfolio summary getters return 0 when investment list is empty or null', () {
      const state = AppState();
      expect(state.totalInvested, equals(0.0));
      expect(state.totalExpectedReturns, equals(0.0));
      expect(state.totalPortfolioValue, equals(0.0));
      expect(state.activeInvestmentsCount, equals(0));
    });
  });
}
