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
      const Condition.smallerThan(name: 'DESKTOP-MD', value: 2),
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

double contentHighlightWidth (BuildContext context) => ResponsiveValue(
  context,
  conditionalValues: [
    const Condition.largerThan(
      name: 'DESKTOP-SM',
      value: 491,
    ),
    const Condition.equals(
      name: 'DESKTOP-SM',
      value: 491,
    ),
    const Condition.equals(
      name: TABLET,
      value: 391,
    ),
    const Condition.smallerThan(
      name: TABLET,
      value: 491 * 3 / 5,
    ),
  ],
  defaultValue: 491,
).value.toDouble();

double contentHighlightHeight (BuildContext context) => ResponsiveValue(
  context,
  conditionalValues: [
    const Condition.largerThan(
      name: 'DESKTOP-SM',
      value: 406,
    ),
    const Condition.equals(
      name: 'DESKTOP-SM',
      value: 406,
    ),
    const Condition.equals(
      name: TABLET,
      value: 355,
    ),
    const Condition.smallerThan(
      name: TABLET,
      value: ((406) * 3 / 5) + 62,
    ),
  ],
  defaultValue: 386,
).value.toDouble();

double contentHighlightWidthListView (BuildContext context) => ResponsiveValue(
  context,
  conditionalValues: [
    const Condition.largerThan(
      name: 'DESKTOP-SM',
      value: 519,
    ),
    const Condition.equals(
      name: 'DESKTOP-SM',
      value: 519,
    ),
    const Condition.equals(
      name: TABLET,
      value: 419,
    ),
    const Condition.smallerThan(
      name: TABLET,
      value: 505 * 3 / 5,
    ),
  ],
  defaultValue: 519,
).value.toDouble();

double? floatingSidebarThumbFromBottom(double availableWidth) {
  // Mapping manual berdasarkan lebar yang tersedia (Container Query)
  if (availableWidth > 1100) return 24;    // DESKTOP-LG
  if (availableWidth > 800)  return 24;    // DESKTOP-MD
  if (availableWidth > 600)  return 38;    // DESKTOP-SM
  if (availableWidth > 480)  return 58;    // TABLET
  if (availableWidth > 0)    return 5.5;   // MOBILE
  return 7; // Default
}

double floatingSidebarThumbFromRight(double availableWidth) {
  if (availableWidth > 1920) return 24;    // 4K
  if (availableWidth > 1350)  return 24;   // DESKTOP-LG V2
  if (availableWidth > 1100)  return 24;   // DESKTOP-LG
  if (availableWidth > 800)  return 24;    // DESKTOP-MD
  if (availableWidth > 600)  return 18;    // DESKTOP-SM
  if (availableWidth > 480)  return 0;    // TABLET
  if (availableWidth > 0)    return 0;    // MOBILE
  return 7; // Default
}