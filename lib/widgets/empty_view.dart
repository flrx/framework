import 'package:flrx/models/empty_view_message.dart';
import 'package:flutter/material.dart';

/// A utility widget that renders the content for an empty view
///
/// The [EmptyView] provides a way to easily define the content for
/// different states like empty list, errors and no data.
///
class EmptyView extends StatelessWidget {
  /// The default constructor for [EmptyView].
  ///
  /// It takes [description], [illustration] and [action] widgets
  /// and a [reversed] `boolean` variable. This allows full
  /// flexibility and customisability for building the widget.
  const EmptyView({
    required this.description,
    this.illustration,
    this.action,
    this.reversed = false,
    Key? key,
  }) : super(key: key);

  /// The named [EmptyView] constructor taking [emptyViewMessage]
  /// and [reversed] as arguments.
  factory EmptyView.fromEmptyViewMessage({
    required EmptyViewMessage emptyViewMessage,
    bool reversed = false,
    Key? key,
  }) {
    return EmptyView(
      illustration: _buildIllustration(emptyViewMessage),
      description: Text(emptyViewMessage.description),
      action: _buildAction(emptyViewMessage),
      reversed: reversed,
      key: key,
    );
  }

  /// A widget depicting an image to show when the view is rendered.
  ///
  /// If `null`, it will not be rendered on the scrren.
  ///
  /// Used with default constructor.
  final Widget? illustration;

  /// A widget depicting the reason or description for the [EmptyView]
  /// to be shown.
  ///
  /// It is required.
  ///
  /// Used with default constructor.
  final Widget description;

  /// A widget defining the action to be taken when the [EmptyView] is
  /// shown.
  ///
  /// Usually of type button.
  ///
  /// If `null`, it will not be rendered on the scrren.
  ///
  /// Used with default constructor.
  final Widget? action;

  /// A `bool` variable depicting the order of rendering the widgets
  /// passed to [EmptyView].
  ///
  /// If `true`, the [illustration] widget will be rendered before
  /// [description] widget and vice-versa.
  ///
  /// Doesn't have any affect on order of rendering [action] widget.
  ///
  /// Used with both default and named constructor.
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ...getReversibleWidgets(),
      action ?? Container(),
    ]);
  }

  List<Widget> getReversibleWidgets() {
    var illustrationWidget = illustration ?? Container();
    var list = [illustrationWidget, description];

    if (reversed) {
      return list.reversed.toList();
    }

    return list;
  }

  static Widget? _buildIllustration(EmptyViewMessage emptyViewMessage) {
    var path = emptyViewMessage.illustrationPath;
    if (path == null) {
      return null;
    }
    var size = emptyViewMessage.illustrationSize;
    return Image(
      height: size!.height,
      width: size.width,
      image: AssetImage(path),
    );
  }

  static Widget? _buildAction(EmptyViewMessage emptyViewMessage) {
    var actionTitle = emptyViewMessage.actionTitle;
    var onAction = emptyViewMessage.onAction;

    if (onAction == null) {
      return null;
    }

    return ElevatedButton(
      onPressed: onAction,
      child: Text(actionTitle ?? 'Retry'),
    );
  }
}
