import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/api/api.dart';
import 'package:moviemate/models/movie.dart';
import 'package:moviemate/colours.dart';
import 'package:moviemate/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    if (movies.isNotEmpty) {
      setState(() {
        print(movies[0].title);
      });
    }
  }

  Widget show_watch_list(List<Movie> movies) {
    return Container(
      padding: EdgeInsets.all(8),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Adjust the number of items in each row
            crossAxisSpacing:
                8, // Adjust the spacing between items horizontally
            mainAxisSpacing: 8, // Adjust the spacing between items vertically
            childAspectRatio: 2 / 3),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 400,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(movie: movies[index]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://image.tmdb.org/t/p/original${movies[index].posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies',
          style: GoogleFonts.aBeeZee(),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: FutureBuilder<List<Movie>>(
          future: movieList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is loading
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If an error occurred
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              // If data is loaded but empty
              return Text('No movies yet!', style: TextStyle(fontSize: 20.0));
            } else {
              // If data is loaded successfully
              return show_watch_list(snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}
