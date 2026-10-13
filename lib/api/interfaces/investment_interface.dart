import 'package:template/api/utils/network_response.dart';

abstract interface class InvestmentsInterface {
  Future<NetworkResponse> previewInvestment({
    required String productId,
    required int amount,
    bool? simulateError,
    int? simulateDelayMs,
  });

  Future<NetworkResponse> createInvestment({
    required String productId,
    required int amount,
    required String investorName,
    required String fundingSource,
    required String idempotencyKey,
    bool? simulateError,
    int? simulateDelayMs,
  });

  Future<NetworkResponse> getUsersInvestments({
    bool? simulateError,
    int? simulateDelayMs,
    bool? simulateEmpty,
  });

  Future<NetworkResponse> getSpecificUserInvestment({
    required String referenceNumber,
  });
  Future<NetworkResponse> resetInvestments();
}
