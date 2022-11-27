import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/entities/movie_detail.dart';
import 'package:movies_app/movies/domain/entities/movie_trailer.dart';
import 'package:movies_app/movies/domain/entities/recommendation.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_movie_details_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_movie_trailer_usecase.dart';
import 'package:movies_app/movies/domain/usecase/movies/get_recommendation_usecase.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUsecase getMovieDetailsUsecase;
  final GetRecommendationUsecase getRecommendationUsecase;
  final GetMovieTrailerUsecase getMovieTrailerUsecase;

  MovieDetailsBloc(this.getMovieDetailsUsecase, this.getRecommendationUsecase,this.getMovieTrailerUsecase)
      : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetMovieRecommendationEvent>(_getRecommendation);
    on<GetMovieTrailerEvent>(_getMovielTrailer);
  }

  FutureOr<void> _getMovieDetails(
    GetMovieDetailsEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    final result =
        await getMovieDetailsUsecase(MovieDetailsParameters(event.id,''));
    result.fold(
        (l) => emit(state.copyWith(
            movieState: RequestState.error, movieDetailsMessage: l.message)),
        (r) => emit(
            state.copyWith(movieState: RequestState.loaded, movieDetail: r)));
  }

  FutureOr<void> _getRecommendation(GetMovieRecommendationEvent event,
      Emitter<MovieDetailsState> emit) async {
    final result =
        await getRecommendationUsecase(RecommendationParameters(event.id));
    result.fold(
        (l) => emit(state.copyWith(
            recommendationState: RequestState.error,
            recommendationMessage: l.message)),
        (r) => emit(state.copyWith(
            recommendationState: RequestState.loaded, recommendation: r)));
  }

  FutureOr<void> _getMovielTrailer(
      GetMovieTrailerEvent event, Emitter<MovieDetailsState> emit) async {
    final result =
        await getMovieTrailerUsecase(MovieDetailsParameters(event.id,''));
    result.fold(
        (l) => emit(state.copyWith(
            trailerState: RequestState.error, movieTrailerMessage: l.message)),
        (r) => emit(
            state.copyWith(trailerState: RequestState.loaded, movieTrailer: r)));
  }
}
