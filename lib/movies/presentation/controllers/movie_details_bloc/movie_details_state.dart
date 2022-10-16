part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestState requestState;
  final String movieDetailsMessage;

  const MovieDetailsState({
    this.movieDetail,
    this.requestState = RequestState.loading,
    this.movieDetailsMessage = '',
  });

  MovieDetailsState copyWith(
      {MovieDetail? movieDetail, RequestState? requestState, String? movieDetailsMessage}) {
    return MovieDetailsState(
      requestState: requestState ?? this.requestState,
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
    );
  }

  @override
  List<Object> get props => [movieDetail!, requestState, movieDetailsMessage];
}
