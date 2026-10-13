import 'validation_errors.dart';

class ErrorResponse {
  final int statusCode;
  final String message;
  final String errorCode;
  final ValidationErrors? validationErrors;
  final DateTime timestampUtc;

  const ErrorResponse({
    required this.statusCode,
    required this.message,
    required this.errorCode,
    this.validationErrors,
    required this.timestampUtc,
  });

  ErrorResponse copyWith({
    int? statusCode,
    String? message,
    String? errorCode,
    ValidationErrors? validationErrors,
    DateTime? timestampUtc,
  }) {
    return ErrorResponse(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      errorCode: errorCode ?? this.errorCode,
      validationErrors: validationErrors ?? this.validationErrors,
      timestampUtc: timestampUtc ?? this.timestampUtc,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'errorCode': errorCode,
      'validationErrors': validationErrors?.toJson(),
      'timestampUtc': timestampUtc.toIso8601String(),
    };
  }

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    DateTime parsedTime;
    if (json['timestampUtc'] is int) {
      parsedTime = DateTime.fromMillisecondsSinceEpoch(json['timestampUtc']);
    } else if (json['timestampUtc'] is String) {
      parsedTime = DateTime.tryParse(json['timestampUtc']) ?? DateTime.now();
    } else {
      parsedTime = DateTime.now();
    }

    ValidationErrors? parsedValidationErrors;
    if (json['validationErrors'] != null &&
        json['validationErrors'] is Map<String, dynamic>) {
      parsedValidationErrors =
          ValidationErrors.fromJson(json['validationErrors']);
    } else if (json['errors'] != null &&
        json['errors'] is Map<String, dynamic>) {
      parsedValidationErrors = ValidationErrors.fromJson(json['errors']);
    }

    return ErrorResponse(
      statusCode: json['statusCode'] ?? json['status'] ?? 500,
      message: json['message'] ?? json['title'] ?? 'An error occurred',
      errorCode: json['errorCode'] ?? '',
      validationErrors: parsedValidationErrors,
      timestampUtc: parsedTime,
    );
  }

  @override
  String toString() {
    return '''ErrorResponse(statusCode: $statusCode, message: $message, errorCode: $errorCode, validationErrors: $validationErrors, timestampUtc: $timestampUtc)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorResponse &&
        other.statusCode == statusCode &&
        other.message == message &&
        other.errorCode == errorCode &&
        other.validationErrors == validationErrors &&
        other.timestampUtc == timestampUtc;
  }

  @override
  int get hashCode {
    return statusCode.hashCode ^
        message.hashCode ^
        errorCode.hashCode ^
        validationErrors.hashCode ^
        timestampUtc.hashCode;
  }
}
