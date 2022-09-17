import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/main_page/widgets/custom_button_widget.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

class EveryonesWatchingWiget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;
  const EveryonesWatchingWiget({
    Key? key,
    required this.posterPath,
    required this.movieName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kheight,
        Text(
          movieName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        kheight,
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: 50,
        ),
        VideoWidget(
          url: posterPath,
        ),
        kheight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CustombuttonWidget(
              icon: Icons.share,
              title: "share",
              iconSize: 25,
              textSize: 16,
            ),
            kwidth,
            CustombuttonWidget(
              icon: Icons.add,
              title: "MyList ",
              iconSize: 25,
              textSize: 16,
            ),
            kwidth,
            CustombuttonWidget(
              icon: Icons.play_arrow,
              title: "play",
              iconSize: 25,
              textSize: 16,
            ),
            kwidth,
          ],
        )
      ],
    );
  }
}
