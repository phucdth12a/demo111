import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mvvm_bloc/gen/colors.gen.dart';

class SmallTextButton extends StatelessWidget {
  const SmallTextButton({
    super.key,
    this.text,
    required this.onTap,
  });

  final String? text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text!,
        style: context.textTheme.labelLarge!
            .copyWith(color: ColorName.retroNectarine),
      ),
    );
  }
}
