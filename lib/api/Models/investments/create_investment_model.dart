class CreateInvestmentModel {
  final String referenceNumber;
  final String status;
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
  final String createdAtUtc;
  final String maturityDateUtc;
  final String formattedCreatedAt;
  final String formattedMaturityDate;
  final String currency;
  final String currencySymbol;
  final String investorName;
  final String fundingSource;
  final String idempotencyKey;
  final bool wasDuplicatePrevented;
  final String message;

  const CreateInvestmentModel({
    required this.referenceNumber,
    required this.status,
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
    required this.createdAtUtc,
    required this.maturityDateUtc,
    required this.formattedCreatedAt,
    required this.formattedMaturityDate,
    required this.currency,
    required this.currencySymbol,
    required this.investorName,
    required this.fundingSource,
    required this.idempotencyKey,
    required this.wasDuplicatePrevented,
    required this.message,
  });

  CreateInvestmentModel copyWith({
    String? referenceNumber,
    String? status,
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
    String? createdAtUtc,
    String? maturityDateUtc,
    String? formattedCreatedAt,
    String? formattedMaturityDate,
    String? currency,
    String? currencySymbol,
    String? investorName,
    String? fundingSource,
    String? idempotencyKey,
    bool? wasDuplicatePrevented,
    String? message,
  }) {
    return CreateInvestmentModel(
      referenceNumber: referenceNumber ?? this.referenceNumber,
      status: status ?? this.status,
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
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      maturityDateUtc: maturityDateUtc ?? this.maturityDateUtc,
      formattedCreatedAt: formattedCreatedAt ?? this.formattedCreatedAt,
      formattedMaturityDate:
          formattedMaturityDate ?? this.formattedMaturityDate,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      investorName: investorName ?? this.investorName,
      fundingSource: fundingSource ?? this.fundingSource,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      wasDuplicatePrevented:
          wasDuplicatePrevented ?? this.wasDuplicatePrevented,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'referenceNumber': referenceNumber,
      'status': status,
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
      'createdAtUtc': createdAtUtc,
      'maturityDateUtc': maturityDateUtc,
      'formattedCreatedAt': formattedCreatedAt,
      'formattedMaturityDate': formattedMaturityDate,
      'currency': currency,
      'currencySymbol': currencySymbol,
      'investorName': investorName,
      'fundingSource': fundingSource,
      'idempotencyKey': idempotencyKey,
      'wasDuplicatePrevented': wasDuplicatePrevented,
      'message': message,
    };
  }

  factory CreateInvestmentModel.fromJson(Map<String, dynamic> json) {
    return CreateInvestmentModel(
      referenceNumber: json['referenceNumber'] ?? '',
      status: json['status'] ?? '',
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
      createdAtUtc: json['createdAtUtc'] ?? '',
      maturityDateUtc: json['maturityDateUtc'] ?? '',
      formattedCreatedAt: json['formattedCreatedAt'] ?? '',
      formattedMaturityDate: json['formattedMaturityDate'] ?? '',
      currency: json['currency'] ?? '',
      currencySymbol: json['currencySymbol'] ?? '',
      investorName: json['investorName'] ?? '',
      fundingSource: json['fundingSource'] ?? '',
      idempotencyKey: json['idempotencyKey'] ?? '',
      wasDuplicatePrevented: json['wasDuplicatePrevented'] ?? false,
      message: json['message'] ?? '',
    );
  }

  @override
  String toString() {
    return '''CreateInvestmentModel(referenceNumber: $referenceNumber, status: $status, productId: $productId, productName: $productName, category: $category, riskLevel: $riskLevel, investedAmount: $investedAmount, annualInterestRate: $annualInterestRate, returnRateDisplay: $returnRateDisplay, durationDays: $durationDays, durationLabel: $durationLabel, expectedReturnAmount: $expectedReturnAmount, totalPayoutAtMaturity: $totalPayoutAtMaturity, createdAtUtc: $createdAtUtc, maturityDateUtc: $maturityDateUtc, formattedCreatedAt: $formattedCreatedAt, formattedMaturityDate: $formattedMaturityDate, currency: $currency, currencySymbol: $currencySymbol, investorName: $investorName, fundingSource: $fundingSource, idempotencyKey: $idempotencyKey, wasDuplicatePrevented: $wasDuplicatePrevented, message: $message)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateInvestmentModel &&
        other.referenceNumber == referenceNumber &&
        other.status == status &&
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
        other.createdAtUtc == createdAtUtc &&
        other.maturityDateUtc == maturityDateUtc &&
        other.formattedCreatedAt == formattedCreatedAt &&
        other.formattedMaturityDate == formattedMaturityDate &&
        other.currency == currency &&
        other.currencySymbol == currencySymbol &&
        other.investorName == investorName &&
        other.fundingSource == fundingSource &&
        other.idempotencyKey == idempotencyKey &&
        other.wasDuplicatePrevented == wasDuplicatePrevented &&
        other.message == message;
  }

  @override
  int get hashCode {
    return referenceNumber.hashCode ^
        status.hashCode ^
        productId.hashCode ^
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
        createdAtUtc.hashCode ^
        maturityDateUtc.hashCode ^
        formattedCreatedAt.hashCode ^
        formattedMaturityDate.hashCode ^
        currency.hashCode ^
        currencySymbol.hashCode ^
        investorName.hashCode ^
        fundingSource.hashCode ^
        idempotencyKey.hashCode ^
        wasDuplicatePrevented.hashCode ^
        message.hashCode;
  }
}
