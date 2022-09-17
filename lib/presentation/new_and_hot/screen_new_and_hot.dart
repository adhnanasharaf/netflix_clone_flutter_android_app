import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/presentation/main_page/widgets/custom_button_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/comming_soon_widgets.dart';
import 'package:netflix/presentation/new_and_hot/widgets/everyones_watching_widget.dart';
import 'package:netflix/presentation/widgets/app_bar_widget.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

import '../../application/hot_and_new/hot_and_new_bloc.dart';
import '../../core/constants.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            title: Text(
              "New & Hot",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
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
            bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: kWhiteColor,
              labelColor: kBlackColor,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                  color: kWhiteColor, borderRadius: BorderRadius.circular(30)),
              tabs: const [
                Tab(
                  text: "🍿 comming soon",
                ),
                Tab(
                  text: "👀 everyone's watching",
                )
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            CommingSoonList(
              key: Key('comming_soon'),
            ),
            EveryoneIsWatchingList(
              key: Key("every_one_is_watching"),
            )
          ],
        ),
      ),
    );
  }

  _buildEveryOnesWatching() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, index) => SizedBox(),
    );
  }
}

class CommingSoonList extends StatelessWidget {
  const CommingSoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInCommingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInCommingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Errror While Loading Comming Soon List'),
            );
          } else if (state.commingSoonList.isEmpty) {
            return const Center(
              child: Text('Comming Soon List is Empty'),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemCount: state.commingSoonList.length,
              itemBuilder: ((BuildContext context, index) {
                final movie = state.commingSoonList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }
                String month;
                String day;
                try {
                  final _date = DateTime.tryParse(movie.releaseDate!);
                  final formattedDate =
                      DateFormat.yMMMMd('en_US').format(_date!);
                  month = formattedDate
                      .split(' ')
                      .first
                      .substring(0, 3)
                      .toUpperCase();
                  day = movie.releaseDate!.split('-')[1];
                } catch (_) {
                  month = '';
                  day = '';
                }

                return CommingSoonWidget(
                    id: movie.id.toString(),
                    month: month,
                    day: day,
                    posterPath: '$imageAppendUrl${movie.posterPath}',
                    movieName: movie.originalTitle ?? 'No title',
                    description: movie.overview ?? 'No Discription');
              }),
            );
          }
        },
      ),
    );
  }
}

/////////////////////////
class EveryoneIsWatchingList extends StatelessWidget {
  const EveryoneIsWatchingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryOneIsWatcing());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryOneIsWatcing());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Errror While Loading Comming Soon List'),
            );
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(
              child: Text('EveryOnesIsWatching List is Empty'),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: state.everyOneIsWatchingList.length,
              itemBuilder: ((BuildContext context, index) {
                final movie = state.everyOneIsWatchingList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }

                final tv = state.everyOneIsWatchingList[index];
                return EveryonesWatchingWiget(
                  posterPath: '$imageAppendUrl${tv.posterPath}',
                  movieName: tv.originalName ?? 'No name provided',
                  description: tv.overview ?? 'No Description',
                );
              }),
            );
          }
        },
      ),
    );
  }
}
