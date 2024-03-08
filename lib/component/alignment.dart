import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:responsive_framework/responsive_framework.dart';

MainAxisAlignment alignmentRowNav(BuildContext context) =>
    ResponsiveValue(context,
            conditionalValues: [
              const Condition.largerThan(
                  name: 'DESKTOP-MD', value: MainAxisAlignment.spaceBetween),
              const Condition.equals(
                  name: 'DESKTOP-MD', value: MainAxisAlignment.spaceBetween),
              const Condition.smallerThan(
                  name: 'DESKTOP-MD', value: MainAxisAlignment.center),
            ],
            defaultValue: MainAxisAlignment.spaceBetween)
        .value;

TextAlign textAlignment(BuildContext context) => ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.largerThan(
          name: 'DESKTOP-MD',
          value: TextAlign.left,
        ),
        const Condition.equals(
          name: 'DESKTOP-MD',
          value: TextAlign.left,
        ),
        const Condition.smallerThan(
          name: 'DESKTOP-MD',
          value: TextAlign.center,
        ),
      ],
      defaultValue: TextAlign.left,
    ).value;

Alignment bottomWidgetAlignment(BuildContext context) => ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.largerThan(
            name: 'DESKTOP-MD', value: Alignment.bottomLeft),
        const Condition.equals(name: 'DESKTOP-MD', value: Alignment.bottomLeft),
        const Condition.smallerThan(
            name: 'DESKTOP-MD', value: Alignment.topCenter),
      ],
      defaultValue: Alignment.bottomLeft,
    ).value;

// Alignment topWidgetAlignment(BuildContext context) => ResponsiveValue(
//       context,
//       conditionalValues: [
//         const Condition.largerThan(
//             name: 'DESKTOP-MD', value: Alignment.topLeft),
//         const Condition.equals(name: 'DESKTOP-MD', value: Alignment.topLeft),
//         const Condition.smallerThan(
//             name: 'DESKTOP-MD', value: Alignment.topCenter),
//       ],
//       defaultValue: Alignment.topLeft,
//     ).value;

MainAxisAlignment alignmentRowLink(BuildContext context) => ResponsiveValue(context,
        conditionalValues: [
          const Condition.largerThan(
              name: 'DESKTOP-MD', value: MainAxisAlignment.start),
          const Condition.equals(
              name: 'DESKTOP-MD', value: MainAxisAlignment.start),
          const Condition.smallerThan(
              name: 'DESKTOP-MD', value: MainAxisAlignment.center),
        ],
        defaultValue: MainAxisAlignment.start)
    .value;
