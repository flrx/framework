import 'package:flrx/components/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageNotFound extends StatelessWidget {

  const PageNotFound();

  @override
  Widget build(BuildContext context) {
    log('Route not found');
    throw Exception('Route not found');
  }
}
