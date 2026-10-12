import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template/core/Extensions/extensions.dart';
import 'package:template/core/Utilities/routes/routes.dart';
import 'package:template/presentation/views/Home/home_page.dart';
import 'package:template/presentation/views/components/primary_button.dart';

class ErrorWidgetCustom extends ConsumerWidget {
  final FlutterErrorDetails errorDetails;
  const ErrorWidgetCustom({
    super.key,
    required this.errorDetails,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (kDebugMode)
              Text(
                "Error: ${errorDetails.exception}",
              ),
            20.0.verticalSpace(),
            Text(
              kReleaseMode
                  ? "Oops....something went wrong"
                  : "Error: ${errorDetails.stack}",
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 12,
              ),
            ),
            20.0.verticalSpace(),
            if (kReleaseMode)
              Consumer(
                builder: (context, ref, child) {
                  return PrimaryButton(
                    text: "Go Back",
                    textColor: Colors.white,
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        ref
                            .read(goRouterProvider)
                            .goNamed(HomePage.routeIdentifier);
                      }
                    },
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
