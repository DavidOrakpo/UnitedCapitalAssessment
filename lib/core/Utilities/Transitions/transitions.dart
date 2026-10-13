import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A custom implementation of the [CustomTransitionpage] which enables a Slide
/// Transition from one page route to another.
class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1.5, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.easeIn),
                ),
              ),
              child: child,
            );
          },
        );
}

class CustomVerticalSlideTransition extends CustomTransitionPage<void> {
  final Duration? duration;
  CustomVerticalSlideTransition(
      {super.key,
      required super.child,
      this.duration = const Duration(milliseconds: 400)})
      : super(
          transitionDuration: duration!,
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(0, 1.5),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.easeIn),
                ),
              ),
              child: FadeTransition(
                opacity: CurveTween(curve: Curves.easeIn).animate(animation),
                child: child,
              ),
            );
          },
        );
}

class CustomFadeTransition extends CustomTransitionPage<void> {
  CustomFadeTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        );
}

class CustomScaleTransition extends CustomTransitionPage<void> {
  CustomScaleTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(
              scale: animation,
              // opacity:
              //     CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
}

class CustomRotateTransition extends CustomTransitionPage<void> {
  CustomRotateTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (_, animation, __, child) {
            return RotationTransition(
              turns: Tween(begin: 0.5, end: 1.0)
                  .chain(CurveTween(curve: Curves.elasticOut))
                  .animate(animation),
              child: ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0)
                    .chain(CurveTween(curve: Curves.easeOutBack))
                    .animate(animation),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ),
            );
          },
        );
}

class CustomFlipTransition extends CustomTransitionPage<void> {
  CustomFlipTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 350),
          reverseTransitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return DecoratedBoxTransition(
              decoration: DecorationTween(
                begin: const BoxDecoration(color: Colors.transparent),
                end: const BoxDecoration(color: Colors.transparent),
              ).animate(animation),
              child: Stack(
                children: [
                  // This is the outgoing page
                  FadeTransition(
                    opacity: Tween<double>(
                      begin: 1.0,
                      end: 0.6,
                    ).animate(secondaryAnimation),
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: 1.0,
                        end: 0.95,
                      ).animate(
                        CurvedAnimation(
                          parent: secondaryAnimation,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: Container(), // Placeholder for previous page
                    ),
                  ),
                  // This is the incoming page
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: child,
                  ),
                ],
              ),
            );
          },
        );
}

// ... existing code ...

class CustomIOSTransition extends CustomTransitionPage<void> {
  CustomIOSTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 350),
          reverseTransitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        );
}

// ... existing code ...

class CustomBounceSlideTransition extends CustomTransitionPage<void> {
  CustomBounceSlideTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.elasticOut),
                ),
              ),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
                child: child,
              ),
            );
          },
        );
}

class CustomSwirlTransition extends CustomTransitionPage<void> {
  CustomSwirlTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 700),
          transitionsBuilder: (_, animation, __, child) {
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                final rotate = Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateZ(animation.value * 2 * 3.14159);
                return Transform(
                  transform: rotate,
                  alignment: Alignment.center,
                  child: ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0)
                        .chain(CurveTween(curve: Curves.easeOutBack))
                        .animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                );
              },
              child: child,
            );
          },
        );
}
