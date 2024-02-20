// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';

class SlideSelector extends StatefulWidget {
  List items;
  int defaultSelectedIndex;
  bool tappable;
  SlideSelector(
      {Key? key,
      required this.items,
      this.defaultSelectedIndex = 0,
      this.tappable = true})
      : super(key: key);
  @override
  _SlideSelectorState createState() => _SlideSelectorState();
}

class _SlideSelectorState extends State<SlideSelector> {
  int activeItemIndex = 0;

  @override
  void initState() {
    setState(() {
      activeItemIndex = widget.defaultSelectedIndex;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final buttonWidth = (constraints.maxWidth) / 3;
      return Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              top: 0,
              left: activeItemIndex * buttonWidth,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              child: Container(
                width: buttonWidth,
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0.0, 3.0),
                      color: Colors.black.withOpacity(0.12),
                    ),
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: const Offset(0.0, 3.0),
                      color: Colors.black.withOpacity(0.04),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: widget.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value as SlideSelectorItem;
                return Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.tappable) {
                        item.onTap();
                        setState(() {
                          activeItemIndex = index;
                        });
                      }
                    },
                    child: Container(
                      height: 52,
                      // GestureDetector requires a color on the
                      // Container in order to recognize it
                      color: Colors.black.withOpacity(0.01),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          item.text,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: index == activeItemIndex
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }
}

class SlideSelectorItem {
  String text;
  Function onTap;
  SlideSelectorItem({required this.text, required this.onTap});
}
