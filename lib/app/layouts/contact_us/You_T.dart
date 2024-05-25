import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:video_player/video_player.dart';
import 'package:webviewx/webviewx.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'dart:html' as html;

import '../../../core/utils/metrics.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late WebViewXController webviewController;
  late YoutubePlayerController Y_controller;
  // late VideoPlayerController _controller;
  String videoURL = 'https://www.youtube.com/watch?v=LRGmsXvMaHU';

  @override
  void initState() {
    readDataaa2();

    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    Y_controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    // _controller = VideoPlayerController.networkUrl(Uri.parse('https://www.youtube.com/embed/LRGmsXvMaHU?autoplay=1'))
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    super.initState();
  }

  void dispose() {
    webviewController.dispose();
    Y_controller.dispose();
    super.dispose();
  }

  Future<Null> readDataaa2() async {
    Future.delayed(const Duration(seconds: 1), () {
      webviewController.loadContent(
        //'${webviewModel[0].url.toString().trim()}',
        'https://www.youtube.com/embed/LRGmsXvMaHU?autoplay=1',

        SourceType.URL,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebViewX(
        javascriptMode: JavascriptMode.unrestricted,
        // width: 100,
        // height: 450,
        initialContent: '<h2> Hello, world! </h2>',
        initialSourceType: SourceType.HTML,
        onWebViewCreated: (controller) => webviewController = controller,
      ),
    );
    // _controller.play();
    // return Center(
    //   child: _controller.value.isInitialized
    //       ? AspectRatio(
    //           aspectRatio: _controller.value.aspectRatio,
    //           child: VideoPlayer(_controller),
    //         )
    //       : Container(),
    // );
    // return Center(
    //   child: YoutubePlayer(

    //     controller: Y_controller,

    //     showVideoProgressIndicator: true,
    //     progressIndicatorColor: Colors.amber,
    //     progressColors: const ProgressBarColors(
    //       playedColor: Colors.amber,
    //       handleColor: Colors.amberAccent,
    //     ),
    //     onReady: () {
    //       print('Player is ready.');
    //     },
    //   ),
    // );

    // return OfflineBuilder(
    //   connectivityBuilder: (
    //     BuildContext context,
    //     ConnectivityResult connectivity,
    //     Widget child,
    //   ) {
    //     final bool connected = connectivity != ConnectivityResult.none;
    //     return Center(
    //         child: connected
    //             ? YoutubePlayer(
    //                 controller: Y_controller,
    //                 showVideoProgressIndicator: false,
    //                 // progressIndicatorColor: Colors.amber,
    //                 // progressColors: const ProgressBarColors(
    //                 //   playedColor: Colors.amber,
    //                 //   handleColor: Colors.amberAccent,
    //                 // ),

    //                 onReady: () {
    //                   print('Player is ready.');
    //                 },
    //               )
    //             : Text('Disconnect'));
    //   },
    //   child: Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
  }
}
