part of 'index.dart';

// https://www.jianshu.com/p/3edfa7d694e7 如何使用RouteAware进行页面级监听
/// 记录路由的变化
class RouteObservers<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final name = route.settings.name ?? '';
    if (name.isNotEmpty) RoutePages.history.add(name);
    debugPrint('didPush');
    debugPrint(RoutePages.history.toString());
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    RoutePages.history.remove(route.settings.name);
    debugPrint('didPop');
    debugPrint(RoutePages.history.toString());
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      var index = RoutePages.history.indexWhere((element) {
        return element == oldRoute?.settings.name;
      });
      final name = newRoute.settings.name ?? '';
      if (name.isNotEmpty) {
        if (index > 0) {
          RoutePages.history[index] = name;
        } else {
          RoutePages.history.add(name);
        }
      }
    }
    debugPrint('didReplace');
    debugPrint(RoutePages.history.toString());
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    RoutePages.history.remove(route.settings.name);
    debugPrint('didRemove');
    debugPrint(RoutePages.history.toString());
  }

  @override
  // ignore: unnecessary_overrides
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  // ignore: unnecessary_overrides
  void didStopUserGesture() {
    super.didStopUserGesture();
  }
}
