import 'package:citiguide/Theme/color.dart';
import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
  final VoidCallback Function;
  final String buttontext;
  final bool isActive;

  myButton(
      {required this.Function,
      required this.buttontext,
      this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Function,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          color: isActive ? ColorTheme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: ColorTheme.primaryColor, width: 2),
        ),
        child: Center(
          child: Text(
            buttontext,
            style: TextStyle(
              color: isActive ? Colors.white : ColorTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
