import 'package:flrx/models/empty_view_message.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView(
      {Key key,
      this.emptyViewMessage,
      this.illustration,
      this.description,
      this.action,
      this.reversed = false})
      : super(key: key);

  final EmptyViewMessage emptyViewMessage;
  final Widget illustration;
  final Widget description;
  final Widget action;
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    Widget illustrationWidget = illustration ?? emptyViewMessage?.illustration;
    Widget descriptionWidget =
        description ?? _buildDescription(emptyViewMessage?.description);
    Widget actionWidget = action ??
        _buildAction(emptyViewMessage?.actionTitle, emptyViewMessage?.onRetry);

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

  Widget _buildDescription(String description) {
    if (description == null) {
      return null;
    }
    return Text(description);
  }

  Widget _buildAction(String actionTitle, Function onAction) {
    if (actionTitle == null) {
      return null;
    }
    return RaisedButton(
      elevation: 1,
      child: Text(actionTitle ?? 'Retry'),
      onPressed: () {},
    );
  }
}
