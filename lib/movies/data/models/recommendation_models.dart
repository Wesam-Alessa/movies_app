import 'package:movies_app/movies/domain/entities/recommendation.dart';

class RecommendationModel extends Recommendation {
  const RecommendationModel({required super.id, super.backdropPath});

  factory RecommendationModel.fromjson(Map<String, dynamic> json) =>
      RecommendationModel(id: json["id"], backdropPath: json["backdrop_path"]);
}
