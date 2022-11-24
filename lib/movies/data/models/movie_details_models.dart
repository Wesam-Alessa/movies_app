import 'package:movies_app/movies/data/models/genres_models.dart';
import 'package:movies_app/movies/domain/entities/movie_detail.dart';

class MovieDetailsModels extends MovieDetail {
  const MovieDetailsModels({
    required super.id,
    required super.backdropPath,
    required super.overview,
    required super.releaseDate,
    required super.runtime,
    required super.title,
    required super.voteAverage,
    required super.genres,
    required super.url
  });

  factory MovieDetailsModels.fromjson(Map<String, dynamic> json) {
    String url = json['title'];
    String date = json['release_date'];
    url += " ";
    url += date.split('-')[0];
    url = url.replaceAll(" ", "-");
    url = url.replaceAll(":", "");
    url += "/";
    return MovieDetailsModels(
        id: json["id"],
        backdropPath: json["backdrop_path"]??"",
        overview: json["overview"],
        releaseDate: json["release_date"],
        runtime: json["runtime"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        genres: List<GenresModels>.from(
          json['genres'].map(
            (e) => GenresModels.fromjson(e),
          ),
        ),
        url: url
      );
  }
}
