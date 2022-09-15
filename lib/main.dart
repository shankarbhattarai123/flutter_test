import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/blocs/video_bloc/video_bloc.dart';
import 'package:project_test/pages/videoplayerpage.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const StartPage(),
      ),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  late VideoPlayerController _controller3;
  var i = 0;
  late VideoBloc _videoBloc;
  List data = [];
  int video1Loop = 1;
  int rep = 10;

  @override
  void initState() {
    _videoBloc = BlocProvider.of<VideoBloc>(context);
    _videoBloc.add(GetVideoList());
    algoForLoop();
    super.initState();
  }

  void playVideo1() {
    // play video 10 times
    video1Play();
    _controller1.play();
    _controller1.initialize().then((_) => setState(() {}));
  }

  void algoForLoop() {
    if (video1Loop <= rep) {
      Future.delayed(const Duration(seconds: 5), () {
        video1Play();
      });
    }
  }

  void number2Loop() {
    if (video1Loop == (rep / 5) + rep) {
      Future.delayed(const Duration(seconds: 20), () {
        video2Play();
      });
    }
  }

  void number3Loop() {
    if (video1Loop <= (rep / 10) + rep) {
      Future.delayed(const Duration(seconds: 5), () {
        video3Play();
      });
    }
  }

  void video1Play() {
    video1Loop += 1;
    _controller1.play();
    _controller1.initialize().then((_) => setState(() {}));
    algoForLoop();
    if (video1Loop == 2) {
      _controller1.pause();
      video2Play();
    }
    setState(() {});
  }

  void video2Play() {
    video1Loop += 1;

    // _controller2.setLooping(true);
    _controller2.play();
    _controller2.initialize().then((_) => setState(() {}));
    number2Loop();
    if (video1Loop == 2) {
      _controller2.pause();
      video3Play();
    }
    setState(() {});
  }

  void video3Play() {
    video1Loop += 1;
    _controller3.play();
    _controller3.initialize().then((_) => setState(() {}));
    number3Loop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test app"),
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
              child: BlocListener<VideoBloc, VideoState>(
            listener: (context, state) {
              if (state is VideoLaodWaiting) {
                // EasyLoading.show(status: "loading");
              } else if (state is VideoLaodError) {
                // EasyLoading.showError("error occured");
              } else if (state is GetVideoListSuccess) {
                data.addAll(state.videoData);
                _controller1 = VideoPlayerController.asset(data[0].url)
                  ..initialize().then((_) {
                    setState(() {});
                  });

                _controller2 = VideoPlayerController.asset(data[1].url)
                  ..initialize().then((_) {});
                _controller3 = VideoPlayerController.asset(data[2].url)
                  ..initialize().then((_) {
                    setState(() {});
                  });
                setState(() {});

                rep = data[0].repetation;
              }
            },
            child: data.isNotEmpty
                ? Column(
                    children: <Widget>[
                      VideoPlayerpage(controller: _controller1),
                      VideoPlayerpage(controller: _controller2),
                      VideoPlayerpage(controller: _controller3),
                    ],
                  )
                : Container(),
          )),
        ),
      ),
    );
  }
}
