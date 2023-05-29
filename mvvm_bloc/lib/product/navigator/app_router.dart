import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends $AppRouter {
  // @override
  // RouteType get defaultRouteType => RouteType.custom(
  //       reverseDurationInMilliseconds: 800,
  //       transitionsBuilder: (ctx, animation1, animation2, child) {
  //         // print('Anim1 ${animation1.value}');
  //         print('Anim2 ${animation2.value}');
  //         return child;
  //       },
  //     );
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashScreen.page, path: '/splash', initial: true),
        AutoRoute(page: LoginScreen.page, path: '/login'),
        AutoRoute(page: RegisterScreen.page, path: '/register'),
      ];
}
