import 'package:bloc/bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../infrastructure/repositories/movie_repository_impl.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final MovieRepositoryImpl movieRepository;

  MoviePopularBloc({required this.movieRepository}) : super(MoviePopularInitial()) {

    on<LoadedMoviesPopular>((event, emit) async {
      try {
        final movies = await movieRepository.getTopRated(page: event.page);

          final currentState = state;
          if (currentState is MoviesPopularLoaded) {
            final List<Movie> oldMovies = currentState.movies;
            final List<Movie> allMovies = List.from(oldMovies)..addAll(movies);
            emit(MoviesPopularLoaded(allMovies, event.page));
          } else {
            emit(MoviesPopularLoaded(movies, event.page));
          }
       
      } catch (e, s) {
        emit(MoviesError(e.toString() + s.toString()));
      }
    });
  }
}
