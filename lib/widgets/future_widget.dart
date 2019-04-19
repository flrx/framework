import 'package:flrx/models/enums/future_status.dart';
import 'package:flutter/material.dart';

class FutureWidget extends StatelessWidget {
  FutureWidget(
      {@required this.status,
      @required this.onSuccess,
      @required this.onFailed,
      this.onInitial,
      this.onFetching});

  final FutureStatus status;

  final Widget onInitial;

  final Widget onFetching;

  final Widget onSuccess;

  final Widget onFailed;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case FutureStatus.INITIAL:
        return onInitial ?? onFetching ?? _buildOnFetching();
      case FutureStatus.FETCHING:
        return onFetching ?? _buildOnFetching();
      case FutureStatus.SUCCESS:
        return onSuccess;
      case FutureStatus.FAILED:
        return onFailed;
      default:
        return Container();
    }
  }

  Widget _buildOnFetching() {
    return Center(child: CircularProgressIndicator());
  }
}
