
class Movie{

  late String title;
  late int id;
  late String backDropPath;
  late String originalTitle;
  late String overview;
  late String posterPath;
  late String releaseDate;
  late double voteAverage;



  Movie({
    required this.title,
    required this.id,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage
  });


  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      title: json['title'],
      id: json['id'],
      backDropPath: json['backdrop_path'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'backdrop_path': backDropPath,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
    };
  }

}