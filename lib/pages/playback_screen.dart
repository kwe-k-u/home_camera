import 'package:flutter/material.dart';
import 'package:home_camera/widgets/camera_feed_widget.dart';
import 'package:home_camera/widgets/playback_controls.dart';
import 'package:home_camera/widgets/text_widgets.dart';

class PlaybackScreen extends StatefulWidget {
  
  const PlaybackScreen({super.key});

  @override
  State<PlaybackScreen> createState() => _PlaybackScreenState();
}

class _PlaybackScreenState extends State<PlaybackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Video Playback"),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(12) +
              const EdgeInsets.symmetric(horizontal: 8),
          child: const Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CameraFeedWidget(),
              PlaybackControls(),
              PlaybackDateSelector()
            ],
          ),
        ));
  }
}

class PlaybackDateSelector extends StatefulWidget {
  const PlaybackDateSelector({super.key});

  @override
  State<PlaybackDateSelector> createState() => _PlaybackDateSelectorState();
}

class _PlaybackDateSelectorState extends State<PlaybackDateSelector> {
  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubHeaderText("PlayBack Date"),
                Icon(Icons.date_range),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InputField(
                  label: "Date",
                  value: "25 July",
                  subValue: "2024",
                  onTap: () {},
                ),
                _InputField(
                  label: "Time",
                  value: "7:50",
                  subValue: "AM",
                  onTap: () {},
                ),
              ],
            )
          ],
        ));
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String value;
  final String subValue;
  final Function() onTap;

  const _InputField(
      {super.key,
      required this.label,
      required this.value,
      required this.subValue,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.black,
        )),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 12),
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            SubHeaderText(value),
            SubHeaderText(subValue),
          ],
        ),
      ),
    );
  }
}
