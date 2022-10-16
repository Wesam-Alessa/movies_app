import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/domain/entities/genres.dart';

class MovieDetail extends Equatable {
  final int id;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final int runtime;
  final String title;
  final String voteAverage;
  final List<Genres> genres;
  
  const MovieDetail({
    required this.id,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.genres,
  });

  @override
  List<Object?> get props => [
        id,
        backdropPath,
        overview,
        releaseDate,
        runtime,
        title,
        voteAverage,
        genres,
      ];
}
