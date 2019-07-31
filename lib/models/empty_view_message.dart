import 'package:flutter/widgets.dart';

/// A model class depicting the config for [EmptyView].
class EmptyViewMessage {
  EmptyViewMessage({
    @required this.description,
    this.illustrationUrl,
    this.descriptionStyle,
    this.actionTitle,
    this.onAction,
  });

  /// A String variable depicting the message to be shown
  /// on [EmptyView].
  String description;

  /// A String variable for setting the title for the action
  /// widget.
  String actionTitle;

  /// A String variable depicting the url to be used for the
  /// illustration widget of [EmptyView].
  String illustrationUrl;

  /// A TextStyle variable specifying the styling for the
  /// [description].
  TextStyle descriptionStyle;

  /// A function which infers to what should be done when the
  /// [action] is clicked/tapped.
  Function onAction;
}
