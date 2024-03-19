// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:movie_app/presentation/screens/favorites/favorites_screen.dart';
import 'package:movie_app/presentation/screens/movies/home_screen.dart';
import 'package:movie_app/presentation/screens/splash/splash_screen.dart';

import '../../blocs/theme/theme_bloc.dart';

class MainDrawerScreen extends StatefulWidget {
  const MainDrawerScreen({Key? key}) : super(key: key);

  @override
  State<MainDrawerScreen> createState() => _MainDrawerScreenState();
}

class _MainDrawerScreenState extends State<MainDrawerScreen> {
  Widget page =  const HomeScreen();


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ZoomDrawer(
        menuScreen: MenuScreen(
          onPageChanged: (a) {
            setState(() {
              page = a;
            });
          },
        ),
        mainScreen: page,

        borderRadius: 24.0,
        showShadow: true,
        drawerShadowsBackgroundColor: Colors.grey[300]!,
        menuBackgroundColor: colors.primary);
  }
}



class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key, required this.onPageChanged}) : super(key: key);

  final Function(Widget) onPageChanged;

  List<ListItems> drawerItems = [
    ListItems(title: 'Anasayfa', icon: Icons.home, widget: const HomeScreen()),
    ListItems(title: 'Favorilerim', icon: Icons.favorite, widget: const FavoritesScreen()),
    ListItems(title: 'Çıkış', icon: Icons.toc, widget: const SplashScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.primary,
      body: Padding(
        padding: const EdgeInsets.only(top: 200, left: 15, right: 15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Anasayfa'),
              onTap: () {
                ZoomDrawer.of(context)!.close();
                onPageChanged(const HomeScreen());

              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Favorilerim'),
              onTap: () {
                ZoomDrawer.of(context)!.close();
                onPageChanged(const FavoritesScreen());
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.toc),
              title: const Text('Çıkış'),
              onTap: () {
                ZoomDrawer.of(context)!.close();
                onPageChanged(const SplashScreen());
              },
            ),
          ),
          Card(
            child: Container(
              width: double.infinity,
              // height: 70,
              padding: const EdgeInsets.only(left: 20),
              child:
                
                  BlocBuilder<ThemeBloc, DarkModeState>(
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                      value: state.theme == AppTheme.dark,
                      title: const Text('Tema'),
                   
                      onChanged: (value) {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ToggleDarkMode());
                      });
                },
              ),
            ),
          ),
        ]
    
            ),
      ),
    );
  }
}


class ListItems {
  final String title;
  final IconData icon;
  final  Widget widget;

  ListItems({
    required this.title,
    required this.icon,
    required this.widget,
  });
}
