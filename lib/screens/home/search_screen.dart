import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moviemate/Utils/movies_grid.dart';
import 'package:moviemate/services/api_service.dart';
import 'package:moviemate/models/movie_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<Movie>>? _searchResults;

  void _searchMovies() async {
    if (_searchController.text.isEmpty) return;

    String query = _searchController.text.replaceAll(RegExp(r'\s+'), '+');

    try {
      final results = Api.searchMovies(query);
      setState(() {
        _searchResults = results;
      });
    } on SocketException catch (_) {
      showOfflineMessage();
    } catch (e) {
      showError(e.toString());
    }
  }

  void showOfflineMessage() {
    print("You are offline. Please check your internet connection.");
  }

  void showError(String error) {
    print("An error occurred: $error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Movies',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchMovies,
                ),
              ),
              onSubmitted: (_) => _searchMovies(),
            ),
          ),
          Expanded(
            child: _searchResults == null
                ? const Center(child: Text('Enter a search term to begin'))
                : FutureBuilder<List<Movie>>(
                    future: _searchResults,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
                        return const Center(
                            child: Text('Error occurred during search.'));
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No movies found.',
                                style: TextStyle(fontSize: 20.0)));
                      } else {
                        return MoviesGrid.showMoviesList(snapshot.data!);
                      }
                    },
                  ),
          )
        ],
      ),
    );
  }
}
