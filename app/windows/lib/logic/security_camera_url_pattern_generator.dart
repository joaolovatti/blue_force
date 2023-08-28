/// Interface para geradores de padrões de URL de câmera de segurança.
abstract class SecurityCameraURLPatternGenerator {
  List<String> generatePatterns(String ip, String? login, String? password);
}
