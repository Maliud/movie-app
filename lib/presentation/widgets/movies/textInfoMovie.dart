
// ignore_for_file: file_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInfoMovie extends StatelessWidget {
  const TextInfoMovie({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();

    final colors = Theme.of(context).colorScheme;
    return BounceInUp(
      duration: const Duration(seconds: 2),
      child: Container(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.rubik(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: colors.primary),
                textAlign: TextAlign.left,
              ),
             
              Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
            
                child: Center(
                  child: Text(
                 
                    '${date.day}/${date.month}/${date.year}',

                    style: GoogleFonts.rubik(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
