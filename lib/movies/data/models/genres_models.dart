import 'package:movies_app/movies/domain/entities/genres.dart';

class GenresModels extends Genres {
  const GenresModels({required super.name, required super.id});
  
  factory GenresModels.fromjson(Map<String, dynamic> json) =>
      GenresModels(name: json['name'], id: json['id']);
}
