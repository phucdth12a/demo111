import 'package:black_hole/helpers/config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GradientContainer extends StatefulWidget {
  const GradientContainer({
    super.key,
    this.child,
    this.opacity,
  });

  final Widget? child;
  final bool? opacity;

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  final currentTheme = GetIt.I<MyTheme>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: Theme.of(context).brightness == Brightness.dark
              ? ((widget.opacity == true)
                  ? currentTheme.getTransBackGradient()
                  : currentTheme.getBackGradient())
              : [
                  const Color(0xfff5f9ff),
                  Colors.white,
                ],
        ),
      ),
      child: widget.child,
    );
  }
}

class BottomGradientContainer extends StatefulWidget {
  const BottomGradientContainer({
    super.key,
    this.child,
    this.margin,
    this.padding,
    this.borderRadius,
  });

  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  @override
  State<BottomGradientContainer> createState() =>
      _BottomGradientContainerState();
}

class _BottomGradientContainerState extends State<BottomGradientContainer> {
  final currentThem = GetIt.I<MyTheme>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.fromLTRB(25, 0, 25, 25),
      padding: widget.padding ?? const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: BoxDecoration(
        borderRadius:
            widget.borderRadius ?? const BorderRadius.all(Radius.circular(15)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: Theme.of(context).brightness == Brightness.dark
              ? currentThem.getBottomGradient()
              : [
                  Colors.white,
                  Theme.of(context).canvasColor,
                ],
        ),
      ),
      child: widget.child,
    );
  }
}

class GradientCard extends StatefulWidget {
  const GradientCard({
    super.key,
    this.child,
    this.radius,
    this.elevation,
  });

  final Widget? child;
  final BorderRadius? radius;
  final double? elevation;

  @override
  State<GradientCard> createState() => _GradientCardState();
}

class _GradientCardState extends State<GradientCard> {
  final currentTheme = GetIt.I<MyTheme>();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.elevation ?? 3,
      shape: RoundedRectangleBorder(
        borderRadius: widget.radius ?? BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: Theme.of(context).brightness == Brightness.dark
                ? currentTheme.getCardGradient()
                : [
                    Colors.white,
                    Theme.of(context).canvasColor,
                  ],
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
