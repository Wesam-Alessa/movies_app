import 'package:equatable/equatable.dart';

class MovieTrailer extends Equatable {
  final String key;
  final int size;
  final String type;

  const MovieTrailer({required this.key,required this.size,required this.type});


  @override
  List<Object?> get props => [key,size,type];
}
