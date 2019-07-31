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
  const EmptyView(
      {Key key,
      @required this.description,
      this.illustration,
      this.action,
      this.reversed = false})
      : emptyViewMessage = null,
        super(key: key);

  /// The named [EmptyView] constructor taking [emptyViewMessage]
  /// and [reversed] as arguments.
  const EmptyView.fromEmptyViewMessage(
      {Key key, @required this.emptyViewMessage, this.reversed = false})
      : illustration = null,
        description = null,
        action = null,
        super(key: key);

  /// A config for building the widget.
  ///
  /// This is passed to the [EmptyView.fromEmptyViewMessage] named
  /// constructor.
  final EmptyViewMessage emptyViewMessage;

  /// A widget depicting an image to show when the view is rendered.
  ///
  /// If `null`, it will not be rendered on the scrren.
  ///
  /// Used with default constructor.
  final Widget illustration;

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
  final Widget action;

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
    Widget illustrationWidget = illustration ??
        _buildIllustration(emptyViewMessage?.illustrationPath,
            emptyViewMessage?.illustrationSize);
    Widget descriptionWidget =
        description ?? _buildDescription(emptyViewMessage?.description);
    Widget actionWidget = action ??
        _buildAction(emptyViewMessage?.actionTitle, emptyViewMessage?.onAction);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (!reversed) illustrationWidget,
        descriptionWidget,
        if (reversed) illustrationWidget,
        actionWidget,
      ],
    );
  }

  Widget _buildIllustration(String illustrationPath, Size size) {
    if (illustrationPath == null) {
      return null;
    }
    return Image(
      height: size.height,
      width: size.width,
      image: AssetImage(illustrationPath),
    );
  }

  Widget _buildDescription(String description) {
    if (description == null) {
      return null;
    }
    return Text(description);
  }

  Widget _buildAction(String actionTitle, Function onAction) {
    if (actionTitle == null || onAction == null) {
      return null;
    }
    return RaisedButton(
      elevation: 1,
      child: Text(actionTitle ?? 'Retry'),
      onPressed: onAction,
    );
  }
}
