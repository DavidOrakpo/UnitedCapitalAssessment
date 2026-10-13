import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiKeysProvider = Provider<ApiKeys>((ref) {
  return ApiKeys();
});

class ApiKeys {
  static final String baseUrl =
      Platform.isAndroid ? "http://10.0.2.2:5140" : "http://localhost:5140";
  static const String getProducts = "/api/products";
  static const String getProductDetails = "/api/products/";
  static const String previewInvestment = "/api/investments/preview/";
  static const String createInvestment = "/api/investments/";
  static const String getUsersInvestment = "/api/investments/";
  static const String getSpecificUserInvestment = "/api/investments/";
  static const String resetInvestment = "/api/investments/reset/";
}
