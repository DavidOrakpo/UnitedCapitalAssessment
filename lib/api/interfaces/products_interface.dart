import 'package:template/api/utils/network_response.dart';

abstract interface class ProductsInterface {
  Future<NetworkResponse> getProducts({
    String? riskLevel,
    String? search,
    bool? simulateEmpty,
    bool? simulateError,
    int? simulateDelayMs,
  });

  Future<NetworkResponse> getProductDetails({
    required String productId,
    int? simulateDelayMs,
  });
}
