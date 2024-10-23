import 'package:flutter/material.dart';
import 'package:home_camera/models/camera_stream_set.dart';
import 'package:home_camera/models/camera_stream_url.dart';
import 'package:home_camera/pages/add_camera_screen.dart';
import 'package:home_camera/services/app_service.dart';
import 'package:home_camera/utils/constants.dart';
import 'package:home_camera/widgets/camera_card.dart';
import 'package:home_camera/widgets/camera_feed_widget.dart';
import 'package:home_camera/widgets/event_list_tile.dart';
import 'package:home_camera/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraStreamUrl currentStream = CameraStreamUrl();
  CameraStreamSet streamSet = CameraStreamSet();

  @override
  void initState() {
    // context.read<AppService>().cameras.forEach((camera) {
    // streamSet.addStream(CameraStreamUrl.fromCamera(camera));
    // });
    _setStreams();

    context.read<AppService>().addListener(() {
      _setStreams();
    });

    super.initState();
  }

  void _setStreams() {
    CameraStreamUrl? defaultStream =
        context.read<AppService>().getDefaultStream();
    if (defaultStream != null) {
      currentStream = defaultStream;
    }
    streamSet = CameraStreamSet();

    setState(() {
      context.read<AppService>().cameras.forEach((cam) {
        streamSet.addStream(CameraStreamUrl(
            name: cam.cameraName,
            url: context.read<AppService>().genStreamUrl(cam.cameraId)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tertiaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const HeaderText("Hello Kweku"),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.video_call_rounded),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddCameraScreen()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SubHeaderText("Welcome to Home \nCamera",
                    margin: EdgeInsets.only(bottom: 14)),
                // SizedBox(height: 30),
                CameraFeedWidget(streamUrl: currentStream),
                const SubHeaderText("Other Cameras"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent:
                            MediaQuery.of(context).size.height * 0.13,
                        crossAxisCount: 2),
                    itemCount: streamSet.streams.length,
                    itemBuilder: (context, index) => CameraCard(
                      stream: streamSet.streams.elementAt(index),
                      onTap: () {
                        setState(() {
                          currentStream = streamSet.streams[index];
                        });
                      },
                    ),
                  ),
                ),

                // const SubHeaderText("Recent Events"),
                // SizedBox(
                //     height: MediaQuery.of(context).size.height * 0.35,
                //     child: ListView.builder(
                //         itemCount: 4,
                //         itemBuilder: (context, index) => EventListTile()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
