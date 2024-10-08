import 'package:flutter/material.dart';
import 'package:me/Utility/style_util.dart';
import 'package:responsive_framework/responsive_framework.dart';

Widget dashVertical(BuildContext context, bool darkMode) => ResponsiveValue(
      context,
      conditionalValues: [
        Condition.equals(
          name: '4K',
          value: SizedBox(
            width: 105,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
        Condition.equals(
          name: 'DESKTOP-LG',
          value: SizedBox(
            width: 105,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
        Condition.equals(
          name: 'DESKTOP-MD',
          value: SizedBox(
            width: 80,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
        Condition.equals(
          name: 'DESKTOP-SM',
          value: SizedBox(
            width: 60,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
        Condition.equals(
          name: TABLET,
          value: SizedBox(
            width: 40,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
        Condition.equals(
          name: MOBILE,
          value: SizedBox(
            width: 0,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
      ],
      defaultValue: SizedBox(
        width: 0,
        height: 1,
        child: MySeparator(
          color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
        ),
      ),
    ).value;

Widget dashHorizontal(BuildContext context, bool darkMode) => ResponsiveValue(
      context,
      conditionalValues: [
        Condition.equals(
          name: '4K',
          value: SizedBox(
            width: 282,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
        Condition.equals(
          name: 'DESKTOP-LG',
          value: SizedBox(
            width: 282,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
        Condition.equals(
          name: 'DESKTOP-MD',
          value: SizedBox(
            width: 202,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
        Condition.equals(
          name: 'DESKTOP-SM',
          value: SizedBox(
            width: 142,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
        Condition.equals(
          name: TABLET,
          value: SizedBox(
            width: 100,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
        Condition.equals(
          name: MOBILE,
          value: SizedBox(
            width: 0,
            height: 1,
            child: MySeparator(
              color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
            ),
          ),
        ),
      ],
      defaultValue: SizedBox(
        width: 0,
        height: 1,
        child: MySeparator(
          color: (darkMode) ? StyleUtil.c_255 : StyleUtil.c_170,
        ),
      ),
    ).value;

Widget bottomHelper(BuildContext context) => ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.largerThan(
          name: 'DESKTOP-MD',
          value: SizedBox(
            child: Row(
              children: [
                Text(
                  "select navigation",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 12,
                    color: StyleUtil.c_170,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Icon(
                    Icons.arrow_right_sharp,
                    color: StyleUtil.c_170,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Condition.equals(
          name: 'DESKTOP-MD',
          value: SizedBox(
            child: Row(
              children: [
                Text(
                  "select navigation",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 12,
                    color: StyleUtil.c_170,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Icon(
                    Icons.arrow_right_sharp,
                    color: StyleUtil.c_170,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Condition.smallerThan(
          name: 'DESKTOP-MD',
          value: SizedBox(),
        ),
      ],
      defaultValue: const SizedBox(),
    ).value;

// ---------- ADDITIONAL HELPER------------------
// Dash Line
class MySeparator extends StatelessWidget {
  const MySeparator({super.key, this.height = 1, this.color = Colors.black});
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class FittingMobileSizeDecider extends StatelessWidget {
  final Widget child;
  final bool sizeIsMobile;

  const FittingMobileSizeDecider({
    super.key,
    required this.child,
    required this.sizeIsMobile,
  });

  @override
  Widget build(BuildContext context) {
    if(sizeIsMobile){
      return FittedBox(
        fit: BoxFit.fitWidth,
        child: child,
      );
    } else {
      return child;
    }
  }

}
