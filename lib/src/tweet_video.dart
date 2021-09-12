import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:url_launcher/url_launcher.dart';

class TweetVideo extends StatefulWidget {
  const TweetVideo(
    this.tweetVM, {
    Key? key,
    this.initialVolume = 0.0,
    this.autoPlay = false,
    this.enableFullscreen = true,
    this.videoHighQuality = true,
  }) : super(key: key);

  final TweetVM tweetVM;
  final double? initialVolume;
  final bool autoPlay;
  final bool enableFullscreen;
  final bool? videoHighQuality;

  @override
  _TweetVideoState createState() => _TweetVideoState();
}

class _TweetVideoState extends State<TweetVideo>
    with AutomaticKeepAliveClientMixin {
  late BetterPlayerConfiguration betterPlayerConfiguration;
  late BetterPlayerController controller;

  @override
  void initState() {
    super.initState();
    betterPlayerConfiguration = BetterPlayerConfiguration(
      placeholder: const Center(
        child: SizedBox(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(),
        ),
      ),
      errorBuilder: (context, message) {
        return const Text('Error while loading video :-(');
      },
      aspectRatio: widget.tweetVM.getDisplayTweet().videoAspectRatio,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        enablePlaybackSpeed: false,
        enableSkips: false,
        enableMute: !widget.tweetVM.getDisplayTweet().hasGif,
        showControls: !widget.tweetVM.getDisplayTweet().hasGif,
        enableSubtitles: false,
        enableFullscreen: widget.enableFullscreen,
      ),
      allowedScreenSleep: false,
      deviceOrientationsOnFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],
      fullScreenAspectRatio: widget.tweetVM.getDisplayTweet().videoAspectRatio,
      autoPlay: widget.tweetVM.getDisplayTweet().hasGif || widget.autoPlay,
      looping: widget.tweetVM.getDisplayTweet().hasGif,
      overlay: Padding(
        padding: const EdgeInsets.only(
          left: 4.0,
        ),
        child: widget.tweetVM.getDisplayTweet().hasGif
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/tw__ic_gif_badge.png',
                  fit: BoxFit.fitWidth,
                  package: 'tweet_ui',
                  height: 16,
                  width: 16,
                ),
              )
            : Container(),
      ),
    );
    final videoUrl = widget.videoHighQuality!
        ? widget.tweetVM.getDisplayTweet().videoUrls.values.last
        : widget.tweetVM.getDisplayTweet().videoUrls.values.first;
    controller = BetterPlayerController(
      betterPlayerConfiguration,
      betterPlayerDataSource: BetterPlayerDataSource.network(
        videoUrl,
        qualities: widget.tweetVM.getDisplayTweet().videoUrls,
      ),
    );
    controller.setVolume(widget.initialVolume!);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // web or mobile, doesn't work on desktop
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      return BetterPlayer(
        controller: controller,
      );
    }

    return SizedBox(
      height: 200,
      width: 300,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Video doesn't work on desktop.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final video =
                    widget.tweetVM.getDisplayTweet().videoUrls.values.last;

                if (await canLaunch(video)) {
                  await launch(video);
                } else {
                  print('Could not launch $video');
                }
              },
              child: const Text('Open in Browser'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
