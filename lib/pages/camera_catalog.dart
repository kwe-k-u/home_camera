import 'package:flutter/material.dart';
import 'package:home_camera/models/camera_stream_set.dart';
import 'package:home_camera/models/camera_stream_url.dart';
import 'package:home_camera/pages/add_camera_screen.dart';
import 'package:home_camera/services/app_service.dart';
import 'package:home_camera/widgets/camera_card.dart';
import 'package:home_camera/widgets/camera_feed_widget.dart';
import 'package:home_camera/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

class CameraCatalog extends StatefulWidget {
  const CameraCatalog({super.key});

  @override
  State<CameraCatalog> createState() => _CameraCatalogState();
}

class _CameraCatalogState extends State<CameraCatalog> {
  CameraStreamUrl currentStream = CameraStreamUrl();
  CameraStreamSet streamSet = CameraStreamSet();
  late AppService appService;

  @override
  void initState() {
    appService = context.read<AppService>();
    _setStreams();

    appService.addListener(() {
      _setStreams();
    });

    super.initState();
  }

  void _setStreams() {
    CameraStreamUrl? defaultStream = appService.getDefaultStream();
    if (defaultStream != null) {
      currentStream = defaultStream;
    }
    streamSet = CameraStreamSet();

    setState(() {
      for (var cam in appService.cameras) {
        streamSet.addStream(CameraStreamUrl(
            name: cam.cameraName, url: appService.genStreamUrl(cam.cameraId)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Camera Catalogue"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.video_call_rounded),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddCameraScreen()));
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0) +
              const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CameraFeedWidget(streamUrl: currentStream),
              const SubHeaderText("Other Cameras"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: GridView.builder(
                  itemCount: streamSet.streams.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent:
                          MediaQuery.of(context).size.height * 0.15),
                  itemBuilder: (context, index) => CameraCard(
                    stream: streamSet.streams[index],
                    onTap: () {
                      setState(() {
                        currentStream = streamSet.streams[index];
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
