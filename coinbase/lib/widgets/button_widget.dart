import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import '../utils/colors.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      required this.text,
      required this.width,
      required this.height,
      required this.onPressed,
      required this.color})
      : super(key: key);

  final String text;
  final double? width;
  final double? height;
  final MaterialColor color;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FloatingActionButton.extended(
        heroTag: null,
        onPressed: onPressed,
        label: Text(text),
        splashColor: Colors.red,
        backgroundColor: color,
      ),
    );
  }
}
