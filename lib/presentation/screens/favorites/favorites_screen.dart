import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/presentation/widgets/shared/custom_appbar.dart';

import '../../../infrastructure/datasources/isar_datasource.dart';
import '../../../infrastructure/repositories/local_storage_repository_impl.dart';
import '../../blocs/local_storage/local_storage_bloc.dart';
import '../../widgets/favorites/movie_masonry.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            const CustomAppbar(
              title: 'Favorilerim',
              showLeading: false,
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.8,
              child: BlocBuilder<LocalStorageBloc, LocalStorageState>(
                bloc: LocalStorageBloc(
                  repository:
                      LocalStorageRepositoryImpl(datasource: IsarDatasource()),
                )..add(LoadMoviesEvent(limit: 10, offset: 0)),
                builder: (context, state) {
                 
                  if (state is LocalStorageLoadedMovies) {
                    final movies = state.movies;
                    if (movies.isEmpty) {
                      final colors = Theme.of(context).colorScheme;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite_outline_sharp,
                                size: 60, color: colors.primary),
                            Text('Ohhh no!!',
                                style: TextStyle(
                                    fontSize: 30, color: colors.primary)),
                            const Text('No tienes películas favoritas',
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            const SizedBox(height: 20),
                            FilledButton.tonal(
                                onPressed: () => context.go('/main-drawer'),
                                child: const Text('Empieza a buscar'))
                          ],
                        ),
                      );
                    }
                    return MovieMasonry(
                      loadNextPage: () {
                        context.read<LocalStorageBloc>().add(
                            LoadMoviesEvent(limit: 10, offset: movies.length));
                      },
                      movies: movies,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
