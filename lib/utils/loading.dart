import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loading(BuildContext context, double size) {
  return LoadingAnimationWidget.discreteCircle(
    color: Theme.of(context).primaryColor,
    secondRingColor: Colors.amber,
    thirdRingColor: Colors.purple,
    size: size,
  );
}

Widget loadingThreeRotatingDots(BuildContext context, double size) {
  return LoadingAnimationWidget.threeRotatingDots(
    color: Theme.of(context).primaryColor,
    size: size,
  );
}
