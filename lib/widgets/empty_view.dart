import 'package:cached_network_image/cached_network_image.dart';
import 'package:flrx/models/empty_view_message.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView.basic(
      {Key key,
      @required this.illustration,
      @required this.description,
      @required this.action,
      this.reversed = false})
      : emptyViewMessage = null,
        super(key: key);

  const EmptyView.fromEmptyViewMessage(
      {Key key, @required this.emptyViewMessage, this.reversed = false})
      : illustration = null,
        description = null,
        action = null,
        super(key: key);

  final EmptyViewMessage emptyViewMessage;
  final Widget illustration;
  final Widget description;
  final Widget action;
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    Widget illustrationWidget =
        illustration ?? _buildIllustration(emptyViewMessage?.illustrationUrl);
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

  Widget _buildIllustration(String illustrationUrl) {
    if (illustrationUrl == null) {
      return null;
    }
    return Image(image: CachedNetworkImageProvider(illustrationUrl));
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
