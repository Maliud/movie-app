part of 'local_storage_bloc.dart';

sealed class LocalStorageState extends Equatable {
  const LocalStorageState();
  
  @override
  List<Object> get props => [];
}


class LocalStorageInitial extends LocalStorageState {}

class LocalStorageCheckedFavorite extends LocalStorageState {
  final bool isFavorite;

  const LocalStorageCheckedFavorite(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}

class LocalStorageToggledFavorite extends LocalStorageState {
  final Movie movie;

  const LocalStorageToggledFavorite(this.movie);

  @override
  List<Object> get props => [movie];
}

class LocalStorageLoadedMovies extends LocalStorageState {
  final List<Movie> movies;

  const LocalStorageLoadedMovies(this.movies);

  @override
  List<Object> get props => [movies];
}

class LocalStorageError extends LocalStorageState {}