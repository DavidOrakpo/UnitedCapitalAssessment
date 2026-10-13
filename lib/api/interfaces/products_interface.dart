import 'package:template/api/utils/network_response.dart';
import 'package:template/core/Utilities/Enums/enums.dart';

abstract interface class ProductsInterface {
  Future<NetworkResponse> getProducts({
    RiskLevel? riskLevel,
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
