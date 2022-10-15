import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/usecase/get_now_playing_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_popular_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_top_rated_movies_usecase.dart';
import 'package:movies_app/movies/presentation/controllers/movies_event.dart';
import 'package:movies_app/movies/presentation/controllers/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopratedMoviesUseCase getTopratedMoviesUseCase;

  MoviesBloc(
    this.getNowPlayingMoviesUseCase,
    this.getPopularMoviesUseCase,
    this.getTopratedMoviesUseCase,
  ) : super(const MoviesState()) {
    // Now Playing Movies
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);

    // Popular Movies
    on<GetPopularMoviesEvent>(_getPopularMovies);

    // Top Rated Movies
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async {

    // will use getNowPlayingMoviesUseCase() will called call() method by defoult .
    // becouse we use callable classes
    final result = await getNowPlayingMoviesUseCase();
    
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

    // will use getTopratedMoviesUseCase() will called call() method by defoult .
    // becouse we use callable classes
    final result = await getTopratedMoviesUseCase();

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

    // will use getPopularMoviesUseCase() will called call() method by defoult .
    // becouse we use callable classes
    final result = await getPopularMoviesUseCase();
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
}
