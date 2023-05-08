import 'package:flutter/material.dart';

class HoverBox extends StatefulWidget {
  const HoverBox({super.key, this.child, required this.builder});

  final Widget? child;
  final Widget Function(BuildContext, bool, Widget?) builder;

  @override
  State<HoverBox> createState() => _HoverBoxState();
}

class _HoverBoxState extends State<HoverBox> {
  final ValueNotifier<bool> isInside = ValueNotifier<bool>(false);

  _onEnter(PointerEvent details) {
    isInside.value = true;
  }

  _onExit(PointerEvent details) {
    isInside.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: ValueListenableBuilder(
        valueListenable: isInside,
        builder: (context, value, child) {
          return widget.builder.call(context, value, child);
        },
        child: widget.child,
      ),
    );
  }
}
