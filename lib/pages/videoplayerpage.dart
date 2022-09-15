import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerpage extends StatefulWidget {
  VideoPlayerpage({Key? key, required this.controller}) : super(key: key);
  VideoPlayerController controller;

  @override
  State<VideoPlayerpage> createState() => _VideoPlayerpageState();
}

class _VideoPlayerpageState extends State<VideoPlayerpage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: VideoPlayer(widget.controller),
        ),
        Container(
            child: VideoProgressIndicator(widget.controller,
                allowScrubbing: true,
                colors: VideoProgressColors(
                  backgroundColor: Colors.redAccent,
                  playedColor: Colors.green,
                  bufferedColor: Colors.purple,
                ))),
        Container(
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    if (widget.controller.value.isPlaying) {
                      widget.controller.pause();
                    } else {
                      widget.controller.play();
                    }

                    setState(() {});
                  },
                  icon: Icon(widget.controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow)),
            ],
          ),
        ),
      ],
    );
  }

  void loopVideo() {
    widget.controller.value.isLooping
        ? widget.controller.play()
        : widget.controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }
}
