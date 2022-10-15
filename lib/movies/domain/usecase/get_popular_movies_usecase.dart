import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetPopularMoviesUseCase extends BaseUseCase<List<Movie>>{
  final BaseMovieRepository baseMovieRepository;

  GetPopularMoviesUseCase(this.baseMovieRepository);
  
@override
  Future<Either<Failure, List<Movie>>> call() async {
    return await baseMovieRepository.getPopularMovies();
  }
}
