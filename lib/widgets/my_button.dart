import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textHorizontalPading;
  final double textVerticalPading;
  final Function() onTab;
  final Color? borderColor;
  final Color? fillColor;
  final Icon? icon;
  const MyButton({
    super.key,
    required this.text,
    required this.textColor,
    this.fillColor,
    this.borderColor,
    this.icon,
    required this.onTab,
    required this.textHorizontalPading,
    required this.textVerticalPading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTab,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderColor != null ? 1.0 : 0.0,
          ),
        ),
        backgroundColor: fillColor ?? Colors.transparent,
        padding: EdgeInsets.symmetric(
            horizontal: textHorizontalPading, vertical: textVerticalPading),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Visibility(
            visible: icon != null,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: icon ?? Container(),
            ),
          )
        ],
      ),
    );
  }
}
