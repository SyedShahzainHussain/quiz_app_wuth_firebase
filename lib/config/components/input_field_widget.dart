import 'package:flutter/material.dart';
import 'package:quiz_app_with_firebase/config/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String title;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  const InputField({
    super.key,
    required this.controller,
    required this.title,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      controller: controller,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColors.white, fontWeight: FontWeight.w400),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(),
        disabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
      ),
    );
  }
}
