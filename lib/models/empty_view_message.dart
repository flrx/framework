import 'package:flutter/widgets.dart';

class EmptyViewMessage {
  EmptyViewMessage({
    @required this.description,
    this.illustrationUrl,
    this.descriptionStyle,
    this.actionTitle,
    this.onAction,
  });

  String description;
  String actionTitle;
  String illustrationUrl;
  TextStyle descriptionStyle;
  Function onAction;
}
