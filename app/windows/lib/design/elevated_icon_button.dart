import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'unchanged_text.dart';

/// ElevatedIconButton UI Component.
///
/// [icon]: IconData que será mostrado no componente.
/// [label]: Texto que será mostrado no botão.
/// [onPressed]: Função de callback que será executada
/// quando o usuário clicar no botão.
/// [color]: Cor do ícone e do texto.
class ElevatedIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const ElevatedIconButton(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onPressed,
      this.color = AppColors.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            UnchangedText(
              label,
              style: AppTextStyles.button.copyWith(color: color),
            ),
            const SizedBox(
              width: 4,
            ),
            Icon(
              icon,
              size: 20,
              color: color,
            )
          ],
        ));
  }
}
