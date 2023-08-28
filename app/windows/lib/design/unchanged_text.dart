import 'package:flutter/material.dart';

/// UnchangedText UI Component.
///
/// Wrapper da [Text] widget a fim de criar visualizações
/// que não são alteradas por configurações dos dispositivos
/// que irão executar a aplicação.
class UnchangedText extends StatelessWidget {
  final String label;
  final TextStyle? style;

  const UnchangedText(this.label, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: style,
      textScaleFactor: 1,
    );
  }
}
