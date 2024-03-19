
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimerCardMovie extends StatelessWidget {
  const ShimerCardMovie({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: colors.primary.withOpacity(0.3),
      child: Container(
          margin: const EdgeInsets.only(left: 12, right: 12, top: 5),
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            height: size.height * 0.25,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 16, top: 1),
              cacheExtent: 1,
              itemCount: 10,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 130,
                  // height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
          )
          //     ));
          ),
    );
  }
}
