import 'package:flutter/material.dart';

class ImageOnButtons extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const ImageOnButtons({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(1, 4), // changes position of shadow
            ),
          ]
        ),
        child: Image.asset(
          imagePath,
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
