import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 150,
            ),
            Container(
              width: 150,
              height: 230,
              decoration: BoxDecoration(
                borderRadius: kradius20,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w220_and_h330_face/hIkKM1nlzk8DThFT4vxgW1KoofL.jpg"),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 13,
          bottom: 0,
          child: BorderedText(
            strokeWidth: 5.0,
            strokeColor: kWhiteColor,
            child: Text(
              "${index + 1}",
              style: TextStyle(fontSize: 100, color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
