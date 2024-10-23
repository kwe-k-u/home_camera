import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:home_camera/models/camera_stream_url.dart';
import 'package:home_camera/pages/playback_screen.dart';
import 'package:home_camera/utils/constants.dart';

class CameraFeedWidget extends StatefulWidget {
  final Function()? onTap;
  final Function(String)? changeStream;
  final CameraStreamUrl? streamUrl;
  const CameraFeedWidget(
      {this.changeStream, this.streamUrl, this.onTap, super.key});

  @override
  State<CameraFeedWidget> createState() => _CameraFeedWidgetState();
}

class _CameraFeedWidgetState extends State<CameraFeedWidget> {
  late VlcPlayerController vlcController;

  @override
  void initState() {
    _initialiseStream("https://media.w3.org/2010/05/sintel/trailer.mp4");

    widget.streamUrl?.addListener(() {
      if (widget.streamUrl?.url != null) {
        _initialiseStream(widget.streamUrl!.url!);
      }
    });
    super.initState();
  }

  void _initialiseStream(String url) {
    setState(() {});
    vlcController = VlcPlayerController.network(
      url,
      autoPlay: true,
      options: VlcPlayerOptions(
        http: VlcHttpOptions([VlcAdvancedOptions.clockSynchronization(1)]),
        video: VlcVideoOptions([VlcVideoOptions.dropLateFrames(true)]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // vlcController.
    return InkWell(
      onTap: widget.onTap ??
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PlaybackScreen()));
          },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: accentColor, borderRadius: BorderRadius.circular(12)),
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            child: Stack(
              children: [
                widget.streamUrl?.url != null
                    ? VlcPlayer(
                        controller: vlcController,
                        aspectRatio: 11 / 9,
                        placeholder:
                            const Center(child: CircularProgressIndicator()),
                      )
                    : const Center(child: Text("No stream received")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.streamUrl?.url ?? "<unassigned to a stream>"),
                    IconButton(
                      icon: const Icon(Icons.camera),
                      onPressed: () {},
                    )
                  ],
                )
              ],
            )
            // child: SizedBox(

            // ),
            ),
      ),
    );
  }
}
