import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

int gridFurtherCount(BuildContext context) => ResponsiveValue(context,
        conditionalValues: [
          const Condition.largerThan(name: 'DESKTOP-MD', value: 5),
          const Condition.equals(name: 'DESKTOP-MD', value: 5),
          const Condition.smallerThan(name: 'DESKTOP-MD', value: 3),
        ],
        defaultValue: 5)
    .value;

int flexContentFurther(BuildContext context) => ResponsiveValue(context,
    conditionalValues: [
      const Condition.largerThan(name: 'DESKTOP-MD', value: 1),
      const Condition.equals(name: 'DESKTOP-MD', value: 1),
      const Condition.smallerThan(name: 'DESKTOP-MD', value: 1),
    ],
    defaultValue: 1)
    .value;

double fontSizeWelcomeResize(BuildContext context) => ResponsiveValue(context,
    conditionalValues: [
      const Condition.largerThan(name: TABLET, value: 16),
      const Condition.equals(name: TABLET, value: 16),
      const Condition.smallerThan(name: TABLET, value: 14),
    ],
    defaultValue: 16)
    .value.toDouble();

double iconSizeWelcomeResize(BuildContext context) => ResponsiveValue(context,
    conditionalValues: [
      const Condition.largerThan(name: TABLET, value: 20),
      const Condition.equals(name: TABLET, value: 20),
      const Condition.smallerThan(name: TABLET, value: 16),
    ],
    defaultValue: 20)
    .value.toDouble();