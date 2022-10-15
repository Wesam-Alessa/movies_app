import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetTopratedMoviesUseCase extends BaseUseCase<List<Movie>>{
  final BaseMovieRepository baseMovieRepository;

  GetTopratedMoviesUseCase(this.baseMovieRepository);
  
  @override
  Future<Either<Failure, List<Movie>>> call() async {
    return await baseMovieRepository.getTopRatedMovies();
  }
}
