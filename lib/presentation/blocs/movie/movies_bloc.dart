// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../infrastructure/repositories/movie_repository_impl.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepositoryImpl movieRepository;
  

  MoviesBloc({required this.movieRepository}) : super(MoviesInitial()) {


    final List <Movie> moviesAll = [];

    on<LoadedMovie>((event, emit) async {
      try {
        final movies = await movieRepository.getNowPlaying(page: event.page);

        if (movies != null) {
          final currentState = state;
          if (currentState is MoviesLoaded) {
            final List<Movie> oldMovies = currentState.movies;
            final List<Movie> allMovies = List.from(oldMovies)..addAll(movies);

            moviesAll.addAll(movies);

            emit(MoviesLoaded(allMovies, event.page));
          } else {
            emit(MoviesLoaded(movies, event.page));
          }
        } else {
          emit(MoviesError("Error"));
        }
      } catch (e, s) {
        emit(MoviesError(e.toString() + s.toString()));
      }
    });


    
}
}

  