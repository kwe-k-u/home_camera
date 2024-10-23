import 'package:flutter/material.dart';

class EventListTile extends StatelessWidget {
  const EventListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.black12,
        title: const Text("Event name"),
        subtitle: const Text("Event or the camera name"),
        trailing: const Text("9:00 AM"),
      ),
    );
  }
}
