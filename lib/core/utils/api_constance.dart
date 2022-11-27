class ApiConstance {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = "1f5bf13a7ceb0d00bfaaf022dcb2cdfa";
  static const String apiKeyUrl = "?api_key=";
  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";
  static const String nowPlayingUrl = "/movie/now_playing";
  static const String popularUrl = "/movie/popular";
  static const String topRatedUrl = "/movie/top_rated";
  static const String searchUrl = "/search/movie";
  static const String queryUrl = "&query=";

  static String imageUrl(String path) => "$baseImageUrl$path";
  static String movieDetailsPath(int movieId) => "/movie/$movieId";
  static String recommendationPath(int movieId) =>
      "/movie/$movieId/recommendations";
  static String trailerPath(int movieId) => "/movie/$movieId/videos";

  // https://api.themoviedb.org/3/search/movie?api_key=1f5bf13a7ceb0d00bfaaf022dcb2cdfa&query=%22black%22
}
