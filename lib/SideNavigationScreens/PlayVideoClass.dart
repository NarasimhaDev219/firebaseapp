import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideoScreen extends StatefulWidget {
  @override
  _PlayVideoScreenState createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  VideoPlayerController _videoPlayerController;
  Future<void> initialize_video_palyer;
  String url =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";

  @override
  void initState(){
    _videoPlayerController = VideoPlayerController.network(url);
     initialize_video_palyer = _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: FutureBuilder(
          future: initialize_video_palyer,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
         
          onPressed: () {
            setState(() {
              if (_videoPlayerController.value.isPlaying) {
              _videoPlayerController.pause();
              
            } else {
              _videoPlayerController.play();
            }
            });
          },
           child: Icon(_videoPlayerController.value.isPlaying
              ? Icons.pause : Icons.play_arrow),
          ),
    );
  }
}
