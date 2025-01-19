import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../screens/jokes_by_type_screen.dart';
import '../screens/favorite_jokes_screen.dart';
import '../models/joke.dart';
import '../widgets/loading_indicator.dart';

class JokeTypesScreen extends StatefulWidget {
  @override
  _JokeTypesScreenState createState() => _JokeTypesScreenState();
}

class _JokeTypesScreenState extends State<JokeTypesScreen> {
  List<String> jokeTypes = [];
  List<Joke> favoriteJokes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadJokeTypes();
  }

  Future<void> loadJokeTypes() async {
    try {
      final types = await ApiService.fetchJokeTypes();
      setState(() {
        jokeTypes = types;
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
        title: Text('Joke Types'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoriteJokesScreen(favoriteJokes: favoriteJokes),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? LoadingIndicator()
          : ListView.builder(
        itemCount: jokeTypes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(jokeTypes[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JokesByTypeScreen(
                    type: jokeTypes[index],
                    onFavorite: (joke) {
                      setState(() {
                        favoriteJokes.add(joke);
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
