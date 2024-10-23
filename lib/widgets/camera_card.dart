import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:home_camera/models/camera_stream_url.dart';
import 'package:home_camera/pages/camera_catalog.dart';

class CameraCard extends StatelessWidget {
  final Function()? onTap;
  final CameraStreamUrl stream;
  const CameraCard({super.key, this.onTap, required this.stream});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CameraCatalog()));
          },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            // padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.black12),

            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.4,
            child: Stack(
              children: [
                VlcPlayer(
                  controller: VlcPlayerController.network(
                    stream.url!,
                    autoPlay: true,
                    options: VlcPlayerOptions(
                      http: VlcHttpOptions(
                          [VlcAdvancedOptions.clockSynchronization(1)]),
                      video: VlcVideoOptions(
                          [VlcVideoOptions.dropLateFrames(true)]),
                    ),
                  ),
                  aspectRatio: 11 / 9,
                  placeholder: const Center(child: CircularProgressIndicator()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(stream.name!), const Icon(Icons.camera)],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
