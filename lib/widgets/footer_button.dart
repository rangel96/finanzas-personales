import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  const FooterButton({
    Key? key,
    required this.backgroundColor,
    required this.onPressed,
    required this.title,
    this.color,
  }) : super(key: key);

  final Color backgroundColor;
  final String title;
  final void Function() onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TextButton(
      style: _footerButtonStyle(size),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(fontSize: 20, color: color ?? Colors.black),
      ),
    );
  }

  ButtonStyle _footerButtonStyle(Size size) {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
      fixedSize: MaterialStatePropertyAll(Size(size.width, 60)),
      alignment: Alignment.topCenter,
    );
  }
}
