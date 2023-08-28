import 'package:flutter/material.dart';
import 'package:windows/design/title_with_subtitle.dart';

import '../constants/app_colors.dart';
import '../design/elevated_icon_button.dart';
import '../design/process_progress_indicator.dart';

class TestingPage extends StatelessWidget {
  final List<Widget>? debugItens;

  const TestingPage({super.key, required this.debugItens});

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const ProcessProgressIndicator(
            percentage: 1,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 8, top: 8),
            child: TitleWithSubTitle(
                title: "Tela de Depuração",
                subTitle:
                    "Lista de itens que estão em depuração. Ou seja, resultados intermediários da aplicação."),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: debugItens ?? [Container()],
            ),
          )),
        ],
      ),
    );
  }
}
