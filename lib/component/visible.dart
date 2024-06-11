
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