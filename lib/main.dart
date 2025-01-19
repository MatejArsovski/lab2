import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'api/firebase_api.dart';
import 'screens/joke_type_screen.dart';
import 'screens/random_joke_screen.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(JokeApp());
}

class JokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      routes: {
        '/': (context) => JokeTypesScreen(),
        '/random': (context) => RandomJokeScreen(),
      },
    );
  }
}
