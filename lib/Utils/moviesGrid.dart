import 'package:flutter/material.dart';
import 'package:moviemate/models/movie.dart';
import 'package:moviemate/screens/details_screen.dart';

class MoviesGrid{
  static Widget showWatchList(List<Movie> movies) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
}