import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

///Padroniza todos os estilos de texto da aplicação.
class AppTextStyles {
  ///Estilo de base para toda a aplicação.
  ///Toda a mudança nesta estilo será herdada para
  ///os estilos posteriores.
  static final TextStyle baseStyle = GoogleFonts.lato();

  ///Usado para estilos de cabeçalho maiores, como títulos.
  static final TextStyle headline1 = _mergeWithBase(
    style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
  );

  ///Usado para estilos de cabeçalho um pouco menores.
  static final TextStyle headline2 = _mergeWithBase(
      style: const TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
  ));

  ///Estilo de cabeçalho de tamanho médio.
  static final TextStyle headline3 = _mergeWithBase(
      style: const TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
  ));

  ///Outro estilo de cabeçalho, um pouco menor que o headline3.
  static final TextStyle headline4 = _mergeWithBase(
      style: const TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.bold,
  ));

  ///Estilo de cabeçalho menor.
  static final TextStyle headline5 = _mergeWithBase(
      style: const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  ));

  ///Estilo de cabeçalho menor, geralmente usado para subtítulos.
  static final TextStyle headline6 = _mergeWithBase(
      style: const TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  ));

  ///Usado para estilos de subtítulo, maior que o subtitle2.
  static final TextStyle subtitle1 = _mergeWithBase(
      style: const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  ));

  ///Usado para estilos de subtítulo menores.
  static final TextStyle subtitle2 = _mergeWithBase(
      style: const TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  ));

  ///Estilo de texto principal para partes mais densas do aplicativo, como parágrafos.
  static final TextStyle bodyText1 = _mergeWithBase(
      style: const TextStyle(
    fontSize: 16.0,
  ));

  ///Estilo de texto secundário, geralmente menor que o bodyText1.
  static final TextStyle bodyText2 = _mergeWithBase(
      style: const TextStyle(
    fontSize: 14.0,
  ));

  ///Estilo de específico para representar os labels de etapas de configuração.
  static final TextStyle configurationStep = _mergeWithBase(
      style: const TextStyle(
          fontSize: 14.0,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold));

  ///Usado para legendas menores e explicativas.
  static final TextStyle caption = _mergeWithBase(
      style: const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  ));

  ///Estilo de texto específico para botões.
  static final TextStyle button = _mergeWithBase(
      style: const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  ));

  ///Estilo de texto específico para labels da
  ///BottomNavigationBar.
  static final TextStyle bottomNavigationLabel = _mergeWithBase(
      style: const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  ));

  ///Usado para texto em caixa alta, geralmente em tamanho pequeno.
  static final TextStyle overline = _mergeWithBase(
      style: const TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ));

  ///Executa o merge do estilo de base com um mais incremental.
  static TextStyle _mergeWithBase({required TextStyle style}) {
    return baseStyle.merge(style);
  }
}
