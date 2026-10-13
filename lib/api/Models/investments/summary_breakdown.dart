
class SummaryBreakdown {
  final int principal;
  final double estimatedEarnings;
  final double managementFee;
  final double netEstimatedPayout;

  const SummaryBreakdown({
    required this.principal,
    required this.estimatedEarnings,
    required this.managementFee,
    required this.netEstimatedPayout,
  });

  SummaryBreakdown copyWith({
    int? principal,
    double? estimatedEarnings,
    double? managementFee,
    double? netEstimatedPayout,
  }) {
    return SummaryBreakdown(
      principal: principal ?? this.principal,
      estimatedEarnings: estimatedEarnings ?? this.estimatedEarnings,
      managementFee: managementFee ?? this.managementFee,
      netEstimatedPayout: netEstimatedPayout ?? this.netEstimatedPayout,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'principal': principal,
      'estimatedEarnings': estimatedEarnings,
      'managementFee': managementFee,
      'netEstimatedPayout': netEstimatedPayout,
    };
  }

  factory SummaryBreakdown.fromJson(Map<String, dynamic> json) {
    return SummaryBreakdown(
      principal: (json['principal'] as num).toInt(),
      estimatedEarnings: (json['estimatedEarnings'] as num).toDouble(),
      managementFee: (json['managementFee'] as num).toDouble(),
      netEstimatedPayout: (json['netEstimatedPayout'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return '''SummaryBreakdown(principal: $principal, estimatedEarnings: $estimatedEarnings, managementFee: $managementFee, netEstimatedPayout: $netEstimatedPayout)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SummaryBreakdown &&
      other.principal == principal &&
      other.estimatedEarnings == estimatedEarnings &&
      other.managementFee == managementFee &&
      other.netEstimatedPayout == netEstimatedPayout;
  }

  @override
  int get hashCode {
    return principal.hashCode ^
      estimatedEarnings.hashCode ^
      managementFee.hashCode ^
      netEstimatedPayout.hashCode;
  }
}