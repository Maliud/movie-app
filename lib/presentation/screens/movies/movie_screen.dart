import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/blocs/actors_movie/actors_movie_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/movie.dart';
import '../../../infrastructure/datasources/actor_moviedb_datasource.dart';
import '../../../infrastructure/repositories/actor_repository_impl.dart';
import '../../blocs/local_storage/local_storage_bloc.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key, required this.movieId}) : super(key: key);
  final int movieId;

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<MovieDetailBloc>()
        .add(LoadedMovieDetail(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        ('state movie detail: $state');
        if (state is MovieDetailLoaded) {
          final movie = state.movie;

          return _buildMovieScreen(movie);
        } else {
          return _buildMovieScreenloading();
          
        }
      },
    );
  }

  Widget _buildMovieScreen(Movie movie) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    _MovieDetails(movie: movie),
                    const SizedBox(height: 20),
                    _ActorsByMovie(movieId: movie.id),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieScreenloading() {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        body: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: colors.primary.withOpacity(0.3),
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 50),
              width: double.infinity,
              child: Container(
                  margin: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                  height: size.height * 0.55,
                  width: double.infinity,
                  child: Container(
                    width: 130,
                    // height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ))
              //     ));
              ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                width: size.width * 0.37,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                width: size.width * 0.5,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;


    //cambiamos el formato de la fecha
    DateTime date = DateTime.parse(movie.releaseDate.toString());
    String formattedDate = "${date.day}-${date.month}-${date.year}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 10),

              // Descripción
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              )
            ],
          ),
        ),


        
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
         
            'Filmin Lansman Tarihi: $formattedDate',
            style: textStyles.bodyMedium,

            // style: textStyles.toString(),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [


            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [0.0, 0.2],
                          colors: [Colors.black87, Colors.transparent]))),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.3
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))),
            ),

            
            Positioned(
              top: 50,
              right: 10,
              child: BlocBuilder<LocalStorageBloc, LocalStorageState>(
                builder: (context, state) {
                     
                     BlocProvider.of<LocalStorageBloc>(context)
                          .add(CheckFavoriteEvent(movieId: movie.id));
                  return IconButton(
                    onPressed: () {
                      
                      BlocProvider.of<LocalStorageBloc>(context)
                          .add(ToggleFavoriteEvent(movie: movie));
                    },
                    icon: Icon(
                      
                      state is LocalStorageCheckedFavorite && state.isFavorite
                          ? Icons.favorite 
                          : Icons.favorite_border, 
                    ),
                    color: state is CheckFavoriteEvent 
                        ? Colors.red 
                        :  state is LocalStorageCheckedFavorite && state.isFavorite
                          ? Colors.red 
                          : Colors.white,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActorsByMovie extends StatefulWidget {
  final int movieId;

  const _ActorsByMovie({required this.movieId});
  @override
  State<_ActorsByMovie> createState() => _ActorsByMovieState();
}

class _ActorsByMovieState extends State<_ActorsByMovie> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BlocBuilder<ActorsMovieBloc, ActorsMovieState>(
        bloc: ActorsMovieBloc(
          actorRepositoryImpl: ActorRepositoryImpl(
            datasource: ActorMovieDbDatasource(),
          ),
        )..add(LoadedActorsMovie(movieId: widget.movieId)),
        builder: (context, state) {
          if (state is ActorsMovieInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ActorsMovieLoaded) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.actors.length,
              itemBuilder: (context, index) {
                final actor = state.actors[index];

                return Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 135,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Actor Photo
                      FadeInRight(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            actor.profilePath,
                            height: 180,
                            width: 135,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(actor.name, maxLines: 2),
                      Text(
                        actor.character ?? '',
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text(state.toString()));
          }
        },
      ),
    );
  }
}
