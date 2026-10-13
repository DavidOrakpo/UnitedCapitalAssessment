import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template/core/Controllers/user_controller.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';
import 'package:template/presentation/views/Home/ui/product_details_page.dart';
import 'package:template/presentation/views/Home/widgets/home_empty_state.dart';
import 'package:template/presentation/views/Home/widgets/home_error_state.dart';
import 'package:template/presentation/views/Home/widgets/home_search_bar.dart';
import 'package:template/presentation/views/Home/widgets/portfolio_snapshot_banner.dart';
import 'package:template/presentation/views/Home/widgets/product_card_widget.dart';
import 'package:template/presentation/views/Home/widgets/risk_filter_chips.dart';
import 'package:template/presentation/views/components/loading_skeleton.dart';

class HomePage extends ConsumerStatefulWidget {
  static const routeIdentifier = "HOME_PAGE";
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(userControllerProvider);
      if (state.listOfProducts == null && !state.isLoadingProducts) {
        ref.read(userControllerProvider.notifier).fetchProducts();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    final state = ref.read(userControllerProvider);
    await ref.read(userControllerProvider.notifier).fetchProducts(
          riskLevel: state.selectedRiskFilter,
          search: state.searchQuery,
        );
    await ref.read(userControllerProvider.notifier).getUserInvestments();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF12121A) : const Color(0xFFF8F9FA);
    final cardBg = isDark ? const Color(0xFF1E1E2E) : Colors.white;
    final borderColor = isDark ? Colors.white10 : const Color(0xFFEAECF0);

    final appState = ref.watch(userControllerProvider);
    final controller = ref.read(userControllerProvider.notifier);
    final products = appState.filteredProducts;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: _onRefresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top bar greeting and portfolio link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good day, ${appState.investorName} 👋',
                                style: AppTextStyle.bodyFour.copyWith(
                                  color: isDark
                                      ? Colors.white60
                                      : const Color(0xFF667085),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Invest & Grow',
                                style: AppTextStyle.headerThree.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22,
                                  color:
                                      isDark ? Colors.white : AppColors.black2,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => context.go('/profile'),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: cardBg,
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor),
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet_outlined,
                                color: AppColors.primary,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Portfolio Snapshot Banner
                      PortfolioSnapshotBanner(
                        totalInvested: appState.totalInvested,
                        totalExpectedReturns: appState.totalExpectedReturns,
                        activeInvestmentsCount:
                            appState.activeInvestmentsCount,
                        onTapPortfolio: () => context.go('/profile'),
                      ),
                      const SizedBox(height: 20),

                      // Search Bar
                      HomeSearchBar(
                        controller: _searchController,
                        hasQuery: appState.searchQuery.isNotEmpty,
                        onChanged: (q) => controller.setSearchQuery(q),
                        onClear: () {
                          _searchController.clear();
                          controller.setSearchQuery('');
                        },
                      ),
                      const SizedBox(height: 16),

                      // Risk Filter Chips
                      RiskFilterChips(
                        selectedRisk: appState.selectedRiskFilter,
                        onSelectRisk: (r) => controller.setRiskFilter(r),
                      ),
                      const SizedBox(height: 16),

                      // Section Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Available Investment Products',
                            style: AppTextStyle.headerFive.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: isDark ? Colors.white : AppColors.black2,
                            ),
                          ),
                          if (products.isNotEmpty)
                            Text(
                              '${products.length} found',
                              style: AppTextStyle.bodyFour.copyWith(
                                color: isDark
                                    ? Colors.white54
                                    : const Color(0xFF667085),
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Product List / State Handling
              if (appState.isLoadingProducts)
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: LoadingSkeleton(
                          height: 180,
                          width: double.infinity,
                          isCircle: false,
                        ),
                      ),
                      childCount: 3,
                    ),
                  ),
                )
              else if (appState.productsErrorMessage != null)
                SliverToBoxAdapter(
                  child: HomeErrorState(
                    errorMessage: appState.productsErrorMessage!,
                    onRetry: () => controller.fetchProducts(),
                  ),
                )
              else if (products.isEmpty)
                SliverToBoxAdapter(
                  child: HomeEmptyState(
                    onReset: () {
                      _searchController.clear();
                      controller.setSearchQuery('');
                      controller.setRiskFilter(null);
                    },
                  ),
                )
              else
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = products[index];
                        return ProductCardWidget(
                          product: product,
                          onTap: () {
                            controller.selectProduct(product);
                            context.pushNamed(
                              ProductDetailsPage.routeIdentifier,
                              extra: product,
                            );
                          },
                        );
                      },
                      childCount: products.length,
                    ),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ),
        ),
      ),
    );
  }
}
