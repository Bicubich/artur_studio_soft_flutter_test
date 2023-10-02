import 'package:flutter/material.dart';

class MyCalculatorButton extends StatelessWidget {
  final String text;
  final bool isDigit;
  final Function(String text) onTap;
  const MyCalculatorButton({
    super.key,
    required this.text,
    required this.isDigit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          onTap(text);
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(30),
          backgroundColor: text == '='
              ? Colors.orange
              : isDigit
                  ? Colors.white
                  : Colors.grey,
          foregroundColor: text == '=' ? Colors.white : Colors.black,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
