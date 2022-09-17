import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/presentation/main_page/widgets/custom_button_widget.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/w600_and_h900_bestv2/4Q1n3TwieoULnuaztu9aFjqHDTI.jpg"),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustombuttonWidget(icon: Icons.add, title: "MyList"),
                _PlayButton(),
                CustombuttonWidget(icon: Icons.info, title: "Info")
              ],
            ),
          ),
        )
      ],
    );
  }

  TextButton _PlayButton() {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.play_arrow),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text("play"),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kWhiteColor),
      ),
    );
  }
}
