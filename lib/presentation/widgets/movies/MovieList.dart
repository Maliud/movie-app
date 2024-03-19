// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/widgets/movies/shimer_list_movie.dart';

import '../../blocs/movie/movies_bloc.dart';
import '../../blocs/movie_popular/movie_popular_bloc.dart';
import '../../blocs/next_movie/next_movie_bloc.dart';
import 'movies_slideshow.dart';

class MoviesListWidget extends StatefulWidget {
  const MoviesListWidget({super.key, required this.item});
  final int item;
  @override
  State<MoviesListWidget> createState() => _MoviesListWidgetState();
}

class _MoviesListWidgetState extends State<MoviesListWidget> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();

    switch (widget.item) {
      case 1:
        context.read<MoviesBloc>().add(LoadedMovie(page: page));
        break;
      case 2:
        context.read<MoviePopularBloc>().add(LoadedMoviesPopular(page: page));
        break;
      case 3:
        context.read<NextMovieBloc>().add(LoadedMovieNext(page: page));
        break;
    }

    // context.read<MoviesBloc>().add(LoadedMovie(page: page));
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        page++;

        // context.read<MoviesBloc>().add(LoadedMovie(page: page));
        switch (widget.item) {
          case 1:
            context.read<MoviesBloc>().add(LoadedMovie(page: page));
            break;
          case 2:
            context
                .read<MoviePopularBloc>()
                .add(LoadedMoviesPopular(page: page));
            break;
          case 3:
            context.read<NextMovieBloc>().add(LoadedMovieNext(page: page));
            break;
        }
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget buildWidgetBasedOnItem() {
      switch (widget.item) {
        case 1:
          return BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              if (state is MoviesInitial) {
                return const ShimerCardMovie();
              } else if (state is MoviesLoaded) {
                return Container(
                    margin: const EdgeInsets.only(left: 12, right: 12, top: 5),
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                      ),
                      height: size.height * 0.4,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: scrollController,
                        padding: const EdgeInsets.only(bottom: 16, top: 1),
                        cacheExtent: 1,
                        itemCount: isLoading
                            ? state.movies.length + 2
                            : state.movies.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index < state.movies.length) {
                            return MoviesSlideshow(
                              movie: state.movies[index],
                            );
                          } else {
                            return const Center(
                              child: ShimerCardMovie()
                            );
                          }
                        },
                      ),
                    ));
              } else {
                return Center(child: Text(state.toString()));
              }
            },
          );

        case 2:
          return BlocBuilder<MoviePopularBloc, MoviePopularState>(
            builder: (context, state) {
              if (state is MoviePopularInitial) {
                return const ShimerCardMovie();
              } else if (state is MoviesPopularLoaded) {
                return Container(
                    margin: const EdgeInsets.only(left: 12, right: 12, top: 5),
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                      ),
                      height: size.height * 0.4,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: scrollController,
                        padding: const EdgeInsets.only(bottom: 16, top: 1),
                        cacheExtent: 1,
                        itemCount: isLoading
                            ? state.movies.length + 2
                            : state.movies.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index < state.movies.length) {
                            return MoviesSlideshow(
                              movie: state.movies[index],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ));
              } else {
                return Center(child: Text(state.toString()));
              }
            },
          );
        case 3:
          return BlocBuilder<NextMovieBloc, NextMovieState>(
            builder: (context, state) {
              if (state is NextMovieInitial) {
                return const ShimerCardMovie();
              } else if (state is MoviesLoadedNext) {
                return Container(
                    margin: const EdgeInsets.only(left: 12, right: 12, top: 5),
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                      ),
                      height: size.height * 0.35,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: scrollController,
                        padding: const EdgeInsets.only(bottom: 16, top: 1),
                        cacheExtent: 1,
                        itemCount: isLoading
                            ? state.movies.length + 2
                            : state.movies.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index < state.movies.length) {
                            return MoviesSlideshow(
                              movie: state.movies[index],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ));
              } else {
                return Center(child: Text(state.toString()));
              }
            },
          );
        default:
          return Container();
      }
    }

    return buildWidgetBasedOnItem();
  }
}
