import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';
import 'filled_icon_button.dart';
import 'unchanged_text.dart';

/// SelectionCard UI Component.
///
/// [title]: Título do Card.
/// [body]: Texto que servirá como o conteúdo
/// do Card.
/// [buttonLabel]: Label dentro do button.
/// [buttonIcon]: Icon que será displayed no button.
/// [onPressed]: Função executada quando o usuário
/// clickar no button.
class SelectionCard extends StatelessWidget {
  final String title;
  final String body;
  final String buttonLabel;
  final IconData buttonIcon;
  final VoidCallback onPressed;

  const SelectionCard(
      {Key? key,
      required this.title,
      required this.body,
      required this.buttonLabel,
      required this.buttonIcon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UnchangedText(
                title,
                style: AppTextStyles.subtitle2,
              ),
              const SizedBox(
                height: 16,
              ),
              UnchangedText(body, style: AppTextStyles.bodyText2),
              const SizedBox(
                height: 16,
              ),
              FilledIconButton(
                  icon: buttonIcon, label: buttonLabel, onPressed: onPressed),
            ]),
      ),
    );
  }
}
