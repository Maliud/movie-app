// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:movie_app/presentation/widgets/shared/custom_appbar.dart';

import '../../widgets/movies/MovieList.dart';
import '../../widgets/movies/textInfoMovie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
        body: Scaffold(
      // backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(children: [
          CustomAppbar(
            title: 'Film Önerileri',
            showLeading: true,
          ),
           TextInfoMovie(
            title: 'Sinemada',
          ),
          MoviesListWidget(
            item: 1,
          ),
          TextInfoMovie(
            title: 'Yüksek Puanlı Filmler',
          ),
          MoviesListWidget(
            item: 2,
          ),
          TextInfoMovie(
            title: 'Yakında gelecek Olanlar',
          ),
          MoviesListWidget(
            item: 3,
          ),
          SizedBox(
            height:30,
          ),
          // MoviesPopularListWidget(),
        ]),
      ),
    ));
  }
}
