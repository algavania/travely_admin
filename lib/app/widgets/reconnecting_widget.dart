import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReconnectingWidget extends StatelessWidget {
  const ReconnectingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitChasingDots(
      color: Theme.of(context).primaryColor,
      size: 50.0,
    ));
  }
}
