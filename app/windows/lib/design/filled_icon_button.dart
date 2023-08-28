import 'package:flutter/material.dart';
import 'package:windows/constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'unchanged_text.dart';

/// FilledIconButton UI Component.
///
/// [icon]: IconData que será mostrado no componente.
/// [label]: Texto que será mostrado no botão.
/// [onPressed]: Função de callback que será executada
/// quando o usuário clicar no botão.
class FilledIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const FilledIconButton(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onPressed,
      this.color = AppColors.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(color)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UnchangedText(label, style: AppTextStyles.button),
            const SizedBox(
              width: 6,
            ),
            Icon(
              icon,
              size: 18,
            )
          ],
        ));
  }
}
