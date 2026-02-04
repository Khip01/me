import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

bool contentQuoteIconVisible(BuildContext context) => ResponsiveValue(
  context,
  defaultValue: true,
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

bool contentHistoryVisible(BuildContext context) => ResponsiveValue(
  context,
  defaultValue: false,
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
  defaultValue: false,
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
  defaultValue: false,
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

bool getIsDesktopSmSize(BuildContext context) => ResponsiveValue(
  context,
  defaultValue: false,
  conditionalValues: [
    const Condition.largerThan(
      name: "DESKTOP-SM",
      value: false,
    ),
    const Condition.equals(
      name: "DESKTOP-SM",
      value: true,
    ),
    const Condition.smallerThan(
      name: "DESKTOP-SM",
      value: false,
    ),
  ],
).value;

bool getIsDesktopMdAndBelowSize(BuildContext context) => ResponsiveValue(
  context,
  defaultValue: false,
  conditionalValues: [
    const Condition.largerThan(
      name: "DESKTOP-MD",
      value: false,
    ),
    const Condition.equals(
      name: "DESKTOP-MD",
      value: true,
    ),
    const Condition.smallerThan(
      name: "DESKTOP-MD",
      value: true,
    ),
  ],
).value;

bool getIsDesktopLgAndBelowSize(BuildContext context) => ResponsiveValue(
  context,
  defaultValue: false,
  conditionalValues: [
    const Condition.largerThan(
      name: "DESKTOP-LG",
      value: false,
    ),
    const Condition.equals(
      name: "DESKTOP-LG",
      value: true,
    ),
    const Condition.smallerThan(
      name: "DESKTOP-LG",
      value: true,
    ),
  ],
).value;