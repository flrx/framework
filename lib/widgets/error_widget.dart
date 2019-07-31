import 'package:flrx/models/error_message.dart';
import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget(
      {Key key,
      this.errorMessage,
      this.errorIllustration,
      this.errorDescription,
      this.action,
      this.reversed = false})
      : super(key: key);

  final ErrorMessage errorMessage;
  final Widget errorIllustration;
  final Widget errorDescription;
  final Widget action;
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    Widget illustration = errorIllustration ?? errorMessage?.illustration;
    Widget description =
        errorDescription ?? _buildDescription(errorMessage?.description);
    Widget actionWidget = action ??
        _buildRetryAction(errorMessage?.actionTitle, errorMessage?.onRetry);

    return Column(
      children: <Widget>[
        if (!reversed) illustration,
        description,
        if (reversed) illustration,
        actionWidget
      ],
    );
  }

  Widget _buildDescription(String description) {
    if (description == null) {
      return null;
    }
    return Text(description);
  }

  Widget _buildRetryAction(String actionTitle, Function onRetry) {
    if (actionTitle == null) {
      return null;
    }
    return RaisedButton(
      elevation: 1,
      child: Text('Retry'),
      onPressed: () {},
    );
  }
}
