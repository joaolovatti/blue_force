import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Retorna um indicador de progresso de um processo.
///
/// [percentage] : Percentual já avançado do processo.
/// Varia de 0 a 1.
class ProcessProgressIndicator extends StatelessWidget {
  final double percentage;

  const ProcessProgressIndicator({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: percentage,
      backgroundColor: AppColors.softBlue,
      color: AppColors.primaryColor,
    );
  }
}
