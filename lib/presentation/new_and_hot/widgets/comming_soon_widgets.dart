import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/main_page/widgets/custom_button_widget.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

class CommingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;
  const CommingSoonWidget({
    Key? key,
    required this.id,
    required this.month,
    required this.day,
    required this.posterPath,
    required this.movieName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(month,
                  style: const TextStyle(fontSize: 17, color: Colors.grey)),
              Text(
                day,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoWidget(
                url: posterPath,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1),
                    ),
                  ),
                  Row(
                    children: const [
                      CustombuttonWidget(
                        icon: Icons.notification_important,
                        title: "Remind me",
                        iconSize: 20,
                        textSize: 12,
                      ),
                      kwidth,
                      CustombuttonWidget(
                        icon: Icons.info,
                        title: "Info",
                        iconSize: 20,
                        textSize: 12,
                      ),
                      kwidth
                    ],
                  )
                ],
              ),
              Text("Comming on $day $month"),
              kheight,
              Text(
                movieName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kheight,
              Text(
                description,
                maxLines: 4,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ],
    );
  }
}
