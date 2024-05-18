import 'package:flutter/material.dart';
import 'package:moviemate/models/movie_model.dart';
import 'package:moviemate/models/watchlist_model.dart';
import 'package:moviemate/screens/movie_details_screen.dart';

class MoviesGrid{
  static Widget showMoviesList(List<Movie> movies) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing:8,
            mainAxisSpacing: 8,
            childAspectRatio: 2 / 3
        ),
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

  static Widget showMoviesListDel(Watchlist watchlist, VoidCallback callBack) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing:8,
            mainAxisSpacing: 8,
            childAspectRatio: 2 / 3
        ),
        itemCount: watchlist.movies.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 400,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(movie: watchlist.movies[index]),
                  ),
                );
              },
              onLongPress: (){
                deleteDialog(watchlist.movies[index], watchlist, context, callBack);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://image.tmdb.org/t/p/original${watchlist.movies[index].posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  static void deleteDialog(Movie movie, Watchlist watchlist, BuildContext context, VoidCallback callBack) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this watchlist?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                watchlist.remove(movie);
                callBack();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}