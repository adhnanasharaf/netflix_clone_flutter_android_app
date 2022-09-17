import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/downloads/models/downloads.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieDate;

  const VideoListItemInheritedWidget({
    Key? key,
    required this.widget,
    required this.movieDate,
  }) : super(key: key, child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieDate != movieDate;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieDate.posterPath;
    final videoUrl = dummyvideoUrls[index % dummyvideoUrls.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(videoUrl: videoUrl, onStateChanged: (bool) {}),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //left side
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.8),
                  radius: 30,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.volume_off,
                      color: kWhiteColor,
                      size: 30,
                    ),
                  ),
                ),
                //right side
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: posterPath == null
                          ? null
                          : NetworkImage('$imageAppendUrl$posterPath'),
                    ),
                    ValueListenableBuilder(
                      valueListenable: likedVideosIdsNotifier,
                      builder: (BuildContext c, Set<int> newLikedListIds,
                          Widget? _) {
                        final _index = index;
                        if (newLikedListIds.contains(_index)) {
                          return GestureDetector(
                            onTap: () {
                              // BlocProvider.of<FastLaughBloc>(context)
                              //     .add(UnlikeVideos(id: _index));
                              likedVideosIdsNotifier.value.remove(_index);
                              likedVideosIdsNotifier.notifyListeners();
                            },
                            child: const VideoActionWidget(
                              icon: Icons.favorite,
                              title: "favorite",
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            // BlocProvider.of<FastLaughBloc>(context)
                            //     .add(LikeVideo(id: _index));
                            likedVideosIdsNotifier.value.add(_index);
                            likedVideosIdsNotifier.notifyListeners();
                          },
                          child: const VideoActionWidget(
                            icon: Icons.emoji_emotions,
                            title: "LOL",
                          ),
                        );
                      },
                    ),
                    const VideoActionWidget(icon: Icons.add, title: "My list"),
                    GestureDetector(
                      onTap: () {
                        final movieName =
                            VideoListItemInheritedWidget.of(context)
                                ?.movieDate
                                .title;
                        if (movieName != null) {
                          Share.share(movieName);
                        }
                      },
                      child: const VideoActionWidget(
                        icon: Icons.share,
                        title: "Share",
                      ),
                    ),
                    const VideoActionWidget(
                        icon: Icons.play_arrow, title: "Play")
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class VideoActionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionWidget({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          Text(
            title,
            style: const TextStyle(color: kWhiteColor),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer(
      {Key? key, required this.videoUrl, required this.onStateChanged})
      : super(key: key);

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {});
      _videoPlayerController.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
