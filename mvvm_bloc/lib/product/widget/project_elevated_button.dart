import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mvvm_bloc/gen/colors.gen.dart';
import 'package:mvvm_bloc/product/constants/project_padding.dart';

class ProjectElevantedButton extends StatelessWidget {
  const ProjectElevantedButton({super.key, this.onPressed, this.name});

  final String? name;
  final Future<void> Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: ProjectPadding.primaryPadding,
      width: context.width,
      height: context.height * 0.08,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(backgroundColor: ColorName.retroNectarine),
        onPressed: onPressed,
        child: Text(name ?? ''),
      ),
    );
  }
}
