import 'package:coinbase/animations/first_animation.dart';
import 'package:coinbase/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/form_connection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        const Center(
          child: AnimationHome(),
          widthFactor: 10,
          heightFactor: 19,
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: MyTextButton(
              height: 40,
              width: 75,
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              bgColor: Colors.white,
              buttonName: 'Get started',
              textColor: Colors.black,
            ))
      ],
    ));
  }
}
