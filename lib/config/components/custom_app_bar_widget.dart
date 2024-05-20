import 'package:flutter/material.dart';
import 'package:quiz_app_with_firebase/config/colors.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget>? action;
  const CustomAppBarWidget({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      backgroundColor: AppColors.purple,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.white),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
      actions: action,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
