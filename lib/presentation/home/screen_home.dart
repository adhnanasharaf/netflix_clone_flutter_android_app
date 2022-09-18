import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/widgets/main_card.dart';
import 'package:netflix/presentation/widgets/main_title.dart';
import 'package:netflix/presentation/widgets/main_title_card.dart';
import 'package:netflix/presentation/widgets/number_card.dart';
import 'package:netflix/presentation/widgets/number_title_card.dart';

import '../main_page/widgets/background_card.dart';
import '../main_page/widgets/custom_button_widget.dart';

ValueNotifier<bool> scrolllNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
      },
    );
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: scrolllNotifier,
      builder: (BuildContext context, index, _) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            if (direction == ScrollDirection.reverse) {
              scrolllNotifier.value = false;
            } else if (direction == ScrollDirection.forward) {
              scrolllNotifier.value = true;
            }
            return true;
          },
          child: Stack(
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.hasError) {
                    return const Text(
                      'Error While Getting Data',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                  //released pastyear
                  final _releasedPastYear = state.pastYearMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //trending
                  final _trending = state.trendigMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //tenseDramas
                  final _tenseDramas = state.tenseDramasMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //_southIndianMovies
                  final _southIndianMovies =
                      state.southIndianMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //top 10 tv shows
                  final _top10TvShows = state.trendingTvList.map((t) {
                    return '$imageAppendUrl${t.posterPath}';
                  }).toList();
                  _top10TvShows.shuffle();

                  return ListView(
                    children: [
                      BackgroundCard(),
                      MainTitleCard(
                        title: "Released in the past year",
                        posterList: _releasedPastYear,
                      ),
                      MainTitleCard(
                        title: "Trending Now",
                        posterList: _trending,
                      ),
                      NumberTitleCard(postersList: _top10TvShows),
                      MainTitleCard(
                        title: "Tense Dramas",
                        posterList: _tenseDramas,
                      ),
                      MainTitleCard(
                        title: "South Indian Cinema",
                        posterList: _southIndianMovies,
                      ),
                    ],
                  );
                },
              ),
              scrolllNotifier.value == true
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      width: double.infinity,
                      height: 100,
                      color: Colors.black.withOpacity(0.4),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.network(
                                  "https://media-exp1.licdn.com/dms/image/C4E0BAQEVb0ZISWk8vQ/company-logo_200_200/0/1519896425167?e=2147483647&v=beta&t=xztAGLJ8SUh-lHaDSK-a3cxYCfSYAy8wrPg3jTx15W8",
                                  width: 50,
                                  height: 50,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.cast,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                kwidth,
                                Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "TV Shows",
                                style: KHomeTitleTextTop,
                              ),
                              Text(
                                "Movies",
                                style: KHomeTitleTextTop,
                              ),
                              Text(
                                "Categories",
                                style: KHomeTitleTextTop,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : kheight
            ],
          ),
        );
      },
    ));
  }
}
