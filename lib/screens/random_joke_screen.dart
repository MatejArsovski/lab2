import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';
import '../widgets/loading_indicator.dart';

class RandomJokeScreen extends StatefulWidget {
  @override
  _RandomJokeScreenState createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  Joke? joke;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRandomJoke();
  }

  Future<void> loadRandomJoke() async {
    try {
      final randomJoke = await ApiService.fetchRandomJoke();
      setState(() {
        joke = randomJoke;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Joke'),
      ),
      body: isLoading
          ? LoadingIndicator()
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              joke!.setup,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              joke!.punchline,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
