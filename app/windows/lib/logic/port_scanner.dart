import './lan_host.dart';
import 'package:network_info_plus/network_info_plus.dart';
import './development_logger.dart';

///Obtém meta dados de uma LAN e permite executar port scanning
///a fim de descobrir hosts disponíveis.
///
///Sempre execute o método "initialize" primeiro a fim de obter
///os meta dados da LAN.
class PortScanner {
  late Map<String, dynamic> _networkMetaData = {};
  late bool _isInitialized = false;

  final DevelopmentLogger _logger = DevelopmentLogger();

  PortScanner();

  ///Inicializa o PortScanner com os meta dados necessários.
  ///
  ///:param: None.
  ///
  ///:return: Sucesso (True).
  Future<bool> initialize() async {
    try {
      final info = NetworkInfo();

      _networkMetaData = {
        "localIP": await info.getWifiIP(),
        "wifiName": await info.getWifiName(),
        "wifiSubMask": await info.getWifiSubmask(),
        "wifiBroadcast": await info.getWifiBroadcast(),
        "wifiGatewayIP": await info.getWifiGatewayIP(),
      };

      _isInitialized = true;

      _logger.info("Network Meta Data : ${_networkMetaData.toString()}");

      return true;
    } catch (e) {
      _logger.error(e.toString());
      return false;
    }
  }

  ///Executa um scanning de uma port específica na subnet do dispostivo.
  ///
  ///:param [port]: Porta que irá avaliar hosts disponíveis.
  ///
  ///:return: Lista de hosts disponíveis.
  Stream<Map<String, dynamic>> scanPort(int port) async* {
    // ignore: await_only_futures
    await _checkInitialization;

    List<String> potentialHost = getLANRangeIPs();

    _logger.info('''
        Port : $port
        Range : [${potentialHost.first.toString()}, ${potentialHost.last.toString()}]''');

    for (String host in potentialHost) {
      LANHost lanHost = LANHost(ip: host);

      bool isOpened = await lanHost.isPortOpen(port);

      Map<String, dynamic> result = {
        "host_ip": lanHost.ip,
        "port": port.toString(),
        "result": isOpened
      };

      yield result;
    }
  }

  ///Obtém os potenciais IPs que os hosts da LAN podem possuir.
  ///
  ///:param: None.
  ///
  ///:returns: Lista de todos os potenciais IPs.
  List<String> getLANRangeIPs() {
    String ip = _networkMetaData["localIP"].toString();
    int cidr = getCIDR();

    List<String> octets = ip.split('.');
    int hostPart = 32 - cidr;
    int ipNumber =
        octets.fold(0, (sum, octet) => (sum << 8) + int.parse(octet));

    int networkAddress = ipNumber & (-1 << hostPart);
    int broadcastAddress = networkAddress | ((1 << hostPart) - 1);

    List<String> ipList = [];

    for (int i = networkAddress; i <= broadcastAddress; i++) {
      ipList.add(_intToIp(i));
    }

    return ipList;
  }

  ///A partir da submask contabiliza a quantidade de 1s na sua representação
  ///binária a fim de detectar o CIDR da sub rede.
  ///
  ///:param: None.
  ///
  ///:returns: CIDR.
  int getCIDR() {
    List<String> octets = _networkMetaData["wifiSubMask"].toString().split('.');

    return octets.fold(
        0, (sum, octect) => sum + _countOnesFromBinaries(octect));
  }

  ///A partir de um octeto (255) executa uma transformação para a sua
  ///representação binária e contabiliza a quantidade de 1s.
  ///
  ///:param [octet]: Octeto que será analisado.
  ///
  ///:return: Quantidade de 1s existentes no octeto.
  int _countOnesFromBinaries(String octet) {
    int number = int.parse(octet);

    return number.toRadixString(2).split('').where((bit) => bit == '1').length;
  }

  ///Transforma um valor inteiro para a representação em octetos
  ///analóga à submasks.
  ///
  ///:param [val]: Valor inteiro à ser convertido.
  ///
  ///:return: Representação em octetos.
  String _intToIp(int val) {
    List<String> octets = [];
    for (int i = 3; i >= 0; i--) {
      octets.add(((val >> (i * 8)) & 0xFF).toString());
    }
    return octets.join('.');
  }

  ///Avalia se a classe já foi inicializada. Caso contrário,
  ///força a sua inicialização.
  ///
  ///:param: None.
  ///
  ///:return: None.
  Future<void> _checkInitialization() async {
    if (!_isInitialized) {
      await initialize();
    }
  }

  dynamic get wifiIP => _networkMetaData["localIP"];

  dynamic get wifiName => _networkMetaData["wifiName"];

  dynamic get subMask => _networkMetaData["wifiSubMask"];

  dynamic get broadcast => _networkMetaData["wifiBroadcast"];

  dynamic get gatewayIP => _networkMetaData["wifiGatewayIP"];
}
