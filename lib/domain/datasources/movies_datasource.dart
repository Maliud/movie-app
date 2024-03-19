import '../entities/movie.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getNowPlaying({int page});

  Future<List<Movie>> getPopular({int page});

  Future<List<Movie>> getUpcoming({int page});

  Future<List<Movie>> getTopRated({int page});

  Future<Movie> getMovieById(int id);

  Future<List<Movie>> searchMovies(String query);
}
