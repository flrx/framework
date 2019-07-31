import 'package:flutter/widgets.dart';

class EmptyViewMessage {
  EmptyViewMessage({
    this.description,
    this.illustration,
    this.descriptionStyle,
    this.actionTitle,
    this.onRetry,
  });

  String description;
  String actionTitle;
  Widget illustration;
  TextStyle descriptionStyle;
  Function onRetry;
}
