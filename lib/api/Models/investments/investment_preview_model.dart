import 'summary_breakdown.dart';

class InvestmentPreviewModel {
  final String productId;
  final String productName;
  final String category;
  final String riskLevel;
  final int investedAmount;
  final double annualInterestRate;
  final String returnRateDisplay;
  final int durationDays;
  final String durationLabel;
  final double expectedReturnAmount;
  final double totalPayoutAtMaturity;
  final String startDateUtc;
  final String maturityDateUtc;
  final String formattedMaturityDate;
  final String currency;
  final String currencySymbol;
  final String maturityTerms;
  final String payoutFrequency;
  final SummaryBreakdown summaryBreakdown;

  const InvestmentPreviewModel({
    required this.productId,
    required this.productName,
    required this.category,
    required this.riskLevel,
    required this.investedAmount,
    required this.annualInterestRate,
    required this.returnRateDisplay,
    required this.durationDays,
    required this.durationLabel,
    required this.expectedReturnAmount,
    required this.totalPayoutAtMaturity,
    required this.startDateUtc,
    required this.maturityDateUtc,
    required this.formattedMaturityDate,
    required this.currency,
    required this.currencySymbol,
    required this.maturityTerms,
    required this.payoutFrequency,
    required this.summaryBreakdown,
  });

  InvestmentPreviewModel copyWith({
    String? productId,
    String? productName,
    String? category,
    String? riskLevel,
    int? investedAmount,
    double? annualInterestRate,
    String? returnRateDisplay,
    int? durationDays,
    String? durationLabel,
    double? expectedReturnAmount,
    double? totalPayoutAtMaturity,
    String? startDateUtc,
    String? maturityDateUtc,
    String? formattedMaturityDate,
    String? currency,
    String? currencySymbol,
    String? maturityTerms,
    String? payoutFrequency,
    SummaryBreakdown? summaryBreakdown,
  }) {
    return InvestmentPreviewModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      category: category ?? this.category,
      riskLevel: riskLevel ?? this.riskLevel,
      investedAmount: investedAmount ?? this.investedAmount,
      annualInterestRate: annualInterestRate ?? this.annualInterestRate,
      returnRateDisplay: returnRateDisplay ?? this.returnRateDisplay,
      durationDays: durationDays ?? this.durationDays,
      durationLabel: durationLabel ?? this.durationLabel,
      expectedReturnAmount: expectedReturnAmount ?? this.expectedReturnAmount,
      totalPayoutAtMaturity:
          totalPayoutAtMaturity ?? this.totalPayoutAtMaturity,
      startDateUtc: startDateUtc ?? this.startDateUtc,
      maturityDateUtc: maturityDateUtc ?? this.maturityDateUtc,
      formattedMaturityDate:
          formattedMaturityDate ?? this.formattedMaturityDate,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      maturityTerms: maturityTerms ?? this.maturityTerms,
      payoutFrequency: payoutFrequency ?? this.payoutFrequency,
      summaryBreakdown: summaryBreakdown ?? this.summaryBreakdown,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'category': category,
      'riskLevel': riskLevel,
      'investedAmount': investedAmount,
      'annualInterestRate': annualInterestRate,
      'returnRateDisplay': returnRateDisplay,
      'durationDays': durationDays,
      'durationLabel': durationLabel,
      'expectedReturnAmount': expectedReturnAmount,
      'totalPayoutAtMaturity': totalPayoutAtMaturity,
      'startDateUtc': startDateUtc,
      'maturityDateUtc': maturityDateUtc,
      'formattedMaturityDate': formattedMaturityDate,
      'currency': currency,
      'currencySymbol': currencySymbol,
      'maturityTerms': maturityTerms,
      'payoutFrequency': payoutFrequency,
      'summaryBreakdown': summaryBreakdown.toJson(),
    };
  }

  factory InvestmentPreviewModel.fromJson(Map<String, dynamic> json) {
    return InvestmentPreviewModel(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      category: json['category'] ?? '',
      riskLevel: json['riskLevel'] ?? '',
      investedAmount: (json['investedAmount'] as num).toInt(),
      annualInterestRate: (json['annualInterestRate'] as num).toDouble(),
      returnRateDisplay: json['returnRateDisplay'] ?? '',
      durationDays: (json['durationDays'] as num).toInt(),
      durationLabel: json['durationLabel'] ?? '',
      expectedReturnAmount: (json['expectedReturnAmount'] as num).toDouble(),
      totalPayoutAtMaturity: (json['totalPayoutAtMaturity'] as num).toDouble(),
      startDateUtc: json['startDateUtc'] ?? '',
      maturityDateUtc: json['maturityDateUtc'] ?? '',
      formattedMaturityDate: json['formattedMaturityDate'] ?? '',
      currency: json['currency'] ?? '',
      currencySymbol: json['currencySymbol'] ?? '',
      maturityTerms: json['maturityTerms'] ?? '',
      payoutFrequency: json['payoutFrequency'] ?? '',
      summaryBreakdown: SummaryBreakdown.fromJson(json['summaryBreakdown']),
    );
  }

  @override
  String toString() {
    return '''InvestmentPreviewModel(productId: $productId, productName: $productName, category: $category, riskLevel: $riskLevel, investedAmount: $investedAmount, annualInterestRate: $annualInterestRate, returnRateDisplay: $returnRateDisplay, durationDays: $durationDays, durationLabel: $durationLabel, expectedReturnAmount: $expectedReturnAmount, totalPayoutAtMaturity: $totalPayoutAtMaturity, startDateUtc: $startDateUtc, maturityDateUtc: $maturityDateUtc, formattedMaturityDate: $formattedMaturityDate, currency: $currency, currencySymbol: $currencySymbol, maturityTerms: $maturityTerms, payoutFrequency: $payoutFrequency, summaryBreakdown: $summaryBreakdown)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvestmentPreviewModel &&
        other.productId == productId &&
        other.productName == productName &&
        other.category == category &&
        other.riskLevel == riskLevel &&
        other.investedAmount == investedAmount &&
        other.annualInterestRate == annualInterestRate &&
        other.returnRateDisplay == returnRateDisplay &&
        other.durationDays == durationDays &&
        other.durationLabel == durationLabel &&
        other.expectedReturnAmount == expectedReturnAmount &&
        other.totalPayoutAtMaturity == totalPayoutAtMaturity &&
        other.startDateUtc == startDateUtc &&
        other.maturityDateUtc == maturityDateUtc &&
        other.formattedMaturityDate == formattedMaturityDate &&
        other.currency == currency &&
        other.currencySymbol == currencySymbol &&
        other.maturityTerms == maturityTerms &&
        other.payoutFrequency == payoutFrequency &&
        other.summaryBreakdown == summaryBreakdown;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        category.hashCode ^
        riskLevel.hashCode ^
        investedAmount.hashCode ^
        annualInterestRate.hashCode ^
        returnRateDisplay.hashCode ^
        durationDays.hashCode ^
        durationLabel.hashCode ^
        expectedReturnAmount.hashCode ^
        totalPayoutAtMaturity.hashCode ^
        startDateUtc.hashCode ^
        maturityDateUtc.hashCode ^
        formattedMaturityDate.hashCode ^
        currency.hashCode ^
        currencySymbol.hashCode ^
        maturityTerms.hashCode ^
        payoutFrequency.hashCode ^
        summaryBreakdown.hashCode;
  }
}
