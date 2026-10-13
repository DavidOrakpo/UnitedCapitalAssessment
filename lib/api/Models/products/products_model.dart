import 'package:flutter/foundation.dart';

class Productsmodelresponse {
  final String id;
  final String name;
  final String category;
  final String riskLevel;
  final double annualInterestRate;
  final String returnRateDisplay;
  final int durationDays;
  final String durationLabel;
  final int minimumAmount;
  final int maximumAmount;
  final String currency;
  final String currencySymbol;
  final String shortDescription;
  final String fullDescription;
  final String maturityTerms;
  final String payoutFrequency;
  final String iconName;
  final List<String> highlights;
  final bool isActive;

  const Productsmodelresponse({
    required this.id,
    required this.name,
    required this.category,
    required this.riskLevel,
    required this.annualInterestRate,
    required this.returnRateDisplay,
    required this.durationDays,
    required this.durationLabel,
    required this.minimumAmount,
    required this.maximumAmount,
    required this.currency,
    required this.currencySymbol,
    required this.shortDescription,
    required this.fullDescription,
    required this.maturityTerms,
    required this.payoutFrequency,
    required this.iconName,
    required this.highlights,
    required this.isActive,
  });

  Productsmodelresponse copyWith({
    String? id,
    String? name,
    String? category,
    String? riskLevel,
    double? annualInterestRate,
    String? returnRateDisplay,
    int? durationDays,
    String? durationLabel,
    int? minimumAmount,
    int? maximumAmount,
    String? currency,
    String? currencySymbol,
    String? shortDescription,
    String? fullDescription,
    String? maturityTerms,
    String? payoutFrequency,
    String? iconName,
    List<String>? highlights,
    bool? isActive,
  }) {
    return Productsmodelresponse(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      riskLevel: riskLevel ?? this.riskLevel,
      annualInterestRate: annualInterestRate ?? this.annualInterestRate,
      returnRateDisplay: returnRateDisplay ?? this.returnRateDisplay,
      durationDays: durationDays ?? this.durationDays,
      durationLabel: durationLabel ?? this.durationLabel,
      minimumAmount: minimumAmount ?? this.minimumAmount,
      maximumAmount: maximumAmount ?? this.maximumAmount,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      maturityTerms: maturityTerms ?? this.maturityTerms,
      payoutFrequency: payoutFrequency ?? this.payoutFrequency,
      iconName: iconName ?? this.iconName,
      highlights: highlights ?? this.highlights,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'riskLevel': riskLevel,
      'annualInterestRate': annualInterestRate,
      'returnRateDisplay': returnRateDisplay,
      'durationDays': durationDays,
      'durationLabel': durationLabel,
      'minimumAmount': minimumAmount,
      'maximumAmount': maximumAmount,
      'currency': currency,
      'currencySymbol': currencySymbol,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'maturityTerms': maturityTerms,
      'payoutFrequency': payoutFrequency,
      'iconName': iconName,
      'highlights': highlights,
      'isActive': isActive,
    };
  }

  factory Productsmodelresponse.fromJson(Map<String, dynamic> json) {
    return Productsmodelresponse(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      riskLevel: json['riskLevel'] ?? '',
      annualInterestRate: (json['annualInterestRate'] as num).toDouble(),
      returnRateDisplay: json['returnRateDisplay'] ?? '',
      durationDays: (json['durationDays'] as num).toInt(),
      durationLabel: json['durationLabel'] ?? '',
      minimumAmount: (json['minimumAmount'] as num).toInt(),
      maximumAmount: (json['maximumAmount'] as num).toInt(),
      currency: json['currency'] ?? '',
      currencySymbol: json['currencySymbol'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      fullDescription: json['fullDescription'] ?? '',
      maturityTerms: json['maturityTerms'] ?? '',
      payoutFrequency: json['payoutFrequency'] ?? '',
      iconName: json['iconName'] ?? '',
      highlights: List<String>.from(json['highlights'] ?? []),
      isActive: json['isActive'] ?? true,
    );
  }

  @override
  String toString() {
    return '''Productsmodelresponse(id: $id, name: $name, category: $category, riskLevel: $riskLevel, annualInterestRate: $annualInterestRate, returnRateDisplay: $returnRateDisplay, durationDays: $durationDays, durationLabel: $durationLabel, minimumAmount: $minimumAmount, maximumAmount: $maximumAmount, currency: $currency, currencySymbol: $currencySymbol, shortDescription: $shortDescription, fullDescription: $fullDescription, maturityTerms: $maturityTerms, payoutFrequency: $payoutFrequency, iconName: $iconName, highlights: $highlights, isActive: $isActive)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Productsmodelresponse &&
        other.id == id &&
        other.name == name &&
        other.category == category &&
        other.riskLevel == riskLevel &&
        other.annualInterestRate == annualInterestRate &&
        other.returnRateDisplay == returnRateDisplay &&
        other.durationDays == durationDays &&
        other.durationLabel == durationLabel &&
        other.minimumAmount == minimumAmount &&
        other.maximumAmount == maximumAmount &&
        other.currency == currency &&
        other.currencySymbol == currencySymbol &&
        other.shortDescription == shortDescription &&
        other.fullDescription == fullDescription &&
        other.maturityTerms == maturityTerms &&
        other.payoutFrequency == payoutFrequency &&
        other.iconName == iconName &&
        listEquals(other.highlights, highlights) &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        category.hashCode ^
        riskLevel.hashCode ^
        annualInterestRate.hashCode ^
        returnRateDisplay.hashCode ^
        durationDays.hashCode ^
        durationLabel.hashCode ^
        minimumAmount.hashCode ^
        maximumAmount.hashCode ^
        currency.hashCode ^
        currencySymbol.hashCode ^
        shortDescription.hashCode ^
        fullDescription.hashCode ^
        maturityTerms.hashCode ^
        payoutFrequency.hashCode ^
        iconName.hashCode ^
        highlights.hashCode ^
        isActive.hashCode;
  }
}
