import 'package:flrx/models/enums/status.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    required this.status,
    required this.onSuccess,
    required this.onFailed,
    this.onInitial,
    this.onFetching = _defaultFetchWidget,
  });

  final Status status;

  final Widget? onInitial;

  final Widget onFetching;

  final Widget onSuccess;

  final Widget onFailed;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.INITIAL:
        return onInitial ?? onFetching;
      case Status.FETCHING:
        return onFetching;
      case Status.SUCCESS:
        return onSuccess;
      case Status.FAILED:
        return onFailed;
      default:
        return Container();
    }
  }

  static const Widget _defaultFetchWidget =
      Center(child: CircularProgressIndicator());
}
