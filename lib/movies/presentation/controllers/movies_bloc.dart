import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_movie_details_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_now_playing_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_popular_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_search_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_top_rated_movies_usecase.dart';
import 'package:movies_app/movies/presentation/controllers/movies_event.dart';
import 'package:movies_app/movies/presentation/controllers/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopratedMoviesUseCase getTopratedMoviesUseCase;
  final GetSearchMoviesUsecase getSearchMoviesUsecase;
  MoviesBloc(
    this.getNowPlayingMoviesUseCase,
    this.getPopularMoviesUseCase,
    this.getTopratedMoviesUseCase,
    this.getSearchMoviesUsecase,
  ) : super(const MoviesState()) {
    // Now Playing Movies
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);

    // Popular Movies
    on<GetPopularMoviesEvent>(_getPopularMovies);

    // Top Rated Movies
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);

    // search movies
    on<GetSearchMoviesEvent>(_getSearchMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async {
    // will use getNowPlayingMoviesUseCase() will called call() method by defoult .
    // becouse we use callable classes
    final result = await getNowPlayingMoviesUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          nowPlayingState: RequestState.error,
          nowPlayingMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          nowPlayingState: RequestState.loaded,
          nowPlayingMovies: r,
        ),
      ),
    );
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getTopratedMoviesUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          topRatedState: RequestState.error,
          topRatedMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          topRatedState: RequestState.loaded,
          topRatedMovies: r,
        ),
      ),
    );
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getPopularMoviesUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          popularState: RequestState.error,
          popularMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          popularState: RequestState.loaded,
          popularMovies: r,
        ),
      ),
    );
  }

  List<Movie> searchMovies = [];
  List<Movie> get searchList => searchMovies;

  Future<List<Movie>> searchFun(String name) async {
    if (name.isNotEmpty) {
      final result =
          await getSearchMoviesUsecase(MovieDetailsParameters(0, name));
      result.fold(
        (l) {
          searchMovies.clear();
        },
        (r) {
          searchMovies = r;
        },
      );
      return searchMovies;
    } else {
      searchMovies.clear();
      return searchMovies;
    }
  }

  FutureOr<void> _getSearchMovies(
      GetSearchMoviesEvent event, Emitter<MoviesState> emit) async {
    if (event.name.isNotEmpty) {
      final result =
          await getSearchMoviesUsecase(MovieDetailsParameters(0, event.name));
      result.fold(
        (l) {
          searchMovies.clear();
          emit(
            state.copyWith(
              searchMoviesState: RequestState.error,
              searchMoviesMessage: l.message,
            ),
          );
        },
        (r) {
          searchMovies = r;
          emit(
            state.copyWith(
              searchMoviesState: RequestState.loaded,
              searchMovies: r,
            ),
          );
        },
      );
    } else {
      emit(
        state.copyWith(
          searchMoviesState: RequestState.loaded,
          searchMovies: [],
        ),
      );
    }
  }
}
