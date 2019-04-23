import 'package:flrx/models/enums/status.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  StatusWidget(
      {@required this.status,
      @required this.onSuccess,
      @required this.onFailed,
      this.onInitial,
      this.onFetching});

  final Status status;

  final Widget onInitial;

  final Widget onFetching;

  final Widget onSuccess;

  final Widget onFailed;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.INITIAL:
        return onInitial ?? onFetching ?? _buildOnFetching();
      case Status.FETCHING:
        return onFetching ?? _buildOnFetching();
      case Status.SUCCESS:
        return onSuccess;
      case Status.FAILED:
        return onFailed;
      default:
        return Container();
    }
  }

  Widget _buildOnFetching() {
    return Center(child: CircularProgressIndicator());
  }
}
