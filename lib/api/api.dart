import "package:moviemate/models/movie.dart";
import "package:http/http.dart" as http;
import 'dart:convert';

class Api{

  static const _trendingURL = 'https://api.themoviedb.org/3/movie/popular?api_key=3a6ab6e6660628d1c3d0123ff11e2889#';

  static Future<List<Movie>> getMovieList() async{
    final response = await http.get(Uri.parse(_trendingURL));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }
    throw Exception('Something happened');
  }
}