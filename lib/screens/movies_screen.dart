import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/Utils/moviesGrid.dart';
import 'package:moviemate/api/api.dart';
import 'package:moviemate/models/movie.dart';
import 'package:moviemate/screens/details_screen.dart';

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
    movieList = Api.getMovieList();
    movies = await movieList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies',
          style: GoogleFonts.bebasNeue(fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: FutureBuilder<List<Movie>>(
          future: movieList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is loading
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If an error occurred
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              // If data is loaded but empty
              return const Text('No movies yet!', style: TextStyle(fontSize: 20.0));
            } else {
              // If data is loaded successfully
              return MoviesGrid.showWatchList(snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}


