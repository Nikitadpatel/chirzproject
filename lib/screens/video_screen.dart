// import 'package:chirz/screens/homescreen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// import 'explore.dart';
//
// class VideoIntroScreen extends StatefulWidget {
//   const VideoIntroScreen({Key? key}) : super(key: key);
//
//   @override
//   _VideoIntroScreenState createState() => _VideoIntroScreenState();
// }
//
// class _VideoIntroScreenState extends State<VideoIntroScreen> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset('assets/chirz_video.mp4');
//     _controller.addListener(() {
//       if (!_controller.value.isPlaying &&
//           _controller.value.isInitialized &&
//           (_controller.value.duration == _controller.value.position)) {
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ExplorerScreen(),
//             ));
//         _controller.dispose();
//       }
//     });
//     _controller.initialize().then((_) => setState(() {}));
//     _controller.play();
//
//     _controller.setLooping(false);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: VideoPlayer(
//           _controller,
//         ),
//       ),
//     );
//   }
// }
