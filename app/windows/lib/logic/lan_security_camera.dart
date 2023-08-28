// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

class LANSecurityCamera {
  final String ip;
  late String login;
  late String password;
  late String urlPattern;
  late LANSecurityCameraStatus status;

  LANSecurityCamera(
      {required this.ip,
      required this.login,
      required this.password,
      required this.urlPattern,
      this.status = LANSecurityCameraStatus.init});

  // Future<bool> tryConnect() async {
  //   final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
  // }
}

enum LANSecurityCameraStatus { init, connectionDenied, success }
