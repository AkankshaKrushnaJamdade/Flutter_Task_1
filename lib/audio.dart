import 'package:chewie_audio/chewie_audio.dart';
import 'package:chewie_audio/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class ChewieAudioDemo extends StatefulWidget {
  ChewieAudioDemo({this.title: ''});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieAudioDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieAudioController _chewieAudioController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
        'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3');
    _videoPlayerController2 = VideoPlayerController.asset('media/audio_1.mp3');

    _chewieAudioController = ChewieAudioController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: true,
    );
    _chewieAudioController = ChewieAudioController(
      videoPlayerController: _videoPlayerController2,
      autoPlay: false,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieAudioController.dispose();
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
          title: Text(
            'Music',
            style: TextStyle(
                color: Colors.white70,
                // fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset(
                  'media/icon.jpg',
                  height: 200,
                  width: 200,
                ),
              ),
              Center(
                child: ChewieAudio(
                  controller: _chewieAudioController,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          _chewieAudioController.dispose();
                          _videoPlayerController2.pause();
                          _videoPlayerController2.seekTo(Duration(seconds: 0));
                          _chewieAudioController = ChewieAudioController(
                            videoPlayerController: _videoPlayerController1,
                            autoPlay: true,
                            looping: true,
                          );
                        });
                      },
                      child: Padding(
                        child: Text("Online Audio",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        padding: EdgeInsets.all(13.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      splashColor: Colors.yellow[100],
                      color: Colors.lightBlue,
                      onPressed: () {
                        setState(
                          () {
                            _chewieAudioController.dispose();
                            _videoPlayerController1.pause();
                            _videoPlayerController1
                                .seekTo(Duration(seconds: 0));
                            _chewieAudioController = ChewieAudioController(
                              videoPlayerController: _videoPlayerController2,
                              autoPlay: true,
                              looping: true,
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Text(
                          "Downloads",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                width: 50,
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
      ),
    );
  }
}
