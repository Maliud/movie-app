import '../entities/movie.dart';

abstract class LocalStorageDatasource {

  Future<void> toggleFavorite( Movie movie );
  
  Future<bool> isMovieFavorite( int movieId );

  Future<List<Movie>> loadMovies({ int limit = 20, offset = 0 });
  

}