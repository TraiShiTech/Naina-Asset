import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webviewx/webviewx.dart';

import '../../../core/utils/metrics.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late WebViewXController webviewController;
  late VideoPlayerController _controller;
  @override
  void initState() {
    readDataaa2();
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse('https://www.youtube.com/embed/LRGmsXvMaHU?si=z8L9TKYsHMkCmJe1'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        // _controller.setLooping(true); // Set the video to loop
        // _controller.play(); // Start playing the video
      });
  }

  void dispose() {
    webviewController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<Null> readDataaa2() async {
    Future.delayed(const Duration(seconds: 1), () {
      webviewController.loadContent(
        //'${webviewModel[0].url.toString().trim()}',
        'https://www.dzentric.com/chao_properties/YOU.html',
        SourceType.URL,
      );
    });
  }

  Widget build(BuildContext context) {
    // return Center(
    //   child: WebViewX(
    //     javascriptMode: JavascriptMode.unrestricted,
    //     // width: 100,
    //     // height: 450,
    //     initialContent: '<h2> Hello, world! </h2>',
    //     initialSourceType: SourceType.HTML,
    //     onWebViewCreated: (controller) => webviewController = controller,
    //   ),
    // );
    _controller.setLooping(true); // Set the video to loop
    _controller.play(); // Start playing the video
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }
}
