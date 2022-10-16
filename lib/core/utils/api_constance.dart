class ApiConstance {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = "1f5bf13a7ceb0d00bfaaf022dcb2cdfa";
  static const String apiKeyUrl = "?api_key=";
  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";
  static const String nowPlayingUrl = "/movie/now_playing";
  static const String popularUrl = "/movie/popular";
  static const String topRatedUrl = "/movie/top_rated";
  static String imageUrl(String path) => "$baseImageUrl$path";
  static String movieDetailsPath(int movieId) => "/movie/$movieId";

}
