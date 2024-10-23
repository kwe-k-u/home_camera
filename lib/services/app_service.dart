import 'package:flutter/material.dart';
import 'package:home_camera/models/camera.dart';
import 'package:home_camera/models/camera_stream_set.dart';
import 'package:home_camera/models/camera_stream_url.dart';
import 'package:network_discovery/network_discovery.dart';

class AppService extends ChangeNotifier {
  String? _ip;
  List<Camera> cameras = [];
  // CameraStreamSet cameras = CameraStreamSet();
  int? defaultCamera;
  String? _username;
  String? _password;
  int _port = 554;

  Future<List<String>?> checkAvailableIPs() async {
    // String deviceIp = await getDeviceIP();
    // String host = "${deviceIp.split(".").sublist(0, 3).join(".")}.1";
    // print("hostip $host");
    final stream = NetworkDiscovery.discover("255.255.255.0", _port);

    stream.listen((NetworkAddress addr) {
      // print(addr.ip);
      // print('Found device: ${addr.ip}:$_port');
    });
  }

  //Get the IP Address of the client device
  Future<String> getDeviceIP() async {
    return await NetworkDiscovery.discoverDeviceIpAddress();
  }

  // Checks the network if the device at a given ip has a given port open
  Future<bool> checkDeviceAtPort(String deviceIP, int port) async {
    NetworkAddress result =
        await NetworkDiscovery.discoverFromAddress(deviceIP, port);
    return result.openPorts.contains(port);
  }

  CameraStreamSet getStreamSet() {
    // List<String> streams = [];
    CameraStreamSet streams = CameraStreamSet();
    for (Camera camera in cameras) {
      // streams.add(genStreamUrl(camera.cameraId));
      streams.addStream(CameraStreamUrl(
          name: camera.cameraName, url: genStreamUrl(camera.cameraId)));
    }
    return streams;
  }

  String genStreamUrl(String cameraId) =>
      "rtsp://$_username:$_password@$_ip:$_port/streaming/channels/$cameraId";

  void updateCamera(Camera newCamera, index) {
    cameras[index] = newCamera;
    notifyListeners();
  }

  void removeCamera(Camera camera) {
    cameras.remove(camera);
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(
      {required String ipaddress,
      required String username,
      required String password}) async {
    Map<String, dynamic> result = {
      "status": false,
      "reason": "We couldn't ping the device IP"
    };
    bool isDeviceAvailable = true;

    // Check if the ip address is on the network and accepts at port 554
    if (ipaddress.isEmpty || username.isEmpty || password.isEmpty) {
    } else {
      isDeviceAvailable = await checkDeviceAtPort(ipaddress, _port);
    }
    if (isDeviceAvailable) {
      // Check if the user name and password work for login into the device

      //save the values to the service
      _ip = ipaddress;
      _username = username;
      _password = password;

      result["status"] = true;
      result["reason"] = "successfully logged in";
    }

    return result;
  }

  Map<String, dynamic> addCamera(
      {required String address, required String cameraName}) {
    Map<String, dynamic> result = {
      "status": false,
      "reason": "Camera already exists"
    };
    Camera newCam = Camera(cameraId: address, cameraName: cameraName);

    if (!cameras.contains(newCam)) {
      cameras.add(newCam);
      result["status"] = true;
      result["reason"] = "Successfully added a camera";
    }

    notifyListeners();
    return result;
  }

  // Returns the stream url for the default camera or the first available camera
  // if there are none, it returns null
  CameraStreamUrl? getDefaultStream() {
    if (cameras.isNotEmpty) {
      // return getStreamUrls()[defaultCamera ?? 0];
      Camera defaultCam = cameras.first;
      return CameraStreamUrl(
          name: defaultCam.cameraName, url: genStreamUrl(defaultCam.cameraId));
    }
    return null;
  }

  // Future<bool> pingNetworkDevice() async {
  //   final NetworkAddress device = await NetworkDiscovery.discoverFromAddress('192.168.0.1', port);

  //   print(device.toString());
  // }

  // Stream<void> searchNetworkDevices() async* {
  //   final stream = NetworkDiscovery.discoverAllPingableDevices('192.168.0');
  //   int availableHost = 0;

  //   stream.listen((HostActive host) {
  //     if (host.isActive) {
  //       print('Found device: ${host.ip}, isActive: ${host.isActive}');
  //     }
  //   }).onDone(() => print('Finish. Available $availableHost host device(s)'));
  // }
}
