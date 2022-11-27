import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/entities/movie_detail.dart';
import 'package:movies_app/movies/domain/entities/movie_trailer.dart';
import 'package:movies_app/movies/domain/entities/recommendation.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_movie_details_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_recommendation_usecase.dart';
 
abstract class BaseMovieRepository {

  Future<Either<Failure, List<Movie>>> getNowPlayingMovie();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetail(MovieDetailsParameters parameters);
  Future<Either<Failure, MovieTrailer>> getMovieTrailer(MovieDetailsParameters parameters);
  Future<Either<Failure, List<Recommendation>>> getRecommendation(RecommendationParameters parameters);
  Future<Either<Failure, List<Movie>>> getSearchMovies(MovieDetailsParameters parameters);

}
