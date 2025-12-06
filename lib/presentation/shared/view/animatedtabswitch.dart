import 'package:flutter/material.dart';
import 'package:b_soft_appliction/app/config/theme/colors.dart';

class AnimatedSwitch extends StatefulWidget {
  final bool isShopDetailsSelected;
  final List<String> tab;
  final Function(int) onTabChange;
  const AnimatedSwitch(
      {super.key,
      required this.isShopDetailsSelected,
      required this.onTabChange,
      required this.tab});

  @override
  _AnimatedSwitchState createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch> {
  // bool isShopDetailsSelected = true;

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width * 0.3;
    final double containerHeight = 35;

    return Center(
      child: Stack(
        children: [
          // Background Container for Liquid Animation
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            left: widget.isShopDetailsSelected ? 0 : containerWidth,
            child: Container(
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                borderRadius: widget.isShopDetailsSelected == true
                    ? const BorderRadius.horizontal(left: Radius.circular(15))
                    : BorderRadius.horizontal(right: Radius.circular(15)),
                color: AppColors.secondary, // Liquid Color
              ),
            ),
          ),
          // Main Container with Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  widget.onTabChange(0);
                  // setState(() {
                  //   isShopDetailsSelected = true;
                  // });
                },
                child: Container(
                  width: containerWidth,
                  height: containerHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(15)),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: Text(
                    widget.tab[0],
                    style: TextStyle(
                      color: widget.isShopDetailsSelected
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.onTabChange(1);
                  // setState(() {
                  //   isShopDetailsSelected = false;
                  // });
                },
                child: Container(
                  width: containerWidth,
                  height: containerHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(15)),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: Text(
                    widget.tab[1],
                    style: TextStyle(
                      color: !widget.isShopDetailsSelected
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
