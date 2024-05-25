import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/models/movie_model.dart';
import 'package:moviemate/models/watchlist_model.dart';
import 'package:moviemate/screens/home/movie_details_screen.dart';

class MoviesGrid {
  static Widget showMoviesList(List<Movie> movies) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2 / 3),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(movie: movies[index]),
                ),
              );
            },
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/original${movies[index].posterPath}',
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                padding: EdgeInsets.all(4),
                width: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 12,
                    ),
                    SizedBox(width: 5),
                    Text(
                      movies[index].voteAverage!.toStringAsFixed(1),
                      style: GoogleFonts.bebasNeue(fontSize: 12),
                    )
                  ],
                ),
              ),
            ]),
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
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2 / 3),
        itemCount: watchlist.movies.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 400,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailsScreen(movie: watchlist.movies[index]),
                  ),
                );
              },
              onLongPress: () {
                deleteDialog(
                    watchlist.movies[index], watchlist, context, callBack);
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

  static void deleteDialog(Movie movie, Watchlist watchlist,
      BuildContext context, VoidCallback callBack) {
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
