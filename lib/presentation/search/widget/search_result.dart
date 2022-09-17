import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/search/widget/title.dart';

import '../../../application/search/search_bloc.dart';

// const imageUrl =
//     "https://image.tmdb.org/t/p/w220_and_h330_face/9MP21x0OPv0R72obd63tMHssmGt.jpg";

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(
          title: "Movies & TV8",
        ),
        kheight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return GridView.count(
                shrinkWrap: true,
                mainAxisSpacing: 7,
                crossAxisSpacing: 7,
                crossAxisCount: 3,
                childAspectRatio: 1.2 / 1.9,
                children: List.generate(20, (index) {
                  final movie = state.searchResultList[index];
                  return MainCard(
                    imageUrl: movie.posterImageUrl,
                  );
                }),
              );
            },
          ),
        )
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
