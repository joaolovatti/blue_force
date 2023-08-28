import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// NetworkImageCard UI Component.
///
/// [url]: URL que contém a imagem.
class NetworkImageCard extends StatelessWidget {
  final String url;

  const NetworkImageCard({Key? key, required this.url}) : super(key: key);

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
          child: Image.network(
            url,
            fit: BoxFit.cover,
            width: double.maxFinite,
          ),
        ),
      ),
    );
  }
}
