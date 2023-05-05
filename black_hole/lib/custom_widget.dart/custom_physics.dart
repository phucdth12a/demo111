import 'package:flutter/material.dart';

class CustomPhysics extends ScrollPhysics {
  const CustomPhysics({super.parent});

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 150,
        stiffness: 100,
        damping: 1,
      );
}

class PagingScrollPhysics extends ScrollPhysics {
  const PagingScrollPhysics({required this.itemDimension, super.parent});

  final double itemDimension;

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PagingScrollPhysics(
      itemDimension: itemDimension,
      parent: buildParent(ancestor),
    );
  }

  double getPage(ScrollMetrics position) {
    return position.pixels / itemDimension;
  }

  double getPixels(double page) {
    return page * itemDimension;
  }

  double getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return getPixels(page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if ((velocity <= 0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final Tolerance tolerance = this.tolerance;
    final double target = getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
