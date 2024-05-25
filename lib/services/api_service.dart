import "package:moviemate/models/movie_model.dart";
import "package:http/http.dart" as http;
import 'dart:convert';

class Api{
  static const _baseURL = 'https://api.themoviedb.org/3/';
  static const _trendingURL = '${_baseURL}movie/popular?api_key=3a6ab6e6660628d1c3d0123ff11e2889#';
  static const _movieSearchURL = '${_baseURL}search/movie?api_key=3a6ab6e6660628d1c3d0123ff11e2889&query=';
  static const _tvSearchURL = '${_baseURL}search/tv?api_key=3a6ab6e6660628d1c3d0123ff11e2889&query=';


  static Future<List<Movie>> getMovieList() async{
    final response = await http.get(Uri.parse(_trendingURL));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }
    throw Exception('Something happened');
  }

  static Future<List<Movie>> search(String query) async {
    final movieResponse = await http.get(Uri.parse('$_movieSearchURL$query'));
    final tvResponse = await http.get(Uri.parse('$_tvSearchURL$query'));

    if (movieResponse.statusCode == 200 && tvResponse.statusCode == 200) {
      final movieData = json.decode(movieResponse.body)['results'] as List;
      final tvData = json.decode(tvResponse.body)['results'] as List;

      final List<Movie> tvSeriesAsMovies = tvData.map((tvShow) => Movie.fromJson(tvShow)).toList();
      final List<Movie> moviesAsMovies = movieData.map((movie) => Movie.fromJson(movie)).toList();

      return [...moviesAsMovies, ...tvSeriesAsMovies];
    } else {
      throw Exception('Failed to load search results');
    }
  }
}