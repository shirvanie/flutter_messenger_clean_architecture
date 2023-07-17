

import 'dart:ui';

import 'package:flutter/material.dart';

class Blur extends StatelessWidget {
  const Blur({super.key, required this.child, this.sigmaX = 5.0, this.sigmaY = 5.0});

  final Widget child;
  final double sigmaX;
  final double sigmaY;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: sigmaX,
              sigmaY: sigmaY,
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
