import 'package:flutter/foundation.dart';

class ValidationErrors {
  final List<String> amount;

  const ValidationErrors({
    required this.amount,
  });

  ValidationErrors copyWith({
    List<String>? amount,
  }) {
    return ValidationErrors(
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
    };
  }

  factory ValidationErrors.fromJson(Map<String, dynamic> json) {
    final list = json['amount'] ?? json['Amount'];
    return ValidationErrors(
      amount: list != null ? List<String>.from(list) : [],
    );
  }

  @override
  String toString() => '''ValidationErrors(amount: $amount)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ValidationErrors &&
      listEquals(other.amount, amount);
  }

  @override
  int get hashCode => amount.hashCode;
}