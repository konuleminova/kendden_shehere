import 'package:flutter/material.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kendden_shehere/constants/Constants.dart';

class GrocerySubtitle extends StatelessWidget {
  const GrocerySubtitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    String markdown = html2md.convert(text);
    return new MarkdownBody(
      data: markdown,
    );
  }
}

class GroceryTitle extends StatelessWidget {
  const GroceryTitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 3,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0,));
  }
}
