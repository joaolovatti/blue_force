import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// AssetImageCard UI Component.
///
/// [path]: Caminho da imagem que está armazenada
/// como asset do projeto.
class AssetImageCard extends StatelessWidget {
  final String path;

  const AssetImageCard({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: AppColors.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        elevation: 8,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image(
              key: key,
              image: AssetImage(path),
              fit: BoxFit.cover,
              width: double.maxFinite,
            )),
      ),
    );
  }
}
