import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mvvm_bloc/gen/assets.gen.dart';
import 'package:mvvm_bloc/gen/colors.gen.dart';

class BackGround extends StatelessWidget {
  const BackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 4,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorName.retroNectarine,
                  ColorName.algerianCoral,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Assets.icons.trendyolIconWhite.svg(
                      height: 35,
                      colorFilter: const ColorFilter.mode(
                        ColorName.facebookColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      'Every thing you are looking for...',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 6,
          child: Container(
            color: ColorName.backgroundColor,
          ),
        ),
      ],
    );
  }
}
