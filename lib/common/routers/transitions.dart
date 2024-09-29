part of routers;

class RouteTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final route = Navigator.of(context);
    return RoutePageTransition(
      linearTransition: route.userGestureInProgress,
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      child: child,
    );
  }
}

class RoutePageTransition extends StatelessWidget {
  final Animation<Offset> _primaryPositionAnimation;
  final Animation<Offset> _secondaryPositionAnimation;
  final Animation<Decoration> _primaryShadowAnimation;
  final Widget child;

  RoutePageTransition({
    Key? key,
    required Animation<double> primaryRouteAnimation,
    required Animation<double> secondaryRouteAnimation,
    required this.child,
    required bool linearTransition,
  })  : _primaryPositionAnimation = (linearTransition
                ? primaryRouteAnimation
                : CurvedAnimation(
                    parent: primaryRouteAnimation,
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.easeInToLinear,
                  ))
            .drive(Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        )),
        _secondaryPositionAnimation = (linearTransition
                ? secondaryRouteAnimation
                : CurvedAnimation(
                    parent: secondaryRouteAnimation,
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.easeInToLinear,
                  ))
            .drive(Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1.0 / 3.0, 0.0),
        )),
        _primaryShadowAnimation = (linearTransition
                ? primaryRouteAnimation
                : CurvedAnimation(
                    parent: primaryRouteAnimation,
                    curve: Curves.linearToEaseOut,
                  ))
            .drive(DecorationTween(
          begin: const BoxDecoration(color: Colors.transparent),
          end: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        )),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    final TextDirection textDirection = Directionality.of(context);
    return SlideTransition(
      position: _secondaryPositionAnimation,
      textDirection: textDirection,
      transformHitTests: false,
      child: DecoratedBoxTransition(
        decoration: _primaryShadowAnimation,
        child: SlideTransition(
          position: _primaryPositionAnimation,
          textDirection: textDirection,
          child: child,
        ),
      ),
    );
  }
}
