import 'package:flrx/models/enums/future_status.dart';
import 'package:flutter/material.dart';

class FutureWidget extends StatelessWidget {
  FutureWidget(
      {@required this.status,
      @required this.buildOnSuccess,
      this.buildOnInitial,
      this.buildOnFailed,
      this.buildOnFetching});

  final FutureStatus status;

  final Widget Function() buildOnInitial;

  final Widget Function() buildOnFetching;

  final Widget Function() buildOnSuccess;

  final Widget Function() buildOnFailed;

  @override
  Widget build(BuildContext context) {
    if (status == FutureStatus.INITIAL) {
      Widget Function() initialBuilder = buildOnInitial ?? _buildOnFetching;
      return initialBuilder();
    } else if (status == FutureStatus.FETCHING) {
      Widget Function() fetchingBuilder = buildOnFetching ?? _buildOnFetching;
      return fetchingBuilder();
    } else if (status == FutureStatus.SUCCESS) {
      return buildOnSuccess();
    } else if (status == FutureStatus.FAILED) {
      return buildOnFailed();
    }
    return Container();
  }

  Widget _buildOnFetching() {
    return Center(child: CircularProgressIndicator());
  }
}
