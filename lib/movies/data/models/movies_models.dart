import 'dart:convert';

import 'package:movies_app/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.backdropPath,
    required super.genreIds,
    required super.overview,
    required super.voteAverage,
    required super.releaseDate,
    //required super.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'overview': overview,
      'vote_average': voteAverage,
      "release_date": releaseDate,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? "",
      backdropPath: map['backdrop_path'] ?? "" ,
      genreIds: List<int>.from(map['genre_ids'].map((e) => e)),
      overview: map['overview'] ?? "",
      voteAverage: map['vote_average'].toDouble() ?? 0.0,
      releaseDate: map['release_date'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String generateUrl(String title, String date) {
    return "";
  }
}
