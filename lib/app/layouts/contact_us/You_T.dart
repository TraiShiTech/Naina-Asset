import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

import '../../../core/utils/metrics.dart';

class VideoPlayer extends StatefulWidget {
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late WebViewXController webviewController;
  @override
  void initState() {
    readDataaa2();
    super.initState();
  }

  void dispose() {
    webviewController.dispose();
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
  }
}
