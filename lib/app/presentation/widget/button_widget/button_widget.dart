import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.width,
      required this.height,
      required this.onPressed,
      this.textColor,
      this.color,
      this.elevation,
      this.borderColor})
      : super(key: key);

  final String text;
  final double width;
  final double height;
  final Color? color;
  final Color? textColor;
  final Function() onPressed;
  final double? elevation;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: elevation,
            primary: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: borderColor ?? Colors.transparent)),
            minimumSize: Size(width, height)),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.button!.copyWith(
              color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
        ));
  }
}
