import 'package:flutter/material.dart';

class PlaybackControls extends StatelessWidget {
  const PlaybackControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _PlaybackControlButton(
            label: "Back",
            icon: Icons.fast_rewind,
            onTap: () {},
          ),
          _PlaybackControlButton(
            label: "Stop",
            icon: Icons.stop,
            onTap: () {},
          ),
          _PlaybackControlButton(
            label: "Play",
            icon: Icons.play_arrow,
            onTap: () {},
          ),
          _PlaybackControlButton(
            label: "Forward",
            icon: Icons.fast_forward,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _PlaybackControlButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final IconData icon;

  const _PlaybackControlButton(
      {super.key,
      required this.label,
      required this.onTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [Icon(icon), Text(label)],
      ),
    );
  }
}
