import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

EdgeInsets mainCardPadding(BuildContext context) => ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.equals(
          name: '4K',
          value: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        ),
        const Condition.equals(
          name: 'DESKTOP-LG',
          value: EdgeInsets.symmetric(horizontal: 130, vertical: 80),
        ),
        const Condition.equals(
          name: 'DESKTOP-MD',
          value: EdgeInsets.symmetric(horizontal: 80, vertical: 70),
        ),
        const Condition.equals(
          name: 'DESKTOP-SM',
          value: EdgeInsets.symmetric(horizontal: 50, vertical: 60),
        ),
        const Condition.equals(
          name: TABLET,
          value: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        ),
        const Condition.equals(
          name: MOBILE,
          value: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        ),
      ],
      defaultValue: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    ).value;

EdgeInsets contentCardPadding(BuildContext context) => ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.equals(
          name: '4K',
          value: EdgeInsets.symmetric(horizontal: 80),
        ),
        const Condition.equals(
          name: 'DESKTOP-LG',
          value: EdgeInsets.symmetric(horizontal: 65),
        ),
        const Condition.equals(
          name: 'DESKTOP-MD',
          value: EdgeInsets.symmetric(horizontal: 55),
        ),
        const Condition.equals(
          name: 'DESKTOP-SM',
          value: EdgeInsets.symmetric(horizontal: 50),
        ),
        const Condition.equals(
          name: TABLET,
          value: EdgeInsets.symmetric(horizontal: 35),
        ),
        const Condition.equals(
          name: MOBILE,
          value: EdgeInsets.symmetric(horizontal: 30),
        ),
      ],
      defaultValue: const EdgeInsets.symmetric(horizontal: 0),
    ).value;

EdgeInsets mainCardPaddingWithBottomQuote(BuildContext context) => ResponsiveValue(
  context,
  conditionalValues: [
    const Condition.equals(
      name: '4K',
      value: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
    ),
    const Condition.equals(
      name: 'DESKTOP-LG',
      value: EdgeInsets.only(left: 130, right: 130, top: 80, bottom: 0), // v: 80
    ),
    const Condition.equals(
      name: 'DESKTOP-MD',
      value: EdgeInsets.only(left: 80, right: 80, top: 70, bottom: 0), // v: 70
    ),
    const Condition.equals(
      name: 'DESKTOP-SM',
      value: EdgeInsets.only(left: 50, right: 50, top: 60, bottom: 0), // v: 60
    ),
    const Condition.equals(
      name: TABLET,
      value: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 0), // v: 50
    ),
    const Condition.equals(
      name: MOBILE,
      value: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0), // v: 0
    ),
  ],
  defaultValue: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
).value;

double contentQuoteHeight(BuildContext context) => ResponsiveValue(
  context,
  conditionalValues: [
    const Condition.equals(
      name: '4K',
      value: 0
    ),
    const Condition.equals(
      name: 'DESKTOP-LG',
      value: 80
    ),
    const Condition.equals(
      name: 'DESKTOP-MD',
      value: 70
    ),
    const Condition.equals(
      name: 'DESKTOP-SM',
      value: 60
    ),
    const Condition.equals(
      name: TABLET,
      value: 50
    ),
    const Condition.equals(
      name: MOBILE,
      value: 0
    ),
  ],
  defaultValue: 0,
).value.toDouble();

EdgeInsets contentQuotePadding(BuildContext context) => ResponsiveValue(
  context,
  conditionalValues: [
    const Condition.equals(
      name: '4K',
      value: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
    ),
    const Condition.equals(
      name: 'DESKTOP-LG',
      value: EdgeInsets.only(left: 130, right: 130, top: 0, bottom: 0), // v: 80
    ),
    const Condition.equals(
      name: 'DESKTOP-MD',
      value: EdgeInsets.only(left: 80, right: 80, top: 0, bottom: 0), // v: 70
    ),
    const Condition.equals(
      name: 'DESKTOP-SM',
      value: EdgeInsets.only(left: 50, right: 50, top: 0, bottom: 0), // v: 60
    ),
    const Condition.equals(
      name: TABLET,
      value: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0), // v: 50
    ),
    const Condition.equals(
      name: MOBILE,
      value: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0), // v: 0
    ),
  ],
  defaultValue: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
).value;

EdgeInsets contentHighlightListSpace (BuildContext context) => ResponsiveValue(
  context,
  conditionalValues: [
    const Condition.largerThan(
      name: 'DESKTOP-SM',
      value: EdgeInsets.only(right: 28),
    ),
    const Condition.equals(
      name: 'DESKTOP-SM',
      value: EdgeInsets.only(right: 28),
    ),
    const Condition.smallerThan(
      name: 'DESKTOP-SM',
      value: EdgeInsets.only(right: 14),
    ),
  ],
  defaultValue: EdgeInsets.only(right: 28),
).value;

EdgeInsets contentCardPaddingAround(BuildContext context) => ResponsiveValue(
  context,
  conditionalValues: [
    const Condition.equals(
      name: '4K',
      value: EdgeInsets.only(left: 80, right: 80, top: 80),
    ),
    const Condition.equals(
      name: 'DESKTOP-LG',
      value: EdgeInsets.only(left: 65, right: 65, top: 80),
    ),
    const Condition.equals(
      name: 'DESKTOP-MD',
      value: EdgeInsets.only(left: 55, right: 55, top: 80),
    ),
    const Condition.equals(
      name: 'DESKTOP-SM',
      value: EdgeInsets.only(left: 50, right: 50, top: 80),
    ),
    const Condition.equals(
      name: TABLET,
      value: EdgeInsets.only(left: 35, right: 35, top: 80),
    ),
    const Condition.equals(
      name: MOBILE,
      value: EdgeInsets.only(left: 30, right: 30, top: 80),
    ),
  ],
  defaultValue: const EdgeInsets.symmetric(horizontal: 0),
).value;