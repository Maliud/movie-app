import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      context.go('/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black87,
            Theme.of(context).colorScheme.primary
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BounceInDown(
            duration: const Duration(seconds: 2),
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 190, 89, 208),
              highlightColor: const Color.fromARGB(255, 68, 33, 243),
              child: const Text(
                'Film Önerileri',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 190, 89, 208),
                  highlightColor: const Color.fromARGB(255, 68, 33, 243),
                  child: Icon(
                    Icons.movie,
                    color: Theme.of(context).colorScheme.primary,
                    size: 180,
                  ))
              .animate()
              .rotate(
                  begin: 0.1,
                  duration: 450.ms,
                  delay: 200.ms,
                  alignment: Alignment.topCenter),

          //poenmos el gif
        ],
      ),
    ));
  }
}
