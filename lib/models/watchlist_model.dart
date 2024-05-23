import 'package:moviemate/services/watchlist_service.dart';
import 'package:moviemate/models/movie_model.dart';

class Watchlist {
  late String title;
  int count = 0;

  List<Movie> movies = [];
  Watchlist({required this.title});

  bool add(Movie movie) {
    if (movies.any((movieItem) => movieItem.id == movie.id)) {
      return true;
    }
    movies.add(movie);
    count++;
    WatchlistService.saveWatchlists();
    return false;
  }

  void remove(Movie movie) {
    movies.remove(movie);
    count--;
    WatchlistService.saveWatchlists();
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'count': count,
      'movies': movies.map((movie) => movie.toJson()).toList(),
    };
  }

  factory Watchlist.fromJson(Map<String, dynamic> json) {
    List<Movie> moviesList = (json['movies'] as List)
        .map((movieJson) => Movie.fromJson(movieJson))
        .toList();

    Watchlist watchlist = Watchlist(title: json['title']);
    watchlist.count = json['count'];
    watchlist.movies = moviesList;

    return watchlist;
  }

}
