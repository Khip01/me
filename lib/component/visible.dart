
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

bool contentQuoteIconVisible(BuildContext context) => ResponsiveValue(
  context,
  conditionalValues: [
    const Condition.largerThan(
        name: 'DESKTOP-MD',
        value: true,
    ),
    const Condition.equals(
        name: 'DESKTOP-MD',
        value: true,
    ),
    const Condition.smallerThan(
        name: 'DESKTOP-MD',
        value: false,
    ),
  ],
  defaultValue: true,
).value;

bool contentHistoryVisible(BuildContext context) => ResponsiveValue(
  context,
  conditionalValues: [
    const Condition.largerThan(
      name: 'DESKTOP-MD',
      value: true,
    ),
    const Condition.equals(
      name: 'DESKTOP-MD',
      value: true,
    ),
    const Condition.smallerThan(
      name: 'DESKTOP-MD',
      value: false,
    ),
  ],
).value;

bool getIsMobileSize(BuildContext context) => ResponsiveValue(
  context,
  conditionalValues: [
    const Condition.largerThan(
      name: MOBILE,
      value: false,
    ),
    const Condition.equals(
      name: MOBILE,
      value: true,
    ),
  ],
).value;

bool getIsTabletSize(BuildContext context) => ResponsiveValue(
    context,
    conditionalValues: [
      const Condition.largerThan(
        name: TABLET,
        value: false,
      ),
      const Condition.equals(
        name: TABLET,
        value: true,
      ),
      const Condition.smallerThan(
        name: TABLET,
        value: false,
      ),
    ],
).value;