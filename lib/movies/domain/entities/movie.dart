
import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String backdropPath;
  final List<int> genreIds;
  final String overview;
  final double voteAverage;
  final String releaseDate;

  const Movie(
      {required this.id,
      required this.title,
      required this.backdropPath,
      required this.genreIds,
      required this.overview,
      required this.voteAverage,
      required this.releaseDate});

/* 
this code for equatable data comes from api becouse not 2 var have same data
 when write equatable code you need to const constractor
 you can use equatable packege from pob.dev and extend Equatable in this class 
 like this(class Movie extends Equatable{})
*/

  @override
  List<Object?> get props =>
      [id, title, backdropPath, genreIds, overview, voteAverage, releaseDate];

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is Movie &&
  //         runtimeType == other.runtimeType &&
  //         id == other.id &&
  //         title == other.title &&
  //         backdropPath == other.backdropPath &&
  //         genreIds == other.genreIds &&
  //         overview == other.overview &&
  //         voteAverage == other.voteAverage&&
  //         releaseDate == other.releaseDate
  //         ;

  // @override
  // int get hashCode =>
  //     super.hashCode ^
  //     id.hashCode ^
  //     title.hashCode ^
  //     backdropPath.hashCode ^
  //     genreIds.hashCode ^
  //     overview.hashCode ^
  //     voteAverage.hashCode^
  //     releaseDate.hashCode;



}
