// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/movie.dart';
import '../../delegates/search_movie_delegate.dart';

//
class CustomAppbar extends StatelessWidget {
  final String title;
  final bool showLeading;

  const CustomAppbar(
      {Key? key, required this.title, required this.showLeading});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  // Acceder al MovieBloc
                  // movieBloc.getAllMovies(); // Ejemplo: Llamada a un método del MovieBloc
                  ZoomDrawer.of(context)!.toggle();
                },
                icon: Icon(Icons.movie_outlined, color: colors.primary),
              ),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 190, 89, 208),
                  highlightColor: const Color.fromARGB(255, 68, 33, 243),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (showLeading)
                IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                       await showSearch<Movie?>(
                              context: context, delegate: SearchMovieDelegate())
                          .then((movie) {
                        if (movie != null) {
                          context.push('/movie', extra: {'id': movie.id});
                        }
                      });
                    })
            ],
          ),
        ),
      ),
    );
  }
}

class MovieBloc {}
