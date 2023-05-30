import 'package:flutter/material.dart';
import 'package:mvvm_bloc/product/constants/project_padding.dart';
import 'package:mvvm_bloc/product/widget/small_text_button.dart';

class QuestionDoButton extends StatelessWidget {
  const QuestionDoButton({
    super.key,
    this.question,
    this.doText,
    this.onTap,
  });

  final String? question;
  final String? doText;
  final void Function()? onTap;

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
