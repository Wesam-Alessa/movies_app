import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
  @override
  List<Object?> get props => [];
}

class GetNowPlayingMoviesEvent extends MoviesEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetPopularMoviesEvent extends MoviesEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}


class GetTopRatedMoviesEvent extends MoviesEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}