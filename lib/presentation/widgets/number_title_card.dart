import 'package:flutter/material.dart';
import 'package:netflix/presentation/widgets/main_title.dart';
import 'package:netflix/presentation/widgets/number_card.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: "Top 10 TV shows in India"),
        LimitedBox(
          maxHeight: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(10, (index) => NumberCard(index: index)),
          ),
        ),
      ],
    );
  }
}
