import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';
import '../widgets/loading_indicator.dart';

class JokesByTypeScreen extends StatefulWidget {
  final String type;
  final Function(Joke) onFavorite;

  JokesByTypeScreen({required this.type, required this.onFavorite});

  @override
  _JokesByTypeScreenState createState() => _JokesByTypeScreenState();
}

class _JokesByTypeScreenState extends State<JokesByTypeScreen> {
  List<Joke> jokes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadJokes();
  }

  Future<void> loadJokes() async {
    try {
      final jokesList = await ApiService.fetchJokesByType(widget.type);
      setState(() {
        jokes = jokesList;
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
        title: Text('${widget.type} Jokes'),
      ),
      body: isLoading
          ? LoadingIndicator()
          : ListView.builder(
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          final joke = jokes[index];
          return Card(
            child: ListTile(
              title: Text(joke.setup),
              subtitle: Text(joke.punchline),
              trailing: IconButton(
                icon: Icon(
                  joke.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: joke.isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    joke.isFavorite = !joke.isFavorite;
                  });
                  if (joke.isFavorite) {
                    widget.onFavorite(joke);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
