import 'package:flutter/material.dart';
import 'package:mvvm_with_provider/res/style/app_style.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.titleText,
  });

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: AppStyle.instance.h4Bold,
    );
  }
}
