import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimationHome extends StatelessWidget {
  const AnimationHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30.0,
            fontFamily: 'Agne',
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText('coinbase', textAlign: TextAlign.center,),
            ],
            isRepeatingAnimation: false,
          ),
        ),
      ),
    );
  }
}
