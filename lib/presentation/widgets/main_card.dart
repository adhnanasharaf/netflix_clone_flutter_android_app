import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 150,
        height: 230,
        decoration: BoxDecoration(
            borderRadius: kradius20,
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(imageUrl))),
      ),
    );
  }
}
