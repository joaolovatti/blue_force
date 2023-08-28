import 'dart:io';
import 'development_logger.dart';

///Representa um host existente numa LAN.
class LANHost {
  final String ip;
  final DevelopmentLogger _logger = DevelopmentLogger();

  ///:param [ip]: IP do host na LAN.
  LANHost({required this.ip});

  ///Avalia se uma porta do host está aberta ou não.
  ///
  ///:param [port]: Número da porta que será avaliada.
  ///
  ///:returns: Future<bool>.
  Future<bool> isPortOpen(int port) async {
    try {
      _logger.info("Port $port of host $ip is beign assessed.");

      final socket =
          await Socket.connect(ip, port, timeout: const Duration(seconds: 1));

      socket.destroy();

      _logger.info("Port $port is opened.");
      return true;
    } catch (e) {
      _logger.info("Port $port is closed.");
      return false;
    }
  }
}
