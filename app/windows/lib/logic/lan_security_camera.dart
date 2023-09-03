import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Representa uma câmera de segurança conectada na LAN.
///
/// [ip] : IP da câmera na LAN.
/// [login] : Login para estaleber uma conexão com a câmera.
/// [password] : Senha para estaleber uma conexão com a câmera.
/// [urlPattern554] : URL para se conectar à porta 554.
/// [status] : Status da conexão da câmera de segurança.
class LANSecurityCamera {
  final String ip;
  late String? login;
  late String? password;
  late String? urlPattern554;
  late LANSecurityCameraStatus status;

  LANSecurityCamera(
      {required this.ip,
      required this.login,
      required this.password,
      required this.urlPattern554,
      this.status = LANSecurityCameraStatus.init});

  Future<bool> tryConnect() async {
    final String rtspUrl = 'rtsp://192.168.1.100:554/stream1';

    try {
      final WebSocketChannel channel = WebSocketChannel.connect(
        Uri.parse(rtspUrl),
      );

      // Obtém o fluxo de dados da câmera.
      final Stream stream = channel.stream;

      // Exibe os frames da câmera.
      stream.listen((frame) {
        print(frame);
      });
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  @override
  String toString() {
    return """LANSecurityCamera {
      ip : $ip,
      login : $login,
      password : $password,
      urlPattern554 : $urlPattern554,
      status : $status
    }""";
  }
}

/// Representa os status que uma câmera conectada na LAN
/// pode representar.
///
/// [init] : Não houve uma tentativa de conexão ainda.
/// [connectionDenied] : Houve tentativa de conexão, mas falhou.
/// [success] :  Houve tentativa de conexão com sucesso.
enum LANSecurityCameraStatus { init, connectionDenied, success }
