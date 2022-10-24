import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/movie_trailer.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_movie_details_usecase.dart';

class GetMovieTrailerUsecase extends BaseUseCase<MovieTrailer, MovieDetailsParameters> {

  final BaseMovieRepository baseMovieRepository;

  GetMovieTrailerUsecase(this.baseMovieRepository);
  
  @override
  Future<Either<Failure, MovieTrailer>> call(
      MovieDetailsParameters parameters) async {
    return await baseMovieRepository.getMovieTrailer(parameters);
  }
}
