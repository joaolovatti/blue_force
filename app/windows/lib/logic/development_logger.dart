import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

///Permite criar logs que irão funcionar
///apenas no ambiente de desenvolvimento.
class DevelopmentLogger {
  late Logger _logger;

  DevelopmentLogger() {
    if (kReleaseMode) {
      _logger = Logger(filter: _ProductionFilter());
    } else {
      _logger = Logger();
    }
  }

  ///Mensagem informativa.
  ///
  ///:param [message]: Mensagem do LOG.
  ///
  ///:return: None.
  void info(String message) {
    _logger.i(message);
  }

  ///Mensagem de alerta.
  ///
  ///:param [message]: Mensagem do LOG.
  ///
  ///:return: None.
  void warning(String message) {
    _logger.w(message);
  }

  ///Mensagem de erro.
  ///
  ///:param [message]: Mensagem do LOG.
  ///
  ///:return: None.
  void error(String message) {
    _logger.e(message);
  }
}

class _ProductionFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return false;
  }
}
