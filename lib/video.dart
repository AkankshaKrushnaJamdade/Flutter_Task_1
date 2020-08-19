import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class ChewieDemo extends StatefulWidget {
  ChewieDemo({
    this.title = 'Videos',
  });

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4');
    _videoPlayerController2 =
        VideoPlayerController.asset('media/test_video.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title,
      theme: ThemeData.light().copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
              style: TextStyle(
                  color: Colors.white70,
                  // fontWeight: FontWeight.bold,
                  fontSize: 25)),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
            /*
            FlatButton(
              onPressed: () {
                _chewieController.enterFullScreen();
              },
              color: Colors.blue,
              child: Text(
                'Fullscreen',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            */
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Expanded(
                    child: FlatButton(
                      //color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          _chewieController.dispose();
                          _videoPlayerController2.pause();
                          _videoPlayerController2.seekTo(Duration(seconds: 0));
                          _chewieController = ChewieController(
                            videoPlayerController: _videoPlayerController1,
                            aspectRatio: 3 / 2,
                            autoPlay: true,
                            looping: true,
                          );
                        });
                      },
                      child: Padding(
                        child: Text("Online Video Player",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                        padding: EdgeInsets.symmetric(vertical: 1.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 10,
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Expanded(
                    child: FlatButton(
                      // color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          _chewieController.dispose();
                          _videoPlayerController1.pause();
                          _videoPlayerController1.seekTo(Duration(seconds: 0));
                          _chewieController = ChewieController(
                            videoPlayerController: _videoPlayerController2,
                            aspectRatio: 3 / 2,
                            autoPlay: true,
                            looping: true,
                          );
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.0),
                        child: Text("Offline video Player",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
              width: 20,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Icon(Icons.home),
            ),
          ],
        ),
      ),
    );
  }
}
