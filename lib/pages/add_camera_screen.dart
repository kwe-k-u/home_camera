import 'package:flutter/material.dart';
import 'package:home_camera/models/camera_stream_url.dart';
import 'package:home_camera/services/app_service.dart';
import 'package:home_camera/widgets/camera_feed_widget.dart';
import 'package:home_camera/widgets/custom_rounded_button.dart';
import 'package:home_camera/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddCameraScreen extends StatefulWidget {
  const AddCameraScreen({super.key});

  @override
  State<AddCameraScreen> createState() => _AddCameraScreenState();
}

class _AddCameraScreenState extends State<AddCameraScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  CameraStreamUrl streamUrl = CameraStreamUrl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Add A Camera"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CameraFeedWidget(
              streamUrl: streamUrl,
              onTap: () {},
            ),
            CustomTextField(
              label: "Camera Name",
              controller: nameController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: CustomTextField(
                      label: "Camera Address", controller: addressController),
                ),
                TextButton(
                  child: const Text("Connect"),
                  onPressed: () {
                    // setState(() {
                    // streamUrl.value = "https://media.w3.org/2010/05/sintel/trailer.mp4";

                    // });

                    streamUrl.url = context
                        .read<AppService>()
                        .genStreamUrl(addressController.text);
                    // print(context
                    //     .read<AppService>()
                    //     .genStreamUrl(addressController.text));

                    // print(streamUrl);
                  },
                )
              ],
            ),
            CustomRoundedButton(
                label: "Add Camera",
                onTap: () {
                  if (addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Please provide the rtsp channel for the camera")));
                    return;
                  } else if (nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Please provide an alias name for the camera")));
                    return;
                  }
                  Map<String, dynamic> result = context
                      .read<AppService>()
                      .addCamera(
                          address: addressController.text,
                          cameraName: nameController.text);

                  if (result["status"]) {
                    Navigator.pop(context, true);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result["reason"])));
                  }
                })
          ],
        ),
      ),
    );
  }
}
