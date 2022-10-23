import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// ignore: must_be_immutable
class YoutubePlayerWidget extends StatefulWidget {
  String videoId;
  YoutubePlayerController youtubePlayerController;
  YoutubePlayerWidget({
    Key? key,
    required this.youtubePlayerController,
    required this.videoId,
  }) : super(key: key);

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayerWidget> {
  bool autoPlay = false;

  //late YoutubePlayerController _controller;
  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;

  @override
  void initState() {
    //_controller = widget.youtubePlayerController;
    //  YoutubePlayerController(
    //   params: const YoutubePlayerParams(
    //     mute: false,
    //     showControls: true,
    //     //showFullscreenButton: true,
    //     loop: false,
    //   ),
    // )..onInit = () {
    //     // if (autoPlay) {
    //     //   _controller.loadVideoById(videoId: "JGBa03UPCBU", startSeconds: 1);
    //     // } else {
    //     _controller.cueVideoById(videoId: widget.videoId, startSeconds: 1);
    //     _controller.loadVideoById(videoId: widget.videoId);
    //     // }
    //   };
    widget.youtubePlayerController.onInit = (){
        widget.youtubePlayerController.cueVideoById(videoId: widget.videoId, startSeconds: 1);
        widget.youtubePlayerController.loadVideoById(videoId: widget.videoId);
    };
    videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.unknown;
    super.initState();
  }

  @override
  void deactivate() {
    widget.youtubePlayerController.pauseVideo();
    widget.youtubePlayerController.stopVideo();
    widget.youtubePlayerController.webViewController.ignore();
    super.deactivate();
  }

  @override
  void dispose() {
    // _controller.webViewController.ignore();
    // _controller.close();
         widget.youtubePlayerController.webViewController.ignore();
     widget.youtubePlayerController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
      controller: widget.youtubePlayerController,
      // _controller,
      child: YoutubePlayer(
        controller: widget.youtubePlayerController,
        // _controller,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
