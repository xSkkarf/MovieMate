
import 'package:moviemate/models/movie.dart';

class Watchlist{
  late String title;
  int count = 0;

  List<Movie> movies = [];

  Watchlist({required this.title});

  void add(Movie movie){
    movies.add(movie);
    count++;
  }

  void remove(Movie movie){
    movies.remove(movie);
    count--;
  }

}