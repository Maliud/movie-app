import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDbKey = dotenv.env['THE_MOVIE_KEY'] ?? 'No key found';

  static Future<void> load() async {
    await dotenv.load(fileName: ".env");
  }
}
