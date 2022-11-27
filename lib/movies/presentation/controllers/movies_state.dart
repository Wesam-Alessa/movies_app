// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';

class MoviesState extends Equatable {
  //now playing
  final List<Movie> nowPlayingMovies;
  final RequestState nowPlayingState;
  final String nowPlayingMessage;

  // populat
  final List<Movie> popularMovies;
  final RequestState popularState;
  final String popularMessage;

  // populat
  final List<Movie> topRatedMovies;
  final RequestState topRatedState;
  final String topRatedMessage;

  //search movies
  final List<Movie> searchMovies;
  final RequestState searchMoviesState;
  final String searchMoviesMessage;

  const MoviesState({
    this.nowPlayingMovies = const [],
    this.nowPlayingState = RequestState.loading,
    this.nowPlayingMessage = '',
    this.popularMovies = const [],
    this.popularState = RequestState.loading,
    this.popularMessage = '',
    this.topRatedMovies = const [],
    this.topRatedState = RequestState.loading,
    this.topRatedMessage = '',
    this.searchMovies = const [],
    this.searchMoviesState= RequestState.loading,
    this.searchMoviesMessage = '',
  });

  @override
  List<Object?> get props => [
        nowPlayingMovies,
        nowPlayingState,
        nowPlayingMessage,
        popularMovies,
        popularState,
        popularMessage,
        topRatedMovies,
        topRatedState,
        topRatedMessage,
        searchMovies,
        searchMoviesState,
        searchMoviesMessage,
      ];

  MoviesState copyWith({
    List<Movie>? nowPlayingMovies,
    RequestState? nowPlayingState,
    String? nowPlayingMessage,
    List<Movie>? popularMovies,
    RequestState? popularState,
    String? popularMessage,
    List<Movie>? topRatedMovies,
    RequestState? topRatedState,
    String? topRatedMessage,
    List<Movie>? searchMovies,
    RequestState? searchMoviesState,
    String? searchMoviesMessage,
  }) {
    return MoviesState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
      popularMovies: popularMovies ?? this.popularMovies,
      popularState: popularState ?? this.popularState,
      popularMessage: popularMessage ?? this.popularMessage,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedState: topRatedState ?? this.topRatedState,
      topRatedMessage: topRatedMessage ?? this.topRatedMessage,
      searchMovies: searchMovies ?? this.searchMovies,
      searchMoviesState: searchMoviesState ?? this.searchMoviesState,
      searchMoviesMessage: searchMoviesMessage ?? this.searchMoviesMessage,
    );
  }
}
// abstract class SearchState{}
// class GetLoadingSearchState extends SearchState{}
// class GetUnLoadingSearchState extends SearchState{}
// class GetErrorSearchState extends SearchState{}