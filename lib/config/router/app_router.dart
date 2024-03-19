import 'package:go_router/go_router.dart';
import 'package:movie_app/presentation/screens/favorites/favorites_screen.dart';
import 'package:movie_app/presentation/screens/main/main_drawer_screen.dart';
import 'package:movie_app/presentation/screens/movies/movie_screen.dart';
import 'package:movie_app/presentation/screens/splash/splash_screen.dart';

import '../../presentation/screens/movies/home_screen.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/main',
    builder: (context, state) => const MainDrawerScreen(),
  ),
  GoRoute(
    path: '/favorites',
    builder: (context, state) => const FavoritesScreen(),
  ),
  GoRoute(
    path: '/main-drawer',
    builder: (context, state) => const MainDrawerScreen(),
  ),
  GoRoute(
    path: '/movie',
    builder: (context, state) {
      final id = state.extra as Map;
      return MovieScreen(
      movieId: id['id'],
    );
    },
  ),





]);
