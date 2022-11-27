import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_movie_details_usecase.dart';

class GetSearchMoviesUsecase extends BaseUseCase<List<Movie>, MovieDetailsParameters> {
  final BaseMovieRepository baseMovieRepository;

  GetSearchMoviesUsecase(this.baseMovieRepository);
  
  @override
  Future<Either<Failure, List<Movie>>> call(MovieDetailsParameters parameters) async{
     return await baseMovieRepository.getSearchMovies(parameters);
  }

}