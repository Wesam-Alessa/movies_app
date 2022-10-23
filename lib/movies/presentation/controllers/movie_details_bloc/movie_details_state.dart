part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestState movieState;
  final String movieDetailsMessage;
  final List<Recommendation> recommendation;
  final RequestState recommendationState;
  final String recommendationMessage;
  final MovieTrailer? movieTrailer;
  final RequestState trailerState;
  final String movieTrailerMessage;

  const MovieDetailsState({
    this.movieDetail,
    this.movieState = RequestState.loading,
    this.movieDetailsMessage = '',
    this.recommendation = const [],
    this.recommendationState = RequestState.loading,
    this.recommendationMessage = '',
    this.movieTrailer,
    this.trailerState = RequestState.loading,
    this.movieTrailerMessage = '',
  });

  MovieDetailsState copyWith({
    MovieDetail? movieDetail,
    RequestState? movieState,
    String? movieDetailsMessage,
    List<Recommendation>? recommendation,
    RequestState? recommendationState,
    String? recommendationMessage,
    MovieTrailer? movieTrailer,
    RequestState? trailerState,
    String? movieTrailerMessage,
  }) {
    return MovieDetailsState(
        movieState: movieState ?? this.movieState,
        movieDetail: movieDetail ?? this.movieDetail,
        movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
        recommendation: recommendation ?? this.recommendation,
        recommendationState: recommendationState ?? this.recommendationState,
        recommendationMessage:
            recommendationMessage ?? this.recommendationMessage,
        movieTrailer: movieTrailer ?? this.movieTrailer,
        trailerState: trailerState ?? this.trailerState,
        movieTrailerMessage: movieTrailerMessage ?? this.movieTrailerMessage);
  }

  @override
  List<Object?> get props => [
        movieDetail,
        movieState,
        movieDetailsMessage,
        recommendation,
        recommendationMessage,
        recommendationState,
        movieTrailer,
        trailerState,
        movieTrailerMessage,
      ];
}
