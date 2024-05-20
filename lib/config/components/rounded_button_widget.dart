import 'package:flutter/material.dart';

import '../colors.dart';

class RoundedButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final bool showBorder;
  final Color? borderColor;
  final Color? color;
  final double radius;
  final bool showRadius;
  final String title;
  final VoidCallback onPressed;
  final bool? isLoading;
  const RoundedButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = 100,
    this.height = 50,
    this.color = AppColors.purple,
    this.showBorder = false,
    this.borderColor,
    this.radius = 20,
    this.showRadius = true,
    this.isLoading = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: borderColor!) : null,
        color: color,
        borderRadius:
            showRadius ? BorderRadius.circular(radius) : BorderRadius.zero,
      ),
      child: Material(
        elevation: 2.0,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onPressed,
          child: Center(
            child: isLoading!
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator.adaptive())
                : Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}
