import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_bloc/gen/colors.gen.dart';
import 'package:mvvm_bloc/product/init/product_init.dart';
import 'package:mvvm_bloc/product/navigator/app_router.dart';
import 'package:mvvm_bloc/product/service/auth_service.dart';
import 'package:mvvm_bloc/product/theme/themes.dart';

void main() async {
  final productInit = ProductInit();
  await productInit.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],
      path: 'assets/translations',
      child: RepositoryProvider(
        create: (context) => AuthService(),
        child: MyApp(
          appRouter: productInit.appRouter,
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appRouter,
  });

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: ColorName.algerianCoral),
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      title: 'Material App',
      theme: ProjectThemes.lightTheme,
    );
  }
}
