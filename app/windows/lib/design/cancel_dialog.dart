import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../constants/app_colors.dart';

/// Ilustra um dialog que reafirma se o usuário deseja cancelar a operação
/// ou não.
///
/// [context] : Contexto da widget que invocou o dialog.
/// [onCancelPress] : Função de callback executada quando o usuário pressiona
/// o botão de cancelamento..
void showCancelDialog(BuildContext context, VoidCallback onCancelPress) {
  PanaraConfirmDialog.show(context,
      message: "Você possui certeza de que deseja cancelar este processo?",
      confirmButtonText: "Sim",
      title: "Cancelar Operação",
      cancelButtonText: "Não", onTapConfirm: () {
    Navigator.pop(context);
    onCancelPress();
  }, onTapCancel: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.custom, color: AppColors.softRed);
}
