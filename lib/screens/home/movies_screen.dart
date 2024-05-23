import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/Utils/movies_grid.dart';
import 'package:moviemate/services/api_service.dart';
import 'package:moviemate/models/movie_model.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late Future<List<Movie>> movieList;
  late List<Movie> movies;

  @override
  void initState() {
    super.initState();
    initializeMovieList();
  }

  Future<void> initializeMovieList() async {
    try {
      movieList = Api.getMovieList();
      movies = await movieList;
    } on SocketException catch (_) {
      // Handle offline error
      showOfflineMessage();
    } catch (e) {
      // Handle other errors
      showError(e.toString());
    }
  }

  void showOfflineMessage() {
    // You can use a dialog, a snackbar, or set a state to show an offline message on the screen
    print("You are offline. Please check your internet connection.");
  }

  void showError(String error) {
    // Handle and show other types of errors
    print("An error occurred: $error");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trending Movies',
          style: GoogleFonts.bebasNeue(fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
        
      ),
      body: Center(
        child: FutureBuilder<List<Movie>>(
          future: movieList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } 
            else if (snapshot.hasError) {
              return const Text('Can\'t load movies, check your internet connection and try again.');
            } 
            else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Text('No movies yet!', style: TextStyle(fontSize: 20.0));
            } 
            else {
              return MoviesGrid.showMoviesList(snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}


