import 'package:movies_app/movies/domain/entities/movie_trailer.dart';

class MovieTrailerModels extends MovieTrailer {
  const MovieTrailerModels(
      {required super.key, required super.size, required super.type});

  factory MovieTrailerModels.fromjson(Map<String, dynamic> json) =>
      MovieTrailerModels(
        key: json["key"],
        size: json["size"],
        type: json["type"],
      );
}
