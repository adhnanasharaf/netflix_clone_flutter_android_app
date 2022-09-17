import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/downloads/downloads_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
import 'package:netflix/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({Key? key}) : super(key: key);
  final _widgetList = [
    const _smartWidget(),
    Section2(),
    const Section3(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarWidget(
          title: "Downloads",
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (ctx, index) => _widgetList[index],
        separatorBuilder: (ctx, index) => const SizedBox(
          height: 20,
        ),
        itemCount: _widgetList.length,
      ),
    );
  }
}

class Section2 extends StatelessWidget {
  Section2({Key? key}) : super(key: key);

  // final List imagelist = [
  //   "https://image.tmdb.org/t/p/w220_and_h330_face/9MP21x0OPv0R72obd63tMHssmGt.jpg",
  //   "https://image.tmdb.org/t/p/w220_and_h330_face/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg",
  //   "https://image.tmdb.org/t/p/w220_and_h330_face/45YC86aMjWlcPkvgWwqdI6Clq7b.jpg"
  // ];
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(DownloadsEvent.getDownloadsImages());
    });
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          "Introducing Downloads for you",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: kWhiteColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        kheight,
        const Text(
          "We will download a personalised selection of |n movies and shows for you, so there's \n always something to watch on your \n device",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            return SizedBox(
              width: size.width,
              height: size.width,
              child: state.isLoading
                  ? Center(child: const CircularProgressIndicator())
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: size.width * 0.4,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                        ),
                        downloadsImageWidget(
                          imagelist:
                              '$imageAppendUrl${state.downloads[0].posterPath}',
                          margin: const EdgeInsets.only(
                            left: 150,
                            bottom: 50,
                          ),
                          angle: 20,
                          size: Size(size.width * 0.4, size.width * 0.58),
                        ),
                        downloadsImageWidget(
                          imagelist:
                              '$imageAppendUrl${state.downloads[1].posterPath}',
                          margin: const EdgeInsets.only(
                            right: 150,
                            bottom: 50,
                          ),
                          angle: -20,
                          size: Size(size.width * 0.4, size.width * 0.58),
                        ),
                        downloadsImageWidget(
                          imagelist:
                              '$imageAppendUrl${state.downloads[2].posterPath}',
                          borderRadius: 20,
                          margin: const EdgeInsets.only(bottom: 10),
                          size: Size(size.width * 0.45, size.width * 0.64),
                        ),
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 350,
          child: MaterialButton(
            color: kButtonColorBlue,
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Set Up",
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        kheight,
        MaterialButton(
          color: kButtonColorWhite,
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "See what you can download",
              style: TextStyle(
                color: kBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _smartWidget extends StatelessWidget {
  const _smartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        kwidth,
        Text("Smart Downloads"),
      ],
    );
  }
}

class downloadsImageWidget extends StatelessWidget {
  const downloadsImageWidget({
    Key? key,
    required this.imagelist,
    this.angle = 0,
    required this.margin,
    required this.size,
    this.borderRadius = 10,
  }) : super(key: key);

  final String imagelist;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        // color: Colors.black,
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              imagelist,
            ),
          ),
        ),
      ),
    );
  }
}
