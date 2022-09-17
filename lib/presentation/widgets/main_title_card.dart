import 'package:flutter/material.dart';

import 'main_card.dart';
import 'main_title.dart';

class MainTitleCard extends StatelessWidget {
  final String title;
  final List<String> posterList;

  const MainTitleCard({
    Key? key,
    required this.title,
    required this.posterList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: title),
        LimitedBox(
          maxHeight: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterList.length,
              (index) => MainCard(
                imageUrl: posterList[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
