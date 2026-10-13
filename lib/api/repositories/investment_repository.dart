import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/api/Models/errors/error_response.dart';
import 'package:template/api/Models/investments/create_investment_model.dart';
import 'package:template/api/Models/investments/investment_model.dart';
import 'package:template/api/Models/investments/investment_preview_model.dart';
import 'package:template/api/interfaces/investment_interface.dart';
import 'package:template/api/interfaces/network_call_interface.dart';
import 'package:template/api/keys/api_keys.dart';
import 'package:template/api/services/dio_service.dart';
import 'package:template/api/utils/logger.dart';
import 'package:template/api/utils/network_response.dart';

final investmentsRepoProvider = Provider<InvestmentsInterface>((ref) {
  return InvestmentRepository(
    networkService: ref.watch(dioServiceProvider),
  );
});

class InvestmentRepository implements InvestmentsInterface {
  late final NetworkApi _networkService;

  InvestmentRepository({
    required NetworkApi networkService,
  }) {
    _networkService = networkService;
  }

  @override
  Future<NetworkResponse> createInvestment({
    required String productId,
    required int amount,
    required String investorName,
    required String fundingSource,
    required String idempotencyKey,
    bool? simulateError,
    int? simulateDelayMs,
  }) async {
    final url = "${ApiKeys.baseUrl}${ApiKeys.createInvestment}";
    var errorResponse = NetworkResponse.error();
    try {
      final networkResponse = await _networkService.post(
        payload: {
          "productId": productId,
          "amount": amount,
          "investorName": investorName,
          "fundingSource": fundingSource,
          "idempotencyKey": idempotencyKey,
        },
        queryParameters: {
          if (simulateDelayMs != null) "simulateDelayMs": simulateDelayMs,
          if (simulateError != null) "simulateError": simulateError,
        },
        url: url,
      );

      if (networkResponse.success) {
        return NetworkResponse.success(
          data: CreateInvestmentModel.fromJson(networkResponse.data),
          code: networkResponse.code,
          message: networkResponse.message,
        );
      } else {
        return NetworkResponse.error(
          data: networkResponse.data is Map<String, dynamic>
              ? ErrorResponse.fromJson(networkResponse.data)
              : null,
          code: networkResponse.code,
          message: networkResponse.message,
        );
      }
    } catch (e) {
      logger.e(e.toString());
      return errorResponse;
    }
  }

  @override
  Future<NetworkResponse> getSpecificUserInvestment({
    required String referenceNumber,
  }) async {
    final endpoint = ApiKeys.getSpecificUserInvestment.endsWith('/')
        ? ApiKeys.getSpecificUserInvestment
        : '${ApiKeys.getSpecificUserInvestment}/';
    final url = "${ApiKeys.baseUrl}$endpoint$referenceNumber";
    var errorResponse = NetworkResponse.error();

    try {
      final response = await _networkService.get(url: url);
      if (response.success) {
        return NetworkResponse.success(
          data: Investmentmodel.fromJson(response.data),
          code: response.code,
          message: response.message,
        );
      } else {
        return NetworkResponse.error(
          data: response.data is Map<String, dynamic>
              ? ErrorResponse.fromJson(response.data)
              : null,
          code: response.code,
          message: response.message,
        );
      }
    } catch (e) {
      logger.e(e.toString());
      return errorResponse;
    }
  }

  @override
  Future<NetworkResponse> getUsersInvestments({
    bool? simulateError,
    bool? simulateEmpty,
    int? simulateDelayMs,
  }) async {
    final url = "${ApiKeys.baseUrl}${ApiKeys.getUsersInvestment}";
    var errorResponse = NetworkResponse.error();

    try {
      final response = await _networkService.get(
        url: url,
        queryParameters: {
          if (simulateDelayMs != null) "simulateDelayMs": simulateDelayMs,
          if (simulateError != null) "simulateError": simulateError,
          if (simulateEmpty != null) "simulateEmpty": simulateEmpty,
        },
      );

      if (response.success) {
        final investments = (response.data as List)
            .map((item) =>
                Investmentmodel.fromJson(item as Map<String, dynamic>))
            .toList();
        return NetworkResponse.success(
          data: investments,
          code: response.code,
          message: response.message,
        );
      } else {
        return NetworkResponse.error(
          data: response.data is Map<String, dynamic>
              ? ErrorResponse.fromJson(response.data)
              : null,
          code: response.code,
          message: response.message,
        );
      }
    } catch (e) {
      logger.e(e.toString());
      return errorResponse;
    }
  }

  @override
  Future<NetworkResponse> previewInvestment({
    required String productId,
    required int amount,
    bool? simulateError,
    int? simulateDelayMs,
  }) async {
    final url = "${ApiKeys.baseUrl}${ApiKeys.previewInvestment}";
    var errorResponse = NetworkResponse.error();

    try {
      final response = await _networkService.post(
        payload: {
          "productId": productId,
          "amount": amount,
        },
        queryParameters: {
          if (simulateDelayMs != null) "simulateDelayMs": simulateDelayMs,
          if (simulateError != null) "simulateError": simulateError,
        },
        url: url,
      );

      if (response.success) {
        return NetworkResponse.success(
          data: InvestmentPreviewModel.fromJson(response.data),
          code: response.code,
          message: response.message,
        );
      } else {
        return NetworkResponse.error(
          data: response.data is Map<String, dynamic>
              ? ErrorResponse.fromJson(response.data)
              : null,
          code: response.code,
          message: response.message,
        );
      }
    } catch (e) {
      logger.e(e.toString());
      return errorResponse;
    }
  }

  @override
  Future<NetworkResponse> resetInvestments() async {
    final url = "${ApiKeys.baseUrl}${ApiKeys.resetInvestment}";
    var errorResponse = NetworkResponse.error();

    try {
      final response = await _networkService.post(
        payload: {},
        url: url,
      );

      if (response.success) {
        return NetworkResponse.success(
          data: response.data,
          code: response.code,
          message: response.message,
        );
      } else {
        return NetworkResponse.error(
          data: response.data is Map<String, dynamic>
              ? ErrorResponse.fromJson(response.data)
              : null,
          code: response.code,
          message: response.message,
        );
      }
    } catch (e) {
      logger.e(e.toString());
      return errorResponse;
    }
  }
}
