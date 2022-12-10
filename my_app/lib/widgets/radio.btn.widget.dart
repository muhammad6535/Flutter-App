import 'package:flutter/material.dart';

class RadioBtnWidget extends StatelessWidget {
  final String icon;
  final String text;
  const RadioBtnWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Image.network(
            icon,
            height: 60,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
