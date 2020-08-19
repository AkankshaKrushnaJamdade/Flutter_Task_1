import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'video.dart';
import 'audio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BaseApp(),
      routes: <String, WidgetBuilder>{
        '/home': (context) => BaseApp(),
        '/ChewieAudioDemo': (context) => ChewieAudioDemo(),
        '/ChewieDemo': (context) => ChewieDemo()
      },
    );
  }
}

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                      child: Row(children: <Widget>[
                    Icon(
                      Icons.home,
                      color: Colors.white70,
                    ),
                    Text('Home',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ])),
                  Tab(
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/ChewieAudioDemo');
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.music_note,
                                color: Colors.white70,
                              ),
                              Text('Music',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ],
                          ))),
                  Tab(
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/ChewieDemo');
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.video_library,
                                color: Colors.white70,
                              ),
                              Text('Videos',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 13))
                            ],
                          ))),
                ],
              ),
              title: Text('Media Player',
                  style: TextStyle(
                      color: Colors.white70,
                      // fontWeight: FontWeight.bold,
                      fontSize: 25)),
            ),
            body: TabBarView(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Text('Welcome to media Player',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27)

                              //   style: DefaultTextStyle.of(context)
                              //  .style
                              //  .apply(fontSizeFactor: 0.5),
                              )),
                      Container(
                          child: Image.asset(
                        'media/media.PNG',
                      )),
                      // height: double.infinity,

                      // width: double.infinity,)),
                    ],
                  ),
                ),
                Container(),
                Container()
              ],
            )),
      ),
    );
  }
}
