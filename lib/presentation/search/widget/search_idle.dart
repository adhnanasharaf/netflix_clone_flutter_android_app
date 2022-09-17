import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/search/widget/title.dart';

class SearchIdle extends StatelessWidget {
  const SearchIdle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchTextTitle(
          title: "Top Searches",
        ),
        kheight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.isError) {
                return const Center(child: Text("Error While getting data"));
              } else if (state.idleList.isEmpty) {
                return const Center(child: Text("list is empty"));
              }
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  final movie = state.idleList[index];
                  return TopSearchItemTile(
                      title: movie.title ?? 'No title Provided',
                      imageUrl: '$imageAppendUrl${movie.posterPath}');
                },
                separatorBuilder: (ctx, index) => kheight,
                itemCount: state.idleList.length,
              );
            },
          ),
        )
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTile(
      {Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.5,
          height: 100,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl),
          )),
        ),
        kwidth,
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: kWhiteColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Icon(
          CupertinoIcons.play,
          color: kWhiteColor,
        )
      ],
    );
  }
}
