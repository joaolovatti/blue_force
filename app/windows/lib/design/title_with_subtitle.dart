import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';
import 'unchanged_text.dart';

/// TitleWithSubtitle UI Component.
///
/// [title]: Texto que irá ser displayed como
/// título.
///
/// [subTitle]: Texto que irá ser displayed como
/// sub-título.
class TitleWithSubTitle extends StatelessWidget {
  final String title;
  final String subTitle;

  const TitleWithSubTitle(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UnchangedText(title, style: AppTextStyles.headline4),
        const SizedBox(
          height: 8,
        ),
        UnchangedText(subTitle, style: AppTextStyles.bodyText1)
      ],
    );
  }
}
