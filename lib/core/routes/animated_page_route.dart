
import 'package:flutter/material.dart';



class CustomOpenUpwardsPageTransitionsBuilder extends PageTransitionsBuilder {
  /// Constructs a page transition animation that matches the transition used on
  /// Android P.
  const CustomOpenUpwardsPageTransitionsBuilder();




  @override
  Widget buildTransitions<T>(
      PageRoute<T>? route,
      BuildContext? context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return _CustomOpenUpwardsPageTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }
}
class _CustomOpenUpwardsPageTransition extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  const _CustomOpenUpwardsPageTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  static const Curve downCurve = Cubic(0.75, 1.0, 0.04, 1.0);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final CurvedAnimation upPageCurvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
          reverseCurve: downCurve,
        );
        final CurvedAnimation downPageCurvedAnimation = CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.fastOutSlowIn,
          reverseCurve: downCurve,
        );
        final Animation<Offset> upPageTranslationAnimation = Tween<Offset>(
          begin: const Offset(0.0, 0.1),
          end: Offset.zero,

        ).animate(upPageCurvedAnimation);
        final Animation<Offset> downPageTranslationAnimation = Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0.0, -0.025),
        ).animate(downPageCurvedAnimation);
        return AnimatedBuilder(
          animation: animation,
          child: FractionalTranslation(
            translation: upPageTranslationAnimation.value,
            child: child,
          ),
          builder: (BuildContext context, Widget? child) {
            return AnimatedBuilder(
              animation: secondaryAnimation,
              child: FractionalTranslation(
                translation: upPageTranslationAnimation.value,
                child: child,
              ),
              builder: (BuildContext context, Widget? child) {
                return FractionalTranslation(
                  translation: downPageTranslationAnimation.value,
                  child: child,
                );
              },
            );
          },
        );
      },
    );
  }
}
