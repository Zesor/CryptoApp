import 'package:coinbase/pages/app_page.dart';
import 'package:coinbase/pages/home_page.dart';
import 'package:coinbase/pages/signin_page.dart';
import 'package:coinbase/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/authentication_service.dart';
import 'services/firebase_options.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coinbase',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: animationBackgroundColor ,
        ),
        routes: {
          '/': (context) => const HomePage(),
          '/signin': (context) => const AuthenticationWrapper(),
          '/app': (context) => const AppPage(),

        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const AppPage();
    }
    return const SignInPage();
  }
}
