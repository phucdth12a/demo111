import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_bloc/gen/assets.gen.dart';
import 'package:mvvm_bloc/gen/colors.gen.dart';
import 'package:mvvm_bloc/product/navigator/app_router.gr.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      AutoRouter.of(context).replace(const LoginScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          ColorName.retroNectarine,
          ColorName.algerianCoral,
        ]),
      ),
      child: Center(
        child: Assets.icons.trendyolIconWhite.svg(
          height: 35,
          colorFilter: const ColorFilter.mode(
            ColorName.facebookColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
