import 'package:quiz_app_with_firebase/view/levels/level.dart';


class TextButtonWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onTap;
  const TextButtonWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton.icon(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
        icon: icon,
        label: Text(title),
      ),
    );
  }
}
