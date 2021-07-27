import 'package:flutter/widgets.dart';

/// A model class depicting the config for [EmptyView].
class EmptyViewMessage {
  EmptyViewMessage({
    required this.description,
    this.illustrationPath,
    this.descriptionStyle,
    this.actionTitle,
    this.onAction,
    this.illustrationSize,
  });

  /// A String variable depicting the message to be shown
  /// on [EmptyView].
  String description;

  /// A String variable for setting the title for the action
  /// widget.
  String? actionTitle;

  /// A String variable depicting the path to be used for the
  /// illustration widget of [EmptyView].
  String? illustrationPath;

  /// A Size variable defining the height and width to be used
  /// for the illustration widget of [EmptyView].
  Size? illustrationSize;

  /// A TextStyle variable specifying the styling for the
  /// [description].
  TextStyle? descriptionStyle;

  /// A function which infers to what should be done when the
  /// [action] is clicked/tapped.
  VoidCallback? onAction;
}
