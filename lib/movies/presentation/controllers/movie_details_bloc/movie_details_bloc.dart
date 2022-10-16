import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/entities/movie_detail.dart';
import 'package:movies_app/movies/domain/usecase/get_movie_details_usecase.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUsecase getMovieDetailsUsecase;
  MovieDetailsBloc(this.getMovieDetailsUsecase)
      : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
  }

  FutureOr<void> _getMovieDetails(
    GetMovieDetailsEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    final result =
        await getMovieDetailsUsecase(MovieDetailsParameters(event.id));
    result.fold(
        (l) => emit(state.copyWith(
            requestState: RequestState.error, movieDetailsMessage: l.message)),
        (r) => emit(
          state.copyWith(
            requestState: RequestState.loaded,
            movieDetail: r
          )
        ));
  }
}
