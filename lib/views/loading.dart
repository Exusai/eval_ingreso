import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF2F2F2),
      child: Center(
        child: SpinKitDoubleBounce(
          color: Theme.of(context).colorScheme.secondary,
          size: 100.0,
        ),
      ),
    );
  }
}