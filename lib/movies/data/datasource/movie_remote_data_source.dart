
import 'package:dio/dio.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/error_message_model.dart';
import 'package:movies_app/core/utils/api_constance.dart';
import 'package:movies_app/movies/data/models/movie_details_models.dart';
import 'package:movies_app/movies/data/models/movie_trailer_models.dart';
import 'package:movies_app/movies/data/models/movies_models.dart';
import 'package:movies_app/movies/data/models/recommendation_models.dart';
import 'package:movies_app/movies/domain/usecase/get_movie_details_usecase.dart';
import 'package:movies_app/movies/domain/usecase/get_recommendation_usecase.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailsModels> getMovieDetails(MovieDetailsParameters parameters);
  Future<MovieTrailerModels> getMovieTrailer(MovieDetailsParameters parameters);
  Future<List<RecommendationModel>> getRecommendation(
      RecommendationParameters parameters);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final Response response = await Dio().get(ApiConstance.baseUrl +
        ApiConstance.nowPlayingUrl +
        ApiConstance.apiKeyUrl +
        ApiConstance.apiKey);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (e) => MovieModel.fromMap(e),
        ),
      );
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final Response response = await Dio().get(ApiConstance.baseUrl +
        ApiConstance.popularUrl +
        ApiConstance.apiKeyUrl +
        ApiConstance.apiKey);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (e) => MovieModel.fromMap(e),
        ),
      );
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final Response response = await Dio().get(ApiConstance.baseUrl +
        ApiConstance.topRatedUrl +
        ApiConstance.apiKeyUrl +
        ApiConstance.apiKey);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (e) => MovieModel.fromMap(e),
        ),
      );
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<MovieDetailsModels> getMovieDetails(
      MovieDetailsParameters parameters) async {
    final Response response = await Dio().get(
      ApiConstance.baseUrl +
          ApiConstance.movieDetailsPath(parameters.movieId) +
          ApiConstance.apiKeyUrl +
          ApiConstance.apiKey,
    );
    if (response.statusCode == 200) {
      return MovieDetailsModels.fromjson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<RecommendationModel>> getRecommendation(
      RecommendationParameters parameters) async {
    final Response response = await Dio().get(
      ApiConstance.baseUrl +
          ApiConstance.recommendationPath(parameters.id) +
          ApiConstance.apiKeyUrl +
          ApiConstance.apiKey,
    );
    if (response.statusCode == 200) {
      return List<RecommendationModel>.from(
        (response.data['results'] as List).map(
          (e) => RecommendationModel.fromjson(e),
        ),
      );
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<MovieTrailerModels> getMovieTrailer(
      MovieDetailsParameters parameters) async {
    final Response response = await Dio().get(
      ApiConstance.baseUrl +
          ApiConstance.trailerPath(parameters.movieId) +
          ApiConstance.apiKeyUrl +
          ApiConstance.apiKey,
    );
    if (response.statusCode == 200) {
      Map<String,dynamic> obj = {};
      if (response.data["results"].length > 0) {
        response.data["results"].forEach((e) {
          if (e['type'] == "Trailer") {
            obj = e;
          }
        });
      } else {
        obj = response.data["results"][0];
      } 
      return MovieTrailerModels.fromjson(obj);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
