import "package:moviemate/models/movie_model.dart";
import "package:http/http.dart" as http;
import 'dart:convert';

class Api{
  static const _baseURL = 'https://api.themoviedb.org/3/';
  static const _trendingURL = '${_baseURL}movie/popular?api_key=3a6ab6e6660628d1c3d0123ff11e2889#';
  static const _searchURL = '${_baseURL}search/movie?api_key=3a6ab6e6660628d1c3d0123ff11e2889&query=';


  static Future<List<Movie>> getMovieList() async{
    final response = await http.get(Uri.parse(_trendingURL));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }
    throw Exception('Something happened');
  }

  static Future<List<Movie>> searchMovies(String query) async {
    print('$_searchURL$query');
    final response = await http.get(Uri.parse('$_searchURL$query'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }
    throw Exception('Something happened');
  }
}