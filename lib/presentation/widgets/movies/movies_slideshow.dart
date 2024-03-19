import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';

class MoviesSlideshow extends StatelessWidget {
  final Movie movie;

  const MoviesSlideshow({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        context.push('/movie', extra: {'id': movie.id});
     
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Imagen
              SizedBox(
                width: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    width: 150,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return Image.asset(
                          'assets/images/no-image.jpg',
                          fit: BoxFit.cover,
                          width: 150,
                        );
                      }
                      return FadeIn(child: child);
                    },
                  ),
                ),
              ).animate().rotate(
                  begin: 0.1,
                  duration: 250.ms,
                  delay: 180.ms,
                  alignment: Alignment.topCenter),

              const SizedBox(height: 5),

              //* Title
              SizedBox(
                width: 150,
                child: Text(
                  movie.title,
                  maxLines: 2,
                  style: textStyles.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Icon(Icons.language, color: colors.primary),
                    const SizedBox(width: 3),
                    Text(
                      movie.originalLanguage,
                      maxLines: 2,
                      style: textStyles.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              //* Rating
              SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Icon(Icons.star_half_outlined,
                        color: Colors.yellow.shade800),
                    const SizedBox(width: 3),
                    Text('${movie.voteAverage}',
                        style: textStyles.bodyMedium
                            ?.copyWith(color: Colors.yellow.shade800)),
                    const Spacer(),
                    // Text(HumanFormats.number(movie.popularity),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
