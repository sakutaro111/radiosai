import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:radiosai/constants/constants.dart';
import 'package:radiosai/views/stream_select.dart';

class StreamPlayer extends StatefulWidget {
  StreamPlayer({Key key}) : super(key: key);

  var playerState = FlutterRadioPlayer.flutter_radio_stopped;

  @override
  _StreamPlayer createState() => _StreamPlayer();
}

class _StreamPlayer extends State<StreamPlayer> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;

  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init("Radio Sai", "radiosai", MyConstants.of(context).streamLink[0], "false");
      await _flutterRadioPlayer.play();
    } on PlatformException {
      print("Execption while registering");
    }
  }

  Future<void> playRadioService() async {
    await _flutterRadioPlayer.play();
  }

  Future<void> stopRadioService() async {
    await _flutterRadioPlayer.stop();
  }

  void _handleOnPressed() {
    setState(() async {
      isPlaying = !isPlaying;
      if(isPlaying) {
        _animationController.forward().then((value) => initRadioService());
        //await initRadioService();
      } else {
        _animationController.reverse().then((value) => stopRadioService());
        // await stopRadioService();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image(
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/sai_listens.jpg'),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Opacity(
                  opacity: 0.7,
                  child: IconButton(
                    iconSize: 90,
                    color: Colors.white,
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: _animationController,
                    ),
                    onPressed: () async {
                      _handleOnPressed();
                    },
                  )
                ),
                StreamBuilder(
                  stream: _flutterRadioPlayer.isPlayingStream,
                  initialData: widget.playerState,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    String returnData = snapshot.data;
                    print("object data: " + returnData);
                    switch(returnData) {
                      case FlutterRadioPlayer.flutter_radio_paused:
                        _flutterRadioPlayer.play();
                        return Text('Loading stream..'); // TODO: add loading widget
                      case FlutterRadioPlayer.flutter_radio_stopped:
                        return Text('Play');
                        break;
                      case FlutterRadioPlayer.flutter_radio_loading:
                      // TODO: add loading widget
                        return Text("Loading stream..");
                      case FlutterRadioPlayer.flutter_radio_error:
                        // TODO: add notify to retry or check internet or so
                        return Text('Retry');
                        break;
                      default:
                        return Text('Playing');
                    }
                  },
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.12,
            minChildSize: 0.12,
            maxChildSize: 0.67,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: StreamSelect(),
              );
            },
          ),
        ],
      ),
    );
  }
}
