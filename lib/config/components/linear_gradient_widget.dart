import 'package:flutter/material.dart';

class LinearGradientWidget extends StatelessWidget {
  final Widget? child;

  const LinearGradientWidget({super.key,  this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 78, 13, 151),
            Color.fromARGB(148, 77, 13, 151),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
