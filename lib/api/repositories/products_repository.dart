import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/api/Models/errors/error_response.dart';
import 'package:template/api/Models/products/products_model.dart';
import 'package:template/api/interfaces/network_call_interface.dart';
import 'package:template/api/interfaces/products_interface.dart';
import 'package:template/api/keys/api_keys.dart';
import 'package:template/api/services/dio_service.dart';
import 'package:template/api/utils/logger.dart';
import 'package:template/api/utils/network_response.dart';

final productsRepoProvider = Provider<ProductsInterface>((ref) {
  return ProductsRepository(
    networkService: ref.watch(dioServiceProvider),
  );
});

class ProductsRepository implements ProductsInterface {
  late final NetworkApi _networkService;

  ProductsRepository({
    required NetworkApi networkService,
  }) {
    _networkService = networkService;
  }

  @override
  Future<NetworkResponse> getProducts({
    String? riskLevel,
    String? search,
    bool? simulateEmpty,
    bool? simulateError,
    int? simulateDelayMs,
  }) async {
    final url = "${ApiKeys.baseUrl}${ApiKeys.getProducts}";
    var errorResponse = NetworkResponse.error();

    try {
      final networkResponse = await _networkService.get(
        url: url,
        queryParameters: {
          if (riskLevel != null && riskLevel.isNotEmpty) "riskLevel": riskLevel,
          if (search != null && search.isNotEmpty) "search": search,
          if (simulateEmpty != null) "simulateEmpty": simulateEmpty,
          if (simulateError != null) "simulateError": simulateError,
          if (simulateDelayMs != null) "simulateDelayMs": simulateDelayMs,
        },
      );

      if (networkResponse.success) {
        final products = (networkResponse.data as List)
            .map((item) =>
                Productsmodelresponse.fromJson(item as Map<String, dynamic>))
            .toList();
        return NetworkResponse.success(
          data: products,
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
  Future<NetworkResponse> getProductDetails({
    required String productId,
    int? simulateDelayMs,
  }) async {
    final endpoint = ApiKeys.getProductDetails.endsWith('/')
        ? ApiKeys.getProductDetails
        : '${ApiKeys.getProductDetails}/';
    final url = "${ApiKeys.baseUrl}$endpoint$productId";
    var errorResponse = NetworkResponse.error();

    try {
      final networkResponse = await _networkService.get(
        url: url,
        queryParameters: {
          if (simulateDelayMs != null) "simulateDelayMs": simulateDelayMs,
        },
      );

      if (networkResponse.success) {
        return NetworkResponse.success(
          data: Productsmodelresponse.fromJson(
              networkResponse.data as Map<String, dynamic>),
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
}
