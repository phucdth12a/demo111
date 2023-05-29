import 'package:flutter/material.dart';
import 'package:mvvm_bloc/product/constants/project_padding.dart';

class ProjectTextFormField extends StatelessWidget {
  const ProjectTextFormField({
    super.key,
    this.hintText,
    this.isObsecure,
    this.controller,
    this.suffixIcon,
  });

  final String? hintText;
  final bool? isObsecure;
  final TextEditingController? controller;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectPadding.primaryPadding,
      child: TextFormField(
        validator: (text) {
          if (text!.isEmpty) {
            return 'cannot be empty';
          }
          return null;
        },
        controller: controller,
        obscureText: isObsecure ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
