import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

EdgeInsets mainCardPadding(BuildContext context) =>
    ResponsiveValue(
        context,
        conditionalValues: [
          const Condition.equals(
            name: '4K',
            value: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          ), const Condition.equals(
            name: 'DESKTOP-LG',
            value: EdgeInsets.symmetric(horizontal: 130, vertical: 80),
          ),const Condition.equals(
            name: 'DESKTOP-MD',
            value: EdgeInsets.symmetric(horizontal: 80, vertical: 70),
          ),const Condition.equals(
            name: 'DESKTOP-SM',
            value: EdgeInsets.symmetric(horizontal: 50, vertical: 60),
          ),const Condition.equals(
            name: TABLET,
            value: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          ),const Condition.equals(
            name: MOBILE,
            value: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          ),
        ],
      defaultValue: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    ).value;