import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/movies/data/datasource/movie_remote_data_source.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/entities/movie_detail.dart';
import 'package:movies_app/movies/domain/entities/movie_trailer.dart';
import 'package:movies_app/movies/domain/entities/recommendation.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_movie_details_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_recommendation_usecase.dart';

class MoviesRepository extends BaseMovieRepository {
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;

  MoviesRepository(this.baseMovieRemoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getSearchMovies(MovieDetailsParameters parameters) async {
    final result = await baseMovieRemoteDataSource.getSearchMovies(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }


  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovie() async {
    final result = await baseMovieRemoteDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    final result = await baseMovieRemoteDataSource.getPopularMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    final result = await baseMovieRemoteDataSource.getTopRatedMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(
      MovieDetailsParameters parameters) async {
    final result = await baseMovieRemoteDataSource.getMovieDetails(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendation(RecommendationParameters parameters) async{
        final result = await baseMovieRemoteDataSource.getRecommendation(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
   }

  @override
  Future<Either<Failure, MovieTrailer>> getMovieTrailer(MovieDetailsParameters parameters)async {
    final result = await baseMovieRemoteDataSource.getMovieTrailer(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
