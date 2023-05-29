import 'package:flutter/material.dart';
import 'package:mvvm_bloc/product/constants/project_padding.dart';
import 'package:mvvm_bloc/product/widget/small_text_button.dart';

class QuestionDoButton extends StatelessWidget {
  QuestionDoButton({
    this.question,
    this.doText,
    this.onTap,
    super.key,
  });

  String? question;
  String? doText;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectPadding.primaryPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(question ?? ''),
          SmallTextButton(
            text: doText,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
