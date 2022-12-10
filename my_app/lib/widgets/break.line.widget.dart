import 'package:flutter/material.dart';

class BreakLine extends StatelessWidget {
  const BreakLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        width: 450,
        height: 0.4,
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.black38),
        ),
      ),
    );
  }
}
