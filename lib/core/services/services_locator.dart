import 'package:get_it/get_it.dart';
import 'package:movies_app/movies/data/datasource/movie_remote_data_source.dart';
import 'package:movies_app/movies/data/datasource/user_remote_data_source.dart';
import 'package:movies_app/movies/data/repository/movies_repository.dart';
import 'package:movies_app/movies/data/repository/user_repository.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';
import 'package:movies_app/movies/domain/repository/base_user_repository.dart';
import 'package:movies_app/movies/domain/usecase/get_movie_details_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_movie_trailer_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_now_playing_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_popular_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_recommendation_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_top_rated_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecase/user/get_user_usecase.dart';
import 'package:movies_app/movies/domain/usecase/user/social_signin_usecase.dart';
import 'package:movies_app/movies/presentation/controllers/bloc/user_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/movie_details_bloc/movie_details_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc.dart';

/*
  we use package GetIt for create single object in memory 
  insteade of create object every calling and this objects 
  Don't take up too much space in your memory
 */

final getIt = GetIt.instance;

class ServicesLocator {
  void init() {
    ///BLOC
    getIt.registerFactory(() => MoviesBloc(getIt(), getIt(), getIt()));
    getIt.registerFactory(() => MovieDetailsBloc(getIt(), getIt(), getIt()));
    getIt.registerFactory(() => UserBloc(getIt(),getIt()));

    ///USERCASE
    getIt.registerLazySingleton(() => GetNowPlayingMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetPopularMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetTopratedMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetMovieDetailsUsecase(getIt()));
    getIt.registerLazySingleton(() => GetRecommendationUsecase(getIt()));
    getIt.registerLazySingleton(() => GetMovieTrailerUsecase(getIt()));
    getIt.registerLazySingleton(() => GetUserUsecase(getIt()));
    getIt.registerLazySingleton(() => GetSocialSigninUsecase(getIt()));


    /// REPOSITORY
    getIt.registerLazySingleton<BaseMovieRepository>(
        () => MoviesRepository(getIt()));

    getIt.registerLazySingleton<BaseUserRepository>(
        () => UserRepository(getIt()));

    ///DATA SOURCE
    getIt.registerLazySingleton<BaseMovieRemoteDataSource>(
        () => MovieRemoteDataSource());

    getIt.registerLazySingleton<BaseUserRemoteDataSource>(
        () => UserRemoteDataSource());

    // YoutubePlayerController youtubePlayerController = YoutubePlayerController();
    // getIt.registerLazySingleton(() => youtubePlayerController);
  }
}
