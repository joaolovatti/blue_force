import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:windows/constants/app_text_styles.dart';
// import 'package:windows/design/asset_image_card.dart';
import 'package:windows/design/cancel_and_continue_buttons.dart';
import 'package:windows/design/network_image_card.dart';
import 'package:windows/design/unchanged_text.dart';
import 'package:windows/logic/port_scanner.dart';
import 'package:windows/pages/testing_page.dart';
import '../constants/app_colors.dart';
import '../design/asset_image_card.dart';
import '../design/cancel_dialog.dart';
import '../design/elevated_icon_button.dart';
import '../design/process_progress_indicator.dart';
import '../design/title_with_subtitle.dart';
import '../logic/lan_security_camera.dart';

/// Página focada em executar um conexão automática da câmeras
/// na internet do cliente de forma automática.
class AutomaticCamerasConnectionPage extends StatefulWidget {
  final List<LANSecurityCamera> identifiedCameras;

  const AutomaticCamerasConnectionPage(
      {super.key, required this.identifiedCameras});

  @override
  State<AutomaticCamerasConnectionPage> createState() =>
      _AutomaticCamerasConnectionPageState();
}

class _AutomaticCamerasConnectionPageState
    extends State<AutomaticCamerasConnectionPage> {
  double _bottomBlankBoxHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _bottomBlankBoxHeight = MediaQuery.of(context).size.height / 11;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        toolbarHeight: kToolbarHeight + MediaQuery.of(context).padding.top,
        actions: [
          ElevatedIconButton(
              icon: Icons.info_rounded, label: "Ajuda", onPressed: () {}),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: _AutomaticCamerasConnectionPageBody(
          bottomBlankBoxHeight: _bottomBlankBoxHeight,
          identifiedCameras: widget.identifiedCameras),
    );
  }
}

class _AutomaticCamerasConnectionPageBody extends StatelessWidget {
  final List<LANSecurityCamera> identifiedCameras;

  const _AutomaticCamerasConnectionPageBody({
    // ignore: unused_element
    super.key,
    required this.identifiedCameras,
    required double bottomBlankBoxHeight,
  }) : _bottomBlankBoxHeight = bottomBlankBoxHeight;

  final double _bottomBlankBoxHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProcessProgressIndicator(
              percentage: 2 / 3,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8, top: 16),
              child: TitleWithSubTitle(
                  title: "Conexão Automática",
                  subTitle: _getSubtitleText(identifiedCameras.length)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 16),
              child: Row(
                children: [
                  UnchangedText("Tempo médio : ",
                      style: AppTextStyles.bodyText1),
                  UnchangedText(
                    "1 minuto.",
                    style: AppTextStyles.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  )
                ],
              ),
            ),
            const NetworkImageCard(
                url:
                    "https://images.unsplash.com/photo-1597733336794-12d05021d510?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80"),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CancelAndContinueButtons(
                  onCancelPressed: () => showCancelDialog(
                      context, () => _onCancelarPressed(context)),
                  onContinuePressed: () {
                    _waitResponse();
                  },
                  continueLabel: "Conectar",
                )),
            // SizedBox(
            //   height: _bottomBlankBoxHeight,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  UnchangedText(
                    "2/3",
                    style: AppTextStyles.configurationStep,
                  ),
                ],
              ),
            )
          ]),
    );
  }

  void _waitResponse() async {
    print(await identifiedCameras.first.tryConnect());
  }

  /// Retorna o texto do subtítulo a partir da quantidade
  /// de câmeras de segurança conectadas na rede LAN.
  String _getSubtitleText(int camerasQuantity) {
    if (camerasQuantity > 1) {
      return "Foram identificadas $camerasQuantity câmeras na sua rede de internet. Agora, iremos tentar estabelecer uma conexão com elas de forma automática.";
    } else {
      return "Foi identificado $camerasQuantity câmera na sua rede de internet. Agora, iremos tentar estabelecer uma conexão com ela de forma automática.";
    }
  }

  /// Função invocada quando o usuário pressiona o botão
  /// de cancelar.
  void _onCancelarPressed(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _findLocalCameras(BuildContext context) async {
    ProgressDialog dialog = ProgressDialog(context: context);

    PortScanner port = PortScanner();

    await port.initialize();

    int potentialHostQuantity = port.getLANRangeIPs().length;
    int progressValue = 0;
    List<Widget> debbugResult = [];

    dialog.show(
        max: potentialHostQuantity,
        msg: "Encontrando potenciais câmeras na sua rede de internet ...");

    Stream<Map<String, dynamic>> cameraScan = port.scanPort(554);

    await for (var result in cameraScan) {
      debbugResult.add(ListTile(
        leading: const CircleAvatar(child: Icon(Icons.bug_report_rounded)),
        title: const Text('Port Scanning | 554'),
        subtitle: Text(result.toString()),
        isThreeLine: true,
      ));

      progressValue = progressValue + 1;

      dialog.update(value: progressValue);
    }

    dialog.close();

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TestingPage(
                  debugItens: debbugResult,
                )));
  }
}
