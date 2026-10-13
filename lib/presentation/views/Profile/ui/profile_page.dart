import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/core/Controllers/user_controller.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';
import 'package:template/presentation/views/Profile/widgets/assessment_test_modal.dart';
import 'package:template/presentation/views/Profile/widgets/investment_card_widget.dart';
import 'package:template/presentation/views/Profile/widgets/investment_details_sheet.dart';
import 'package:template/presentation/views/Profile/widgets/investor_profile_header.dart';
import 'package:template/presentation/views/Profile/widgets/portfolio_empty_state.dart';
import 'package:template/presentation/views/Profile/widgets/portfolio_error_state.dart';
import 'package:template/presentation/views/Profile/widgets/portfolio_metrics_banner.dart';
import 'package:template/presentation/views/components/loading_skeleton.dart';

class ProfilePage extends ConsumerStatefulWidget {
  static const routeIdentifier = "PROFILE_PAGE";
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Fetch investments on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userControllerProvider.notifier).getUserInvestments();
    });
  }

  Future<void> _onRefresh() async {
    await ref.read(userControllerProvider.notifier).getUserInvestments();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF12121A) : const Color(0xFFF8F9FA);

    final appState = ref.watch(userControllerProvider);
    final controller = ref.read(userControllerProvider.notifier);
    final investments = appState.listOfUsersInvestments ?? [];

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: _onRefresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // User Profile & Portfolio Summary Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InvestorProfileHeader(
                        investorName: appState.investorName,
                        fundingSource: appState.fundingSource,
                        onSettingsTap: () =>
                            SimulationControlModal.show(context, controller),
                      ),
                      const SizedBox(height: 20),
                      PortfolioMetricsBanner(
                        totalInvested: appState.totalInvested,
                        totalExpectedReturns: appState.totalExpectedReturns,
                        totalPortfolioValue: appState.totalPortfolioValue,
                        activeInvestmentsCount: appState.activeInvestmentsCount,
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Investment Holdings',
                            style: AppTextStyle.headerFive.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                              color: isDark ? Colors.white : AppColors.black2,
                            ),
                          ),
                          if (investments.isNotEmpty)
                            Text(
                              '${investments.length} Active',
                              style: AppTextStyle.bodyFour.copyWith(
                                color: isDark
                                    ? Colors.white54
                                    : const Color(0xFF667085),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Investments List / Loading / Error / Empty States
              if (appState.isLoadingUserInvestments)
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: LoadingSkeleton(
                          height: 150,
                          width: double.infinity,
                          isCircle: false,
                        ),
                      ),
                      childCount: 3,
                    ),
                  ),
                )
              else if (appState.userInvestmentsErrorMessage != null)
                SliverToBoxAdapter(
                  child: PortfolioErrorState(
                    errorMessage: appState.userInvestmentsErrorMessage!,
                    onRetry: () => controller.getUserInvestments(),
                  ),
                )
              else if (investments.isEmpty)
                const SliverToBoxAdapter(
                  child: PortfolioEmptyState(),
                )
              else
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final investment = investments[index];
                        return InvestmentCardWidget(
                          investment: investment,
                          onTap: () {
                            InvestmentDetailsBottomSheet.show(
                                context, investment);
                          },
                        );
                      },
                      childCount: investments.length,
                    ),
                  ),
                ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
