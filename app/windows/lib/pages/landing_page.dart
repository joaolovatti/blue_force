import 'package:flutter/material.dart';
import 'package:windows/constants/app_colors.dart';
import 'package:windows/constants/app_text_styles.dart';
import 'package:windows/design/elevated_icon_button.dart';
import 'package:windows/design/asset_image_card.dart';
import 'package:windows/design/selection_card.dart';
import 'package:windows/design/title_with_subtitle.dart';
import 'package:windows/pages/find_cameras_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: _appBar(context),
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: const _LandingBottomNavigationBar(),
      body: const _LandingBody(),
    );
  }

  /// App bar visível no Scaffold.
  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      toolbarHeight: kToolbarHeight + MediaQuery.of(context).padding.top,
      actions: [
        ElevatedIconButton(
          icon: Icons.account_circle_rounded,
          label: "Login",
          onPressed: () {},
        ),
        const SizedBox(
          width: 8,
        )
      ],
    );
  }
}

class _LandingBody extends StatelessWidget {
  const _LandingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8),
            child: TitleWithSubTitle(
              title: "Primeiros Passos",
              subTitle:
                  "Tecnologia de última geração para salvar vidas e negócios.",
            ),
          ),
          const AssetImageCard(path: "images/landing_page_image.jpg"),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: double.maxFinite,
              height: 230,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: SelectionCard(
                        title: "Câmeras",
                        body:
                            "Consulte a nossa loja caso desejar instalar novas câmeras de segurança.",
                        buttonLabel: "Loja",
                        buttonIcon: Icons.shopping_cart_rounded,
                        onPressed: () {}),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: SelectionCard(
                        title: "Configuração",
                        body:
                            "Vamos identificar todas as câmeras de segurança conectadas à sua internet.",
                        buttonLabel: 'Configurar',
                        buttonIcon: Icons.play_arrow_rounded,
                        onPressed: () => _onConfiguracaoPressed(context)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Ação que será executada quando o botão de "Configuração"
  /// for selecionado pelo usuário.
  void _onConfiguracaoPressed(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FindCamerasPage()));
  }
}

class _LandingBottomNavigationBar extends StatelessWidget {
  const _LandingBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: AppColors.iconColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedLabelStyle: AppTextStyles.bottomNavigationLabel,
      selectedLabelStyle: AppTextStyles.bottomNavigationLabel,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              size: 20,
            ),
            label: 'Início'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 20,
            ),
            label: 'Configurações'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.security_rounded,
              size: 20,
            ),
            label: 'Incidentes'),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.credit_card_rounded,
            size: 20,
          ),
          label: 'Planos',
        )
      ],
    );
  }
}
