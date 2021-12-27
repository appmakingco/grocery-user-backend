import 'package:flutter/material.dart';

class WelcomeSlide extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const WelcomeSlide({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            scale: 1.0,
            height: 400,
          ),
          SizedBox(height: 4),
          Text(
            "$title",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text("$subtitle")
        ],
      ),
    );
  }
}
