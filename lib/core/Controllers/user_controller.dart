import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:template/api/Models/errors/error_response.dart';
import 'package:template/api/Models/investments/create_investment_model.dart';
import 'package:template/api/Models/investments/investment_model.dart';
import 'package:template/api/Models/investments/investment_preview_model.dart';
import 'package:template/api/Models/products/products_model.dart';
import 'package:template/api/interfaces/investment_interface.dart';
import 'package:template/api/interfaces/products_interface.dart';
import 'package:template/api/repositories/investment_repository.dart';
import 'package:template/api/repositories/products_repository.dart';
import 'package:template/api/utils/network_response.dart';
import 'package:template/core/Utilities/Enums/enums.dart';

final userControllerProvider = StateNotifierProvider<UserController, AppState>(
  (ref) => UserController(ref),
);

class UserController extends StateNotifier<AppState> {
  final Ref ref;
  final ProductsInterface _productsInterface;
  final InvestmentsInterface _investmentsInterface;

  UserController(this.ref)
      : _productsInterface = ref.watch(productsRepoProvider),
        _investmentsInterface = ref.watch(investmentsRepoProvider),
        super(const AppState()) {
    // Automatically fetch initial products and investments on initialization
    fetchProducts();
    getUserInvestments();
  }

  /// Sets the selected risk filter (or null for all)
  void setRiskFilter(RiskLevel? filter) {
    state = state.copyWith(selectedRiskFilter: () => filter);
  }

  /// Sets the active search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Selects a product to view in detail
  void selectProduct(Productsmodelresponse product) {
    state = state.copyWith(
      selectedProduct: () => product,
      productDetailsErrorMessage: () => null,
    );
  }

  /// Clears active preview model
  void clearPreview() {
    state = state.copyWith(
      currentPreview: () => null,
      previewErrorMessage: () => null,
    );
  }

  /// Clears last created investment reference
  void clearLastCreatedInvestment() {
    state = state.copyWith(
      lastCreatedInvestment: () => null,
      createInvestmentErrorMessage: () => null,
    );
  }

  /// Updates investor info or funding source
  void updateInvestorDetails({String? name, String? fundingSource}) {
    state = state.copyWith(
      investorName: name ?? state.investorName,
      fundingSource: fundingSource ?? state.fundingSource,
    );
  }

  /// Fetches available investment products from API
  Future<NetworkResponse> fetchProducts({
    RiskLevel? riskLevel,
    String? search,
    bool? simulateEmpty,
    bool? simulateError,
    int? simulateDelayMs,
  }) async {
    state = state.copyWith(
      isLoadingProducts: true,
      productsErrorMessage: () => null,
    );

    final response = await _productsInterface.getProducts(
      riskLevel: riskLevel,
      search: search,
      simulateEmpty: simulateEmpty,
      simulateError: simulateError,
      simulateDelayMs: simulateDelayMs,
    );

    if (response.success && response.data is List<Productsmodelresponse>) {
      state = state.copyWith(
        isLoadingProducts: false,
        listOfProducts: response.data as List<Productsmodelresponse>,
        productsErrorMessage: () => null,
      );
    } else {
      String errorMessage = response.message;
      if (response.data is ErrorResponse) {
        errorMessage = (response.data as ErrorResponse).message;
      }
      state = state.copyWith(
        isLoadingProducts: false,
        productsErrorMessage: () => errorMessage,
      );
    }

    return response;
  }

  /// Fetches full product details by product ID
  Future<NetworkResponse> getProductDetails({
    required String productId,
    int? simulateDelayMs,
  }) async {
    state = state.copyWith(
      isLoadingProductDetails: true,
      productDetailsErrorMessage: () => null,
    );

    final response = await _productsInterface.getProductDetails(
      productId: productId,
      simulateDelayMs: simulateDelayMs,
    );

    if (response.success && response.data is Productsmodelresponse) {
      final product = response.data as Productsmodelresponse;
      state = state.copyWith(
        isLoadingProductDetails: false,
        selectedProduct: () => product,
        productDetailsErrorMessage: () => null,
      );
    } else {
      String errorMessage = response.message;
      if (response.data is ErrorResponse) {
        errorMessage = (response.data as ErrorResponse).message;
      }
      state = state.copyWith(
        isLoadingProductDetails: false,
        productDetailsErrorMessage: () => errorMessage,
      );
    }

    return response;
  }

  /// Previews investment yield, breakdown, and maturity dates before committing
  Future<NetworkResponse> previewInvestment({
    required String productId,
    required int amount,
    bool? simulateError,
    int? simulateDelayMs,
  }) async {
    state = state.copyWith(
      isLoadingPreview: true,
      previewErrorMessage: () => null,
    );

    final response = await _investmentsInterface.previewInvestment(
      productId: productId,
      amount: amount,
      simulateError: simulateError,
      simulateDelayMs: simulateDelayMs,
    );

    if (response.success && response.data is InvestmentPreviewModel) {
      state = state.copyWith(
        isLoadingPreview: false,
        currentPreview: () => response.data as InvestmentPreviewModel,
        previewErrorMessage: () => null,
      );
    } else {
      String errorMessage = response.message;
      if (response.data is ErrorResponse) {
        errorMessage = (response.data as ErrorResponse).message;
      }
      state = state.copyWith(
        isLoadingPreview: false,
        previewErrorMessage: () => errorMessage,
      );
    }

    return response;
  }

  /// Submits and creates an investment with idempotency protection
  Future<NetworkResponse> createInvestment({
    required String productId,
    required int amount,
    String? investorName,
    String? fundingSource,
    String? idempotencyKey,
    bool? simulateError,
    int? simulateDelayMs,
  }) async {
    state = state.copyWith(
      isCreatingInvestment: true,
      createInvestmentErrorMessage: () => null,
    );

    final resolvedKey = idempotencyKey ??
        'idemp-${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(999999)}';
    final resolvedInvestor = investorName ?? state.investorName;
    final resolvedFunding = fundingSource ?? state.fundingSource;

    final response = await _investmentsInterface.createInvestment(
      productId: productId,
      amount: amount,
      investorName: resolvedInvestor,
      fundingSource: resolvedFunding,
      idempotencyKey: resolvedKey,
      simulateError: simulateError,
      simulateDelayMs: simulateDelayMs,
    );

    if (response.success && response.data is CreateInvestmentModel) {
      final created = response.data as CreateInvestmentModel;
      state = state.copyWith(
        isCreatingInvestment: false,
        lastCreatedInvestment: () => created,
        createInvestmentErrorMessage: () => null,
      );
      // Refresh the user's investment portfolio in the background
      await getUserInvestments();
    } else {
      String errorMessage = response.message;
      if (response.data is ErrorResponse) {
        errorMessage = (response.data as ErrorResponse).message;
      }
      state = state.copyWith(
        isCreatingInvestment: false,
        createInvestmentErrorMessage: () => errorMessage,
      );
    }

    return response;
  }

  /// Fetches all active and historical investments for the user
  Future<NetworkResponse> getUserInvestments({
    bool? simulateEmpty,
    bool? simulateError,
    int? simulateDelayMs,
  }) async {
    state = state.copyWith(
      isLoadingUserInvestments: true,
      userInvestmentsErrorMessage: () => null,
    );

    final response = await _investmentsInterface.getUsersInvestments(
      simulateEmpty: simulateEmpty,
      simulateError: simulateError,
      simulateDelayMs: simulateDelayMs,
    );

    if (response.success && response.data is List<Investmentmodel>) {
      state = state.copyWith(
        isLoadingUserInvestments: false,
        listOfUsersInvestments: response.data as List<Investmentmodel>,
        userInvestmentsErrorMessage: () => null,
      );
    } else {
      String errorMessage = response.message;
      if (response.data is ErrorResponse) {
        errorMessage = (response.data as ErrorResponse).message;
      }
      state = state.copyWith(
        isLoadingUserInvestments: false,
        userInvestmentsErrorMessage: () => errorMessage,
      );
    }

    return response;
  }

  /// Resets mock investments on the server and refetches state
  Future<NetworkResponse> resetInvestments() async {
    final response = await _investmentsInterface.resetInvestments();
    if (response.success) {
      await getUserInvestments();
    }
    return response;
  }
}

class AppState {
  final List<Productsmodelresponse>? listOfProducts;
  final bool isLoadingProducts;
  final String? productsErrorMessage;

  final RiskLevel? selectedRiskFilter;
  final String searchQuery;

  final Productsmodelresponse? selectedProduct;
  final bool isLoadingProductDetails;
  final String? productDetailsErrorMessage;

  final InvestmentPreviewModel? currentPreview;
  final bool isLoadingPreview;
  final String? previewErrorMessage;

  final bool isCreatingInvestment;
  final String? createInvestmentErrorMessage;
  final CreateInvestmentModel? lastCreatedInvestment;

  final List<Investmentmodel>? listOfUsersInvestments;
  final bool isLoadingUserInvestments;
  final String? userInvestmentsErrorMessage;

  final String investorName;
  final String fundingSource;

  const AppState({
    this.listOfProducts,
    this.isLoadingProducts = false,
    this.productsErrorMessage,
    this.selectedRiskFilter,
    this.searchQuery = '',
    this.selectedProduct,
    this.isLoadingProductDetails = false,
    this.productDetailsErrorMessage,
    this.currentPreview,
    this.isLoadingPreview = false,
    this.previewErrorMessage,
    this.isCreatingInvestment = false,
    this.createInvestmentErrorMessage,
    this.lastCreatedInvestment,
    this.listOfUsersInvestments,
    this.isLoadingUserInvestments = false,
    this.userInvestmentsErrorMessage,
    this.investorName = 'Demo Investor',
    this.fundingSource = 'Primary Wallet',
  });

  /// Filtered products based on active risk level and search keyword
  List<Productsmodelresponse> get filteredProducts {
    if (listOfProducts == null) return [];
    return listOfProducts!.where((product) {
      // Risk filter check
      if (selectedRiskFilter != null) {
        if (!product.riskLevel
            .toLowerCase()
            .contains(selectedRiskFilter!.title.toLowerCase())) {
          return false;
        }
      }
      // Search query check
      if (searchQuery.trim().isNotEmpty) {
        final query = searchQuery.trim().toLowerCase();
        final matchesName = product.name.toLowerCase().contains(query);
        final matchesCategory = product.category.toLowerCase().contains(query);
        final matchesDesc =
            product.shortDescription.toLowerCase().contains(query);
        if (!matchesName && !matchesCategory && !matchesDesc) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  /// Total capital invested across all active user investments
  double get totalInvested {
    if (listOfUsersInvestments == null || listOfUsersInvestments!.isEmpty) {
      return 0.0;
    }
    return listOfUsersInvestments!
        .fold(0.0, (acc, inv) => acc + inv.investedAmount);
  }

  /// Total expected return interest earnings across all investments
  double get totalExpectedReturns {
    if (listOfUsersInvestments == null || listOfUsersInvestments!.isEmpty) {
      return 0.0;
    }
    final sum = listOfUsersInvestments!
        .fold(0.0, (acc, inv) => acc + inv.expectedReturnAmount);
    return (sum * 100).roundToDouble() / 100;
  }

  /// Total maturity payout across all user investments
  double get totalPortfolioValue {
    if (listOfUsersInvestments == null || listOfUsersInvestments!.isEmpty) {
      return 0.0;
    }
    final sum = listOfUsersInvestments!
        .fold(0.0, (acc, inv) => acc + inv.totalPayoutAtMaturity);
    return (sum * 100).roundToDouble() / 100;
  }

  /// Count of active investments
  int get activeInvestmentsCount {
    if (listOfUsersInvestments == null) return 0;
    return listOfUsersInvestments!
        .where((inv) => inv.status.toLowerCase() == 'active')
        .length;
  }

  AppState copyWith({
    List<Productsmodelresponse>? listOfProducts,
    bool? isLoadingProducts,
    ValueGetter<String?>? productsErrorMessage,
    ValueGetter<RiskLevel?>? selectedRiskFilter,
    String? searchQuery,
    ValueGetter<Productsmodelresponse?>? selectedProduct,
    bool? isLoadingProductDetails,
    ValueGetter<String?>? productDetailsErrorMessage,
    ValueGetter<InvestmentPreviewModel?>? currentPreview,
    bool? isLoadingPreview,
    ValueGetter<String?>? previewErrorMessage,
    bool? isCreatingInvestment,
    ValueGetter<String?>? createInvestmentErrorMessage,
    ValueGetter<CreateInvestmentModel?>? lastCreatedInvestment,
    List<Investmentmodel>? listOfUsersInvestments,
    bool? isLoadingUserInvestments,
    ValueGetter<String?>? userInvestmentsErrorMessage,
    String? investorName,
    String? fundingSource,
  }) {
    return AppState(
      listOfProducts: listOfProducts ?? this.listOfProducts,
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      productsErrorMessage: productsErrorMessage != null
          ? productsErrorMessage()
          : this.productsErrorMessage,
      selectedRiskFilter: selectedRiskFilter != null
          ? selectedRiskFilter()
          : this.selectedRiskFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedProduct:
          selectedProduct != null ? selectedProduct() : this.selectedProduct,
      isLoadingProductDetails:
          isLoadingProductDetails ?? this.isLoadingProductDetails,
      productDetailsErrorMessage: productDetailsErrorMessage != null
          ? productDetailsErrorMessage()
          : this.productDetailsErrorMessage,
      currentPreview:
          currentPreview != null ? currentPreview() : this.currentPreview,
      isLoadingPreview: isLoadingPreview ?? this.isLoadingPreview,
      previewErrorMessage: previewErrorMessage != null
          ? previewErrorMessage()
          : this.previewErrorMessage,
      isCreatingInvestment: isCreatingInvestment ?? this.isCreatingInvestment,
      createInvestmentErrorMessage: createInvestmentErrorMessage != null
          ? createInvestmentErrorMessage()
          : this.createInvestmentErrorMessage,
      lastCreatedInvestment: lastCreatedInvestment != null
          ? lastCreatedInvestment()
          : this.lastCreatedInvestment,
      listOfUsersInvestments:
          listOfUsersInvestments ?? this.listOfUsersInvestments,
      isLoadingUserInvestments:
          isLoadingUserInvestments ?? this.isLoadingUserInvestments,
      userInvestmentsErrorMessage: userInvestmentsErrorMessage != null
          ? userInvestmentsErrorMessage()
          : this.userInvestmentsErrorMessage,
      investorName: investorName ?? this.investorName,
      fundingSource: fundingSource ?? this.fundingSource,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listOfProducts': listOfProducts?.map((x) => x.toJson()).toList(),
      'listOfUsersInvestments':
          listOfUsersInvestments?.map((x) => x.toJson()).toList(),
      'searchQuery': searchQuery,
      'investorName': investorName,
      'fundingSource': fundingSource,
    };
  }

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      listOfProducts: json['listOfProducts'] != null
          ? List<Productsmodelresponse>.from(json['listOfProducts']
              .map((x) => Productsmodelresponse.fromJson(x)))
          : null,
      listOfUsersInvestments: json['listOfUsersInvestments'] != null
          ? List<Investmentmodel>.from(json['listOfUsersInvestments']
              .map((x) => Investmentmodel.fromJson(x)))
          : null,
      searchQuery: json['searchQuery'] ?? '',
      investorName: json['investorName'] ?? 'Demo Investor',
      fundingSource: json['fundingSource'] ?? 'Primary Wallet',
    );
  }

  @override
  String toString() =>
      '''AppState(products: ${listOfProducts?.length}, userInvestments: ${listOfUsersInvestments?.length}, loadingProducts: $isLoadingProducts)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        listEquals(other.listOfProducts, listOfProducts) &&
        other.isLoadingProducts == isLoadingProducts &&
        other.productsErrorMessage == productsErrorMessage &&
        other.selectedRiskFilter == selectedRiskFilter &&
        other.searchQuery == searchQuery &&
        other.selectedProduct == selectedProduct &&
        other.isLoadingProductDetails == isLoadingProductDetails &&
        other.currentPreview == currentPreview &&
        other.isLoadingPreview == isLoadingPreview &&
        other.isCreatingInvestment == isCreatingInvestment &&
        other.lastCreatedInvestment == lastCreatedInvestment &&
        listEquals(other.listOfUsersInvestments, listOfUsersInvestments) &&
        other.isLoadingUserInvestments == isLoadingUserInvestments &&
        other.investorName == investorName &&
        other.fundingSource == fundingSource;
  }

  @override
  int get hashCode =>
      listOfProducts.hashCode ^
      isLoadingProducts.hashCode ^
      selectedRiskFilter.hashCode ^
      searchQuery.hashCode ^
      listOfUsersInvestments.hashCode ^
      isLoadingUserInvestments.hashCode;
}
