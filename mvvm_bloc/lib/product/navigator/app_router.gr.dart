// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:mvvm_bloc/features/auth/login/view/login_screen.dart' as _i1;
import 'package:mvvm_bloc/features/auth/register/view/register_screen.dart'
    as _i2;
import 'package:mvvm_bloc/features/splash/splash_screen.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    LoginScreen.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginScreen(),
      );
    },
    RegisterScreen.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterScreen(),
      );
    },
    SplashScreen.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.LoginScreen]
class LoginScreen extends _i4.PageRouteInfo<void> {
  const LoginScreen({List<_i4.PageRouteInfo>? children})
      : super(
          LoginScreen.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreen';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.RegisterScreen]
class RegisterScreen extends _i4.PageRouteInfo<void> {
  const RegisterScreen({List<_i4.PageRouteInfo>? children})
      : super(
          RegisterScreen.name,
          initialChildren: children,
        );

  static const String name = 'RegisterScreen';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SplashScreen]
class SplashScreen extends _i4.PageRouteInfo<void> {
  const SplashScreen({List<_i4.PageRouteInfo>? children})
      : super(
          SplashScreen.name,
          initialChildren: children,
        );

  static const String name = 'SplashScreen';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
