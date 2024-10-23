import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String text;
  const HeaderText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineLarge);
  }
}

class SubHeaderText extends StatelessWidget {
  final String text;
  final EdgeInsets? margin;
  const SubHeaderText(this.text, {this.margin,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ??const EdgeInsets.only(top: 12),
        child: Text(text, style: Theme.of(context).textTheme.headlineSmall));
  }
}
