import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget(
      {Key key,
      @required this.errorIllustration,
      @required this.errorDescription,
      this.action,
      this.reversed = false})
      : super(key: key);

  final Widget errorIllustration;
  final Widget errorDescription;
  final Widget action;
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    if (reversed) return _buildReversed();
    return Row(
      children: <Widget>[errorIllustration, errorDescription, action],
    );
  }

  Widget _buildReversed() {
    return Row(
      children: <Widget>[errorDescription, errorIllustration, action],
    );
  }
}
