import 'package:coinbase/utils/colors.dart';
import 'package:flutter/material.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({Key? key}) : super(key: key);

  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  double wallet = 500.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(padding: EdgeInsets.fromLTRB(30, 60, 30, 60)),
          Text(wallet.toString() + '\$', style: const TextStyle(fontSize: 30.0),),
        ],
      ),
    );
  }
}
