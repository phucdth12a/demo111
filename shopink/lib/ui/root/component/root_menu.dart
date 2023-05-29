import 'dart:ui';

import 'package:flutter/material.dart';

class RootMenu extends StatefulWidget {
  const RootMenu({
    super.key,
    required this.tappedCallBack,
    required this.currentIndex,
  });
  final int currentIndex;
  final Function(int) tappedCallBack;

  @override
  State<RootMenu> createState() => _RootMenuState();
}

class _RootMenuState extends State<RootMenu> {
  int selectedIndex = 0;
  @override
  void initState() {
    selectedIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewPadding.bottom;
    return Container(
      height: bottom > 0 ? 60 + MediaQuery.of(context).viewPadding.bottom : 70,
      decoration:
          BoxDecoration(color: Colors.white.withOpacity(0.8), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 5,
        ),
      ]),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Stack(
            children: [
              Row(
                children: [
                  itemMenu(0),
                  itemMenu(1),
                  itemMenu(2),
                  itemMenu(3),
                ],
              ),
              dotMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemMenu(int index) {
    IconData icon = Icons.home;
    final withdItem = MediaQuery.of(context).size.width / 4;
    switch (index) {
      case 0:
        icon = index == selectedIndex ? Icons.home_filled : Icons.home;
        break;
      case 1:
        icon = index == selectedIndex ? Icons.public_off : Icons.public;
        break;
      case 2:
        icon = index == selectedIndex
            ? Icons.heart_broken_rounded
            : Icons.heart_broken_sharp;
        break;
      case 3:
        icon = index == selectedIndex
            ? Icons.person_2_rounded
            : Icons.person_2_outlined;
        break;
    }
    return GestureDetector(
      onTap: () {
        widget.tappedCallBack.call(index);
        selectedIndex = index;
        setState(() {});
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            AnimatedContainer(
              height: index == selectedIndex ? 10 : 20,
              duration: const Duration(milliseconds: 200),
            ),
            SizedBox(
              width: withdItem,
              child: Icon(icon),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  Widget dotMenu() {
    final witdh = MediaQuery.of(context).size.width;
    final withdItem = witdh / 4;
    final left = (selectedIndex * withdItem) + (withdItem / 2) - 3;
    return AnimatedPositioned(
      left: left,
      top: 40,
      duration: const Duration(milliseconds: 200),
      child: Container(
        width: 6,
        height: 6,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
