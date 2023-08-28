import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'filled_icon_button.dart';

/// CancelAndContinueButtons UI Component.
///
/// [cancelLabel] : Label presente no botão de cancelar.
/// [continueLabel] : Label presente no botão de continuar.
/// [onCancelPressed] : CallBack function executada quando o
/// usuário pressionar o botão de cancelar.
/// [onContinuePressed] : CallBack function executada quando o
/// usuário pressionar o botão de continuar.
class CancelAndContinueButtons extends StatelessWidget {
  final String cancelLabel;
  final String continueLabel;
  final VoidCallback onCancelPressed;
  final VoidCallback onContinuePressed;

  const CancelAndContinueButtons(
      {super.key,
      required this.onCancelPressed,
      required this.onContinuePressed,
      this.cancelLabel = "Cancelar",
      this.continueLabel = "Continuar"});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FilledIconButton(
            icon: Icons.cancel_rounded,
            label: cancelLabel,
            color: AppColors.softRed,
            onPressed: onCancelPressed),
        FilledIconButton(
            icon: Icons.play_arrow_rounded,
            label: continueLabel,
            onPressed: onContinuePressed)
      ],
    );
  }
}
