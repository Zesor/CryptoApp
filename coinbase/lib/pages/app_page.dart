import 'package:coinbase/services/authentication_service.dart';
import 'package:coinbase/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../widgets/coinCard.dart';
import '../widgets/coinModel.dart';
import 'dart:async';
import 'dart:convert';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int selectedIndex = 0;
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        setState(() {
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(Duration(seconds: 10), (timer) => fetchCoin());
    super.initState();
  }

  void onItemTaped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          SizedBox(
            height: 30.0,
            width: 30.0,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const Icon(Icons.notifications_outlined),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 15.0,
                      height: 15.0,
                      decoration: BoxDecoration(
                        color: const Color(0xffe31b4d),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: const Center(child: Text("3")),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: coinList.length,
        itemBuilder: (context, index) {
          return CoinCard(
            name: coinList[index].name,
            symbol: coinList[index].symbol,
            imageUrl: coinList[index].imageUrl,
            price: coinList[index].price.toDouble(),
            change: coinList[index].change.toDouble(),
            changePercentage: coinList[index].changePercentage.toDouble(),
          );
        },
      ),
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTaped,
        currentIndex: selectedIndex,
        backgroundColor: kBackgroundColor,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            tooltip: 'Accueil',
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse, color: Colors.white),
            label: 'Actifs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_circle, color: Colors.white),
            label: 'Echanger',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.payment,
              color: Colors.white,
            ),
            label: 'Payer',
          ),
        ],
      ),
    );
  }
}
