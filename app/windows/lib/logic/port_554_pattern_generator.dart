import 'security_camera_url_pattern_generator.dart';

/// Permite obter patterns para se conectar à portas
/// de câmeras de seguranças conectadas na sua LAN.
class Port554PatternGenerator implements SecurityCameraURLPatternGenerator {
  static const int _port = 554;

  /// Retorna padrões de URL para conectar à porta 554.
  ///
  /// [ip] : IP do host na LAN.
  /// [login] : Login atribuído à câmera.
  /// [password] : Senha atribuída ao login da câmera.
  @override
  List<String> generatePatterns(String ip, String? login, String? password) {
    var uri = Uri(
      scheme: 'rtsp',
      host: ip,
      port: _port,
      path: '/:$_port/',
      queryParameters: {
        'user': login,
        'password': password,
        'channel': '1',
        'stream': '0'
      },
    );

    return [uri.toString()];
  }
}
