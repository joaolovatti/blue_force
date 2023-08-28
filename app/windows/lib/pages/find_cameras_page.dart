import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:windows/constants/app_text_styles.dart';
// import 'package:windows/design/asset_image_card.dart';
import 'package:windows/design/cancel_and_continue_buttons.dart';
import 'package:windows/design/unchanged_text.dart';
import 'package:windows/logic/port_scanner.dart';
import 'package:windows/pages/testing_page.dart';
import '../constants/app_colors.dart';
import '../design/cancel_dialog.dart';
import '../design/elevated_icon_button.dart';
import '../design/process_progress_indicator.dart';
import '../design/title_with_subtitle.dart';

/// Página focada para encontrar câmeras na internet do cliente
/// de forma automática.
class FindCamerasPage extends StatefulWidget {
  const FindCamerasPage({super.key});

  @override
  State<FindCamerasPage> createState() => _FindCamerasPageState();
}

class _FindCamerasPageState extends State<FindCamerasPage> {
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
      body: _FindCamerasPageBody(bottomBlankBoxHeight: _bottomBlankBoxHeight),
    );
  }
}

class _FindCamerasPageBody extends StatelessWidget {
  _FindCamerasPageBody({
    // ignore: unused_element
    super.key,
    required double bottomBlankBoxHeight,
  }) : _bottomBlankBoxHeight = bottomBlankBoxHeight;

  final double _bottomBlankBoxHeight;
  List<Widget> debbugResult = [];

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
              percentage: 1 / 3,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8, bottom: 8, top: 16),
              child: TitleWithSubTitle(
                title: "Encontrar Câmeras",
                subTitle:
                    "Iremos identificar todas as câmeras de segurança que estão conectadas à sua internet de forma automática.",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8),
              child: Row(
                children: [
                  UnchangedText("Tempo médio : ",
                      style: AppTextStyles.bodyText1),
                  UnchangedText(
                    "15 minutos.",
                    style: AppTextStyles.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  )
                ],
              ),
            ),
            // const AssetImageCard(path: "images/find_cameras_image.jpg"),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CancelAndContinueButtons(
                  onCancelPressed: () => showCancelDialog(
                      context, () => _onCancelarPressed(context)),
                  onContinuePressed: () => _findLocalCameras(context),
                  continueLabel: "Encontrar",
                )),
            SizedBox(
              height: _bottomBlankBoxHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  UnchangedText(
                    "1/3",
                    style: AppTextStyles.configurationStep,
                  ),
                ],
              ),
            )
          ]),
    );
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
