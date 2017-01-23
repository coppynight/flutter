// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AxisDirection and applyGrowthDirectionToAxisDirection', () {
    expect(AxisDirection.values.length, 4);
    for (AxisDirection axisDirection in AxisDirection.values)
      expect(applyGrowthDirectionToAxisDirection(axisDirection, GrowthDirection.forward), axisDirection);
    expect(applyGrowthDirectionToAxisDirection(AxisDirection.up, GrowthDirection.reverse), AxisDirection.down);
    expect(applyGrowthDirectionToAxisDirection(AxisDirection.down, GrowthDirection.reverse), AxisDirection.up);
    expect(applyGrowthDirectionToAxisDirection(AxisDirection.left, GrowthDirection.reverse), AxisDirection.right);
    expect(applyGrowthDirectionToAxisDirection(AxisDirection.right, GrowthDirection.reverse), AxisDirection.left);
  });

  test('SliverConstraints', () {
    SliverConstraints a = new SliverConstraints(
      axisDirection: AxisDirection.down,
      growthDirection: GrowthDirection.forward,
      userScrollDirection: ScrollDirection.idle,
      scrollOffset: 0.0,
      overlap: 0.0,
      remainingPaintExtent: 0.0,
      crossAxisExtent: 0.0,
    );
    SliverConstraints b = a.copyWith();
    expect(a, equals(b));
    expect(a.hashCode, equals(b.hashCode));
    expect(a.toString(), equals(b.toString()));
    expect(a, hasOneLineDescription);
    expect(a.scrollOffsetAsOffset, equals(const Offset(0.0, 0.0)));
    expect(a.normalizedGrowthDirection, equals(GrowthDirection.forward));

    SliverConstraints c = a.copyWith(
      axisDirection: AxisDirection.up,
      growthDirection: GrowthDirection.reverse,
      userScrollDirection: ScrollDirection.forward,
      scrollOffset: 10.0,
      overlap: 20.0,
      remainingPaintExtent: 30.0,
      crossAxisExtent: 40.0,
    );
    SliverConstraints d = new SliverConstraints(
      axisDirection: AxisDirection.up,
      growthDirection: GrowthDirection.reverse,
      userScrollDirection: ScrollDirection.forward,
      scrollOffset: 10.0,
      overlap: 20.0,
      remainingPaintExtent: 30.0,
      crossAxisExtent: 40.0,
    );
    expect(c, equals(d));
    expect(c.scrollOffsetAsOffset, equals(const Offset(0.0, -10.0)));
    expect(c.normalizedGrowthDirection, equals(GrowthDirection.forward));
    expect(d.scrollOffsetAsOffset, equals(const Offset(0.0, -10.0)));
    expect(d.normalizedGrowthDirection, equals(GrowthDirection.forward));

    SliverConstraints e = d.copyWith(axisDirection: AxisDirection.right);
    expect(e.scrollOffsetAsOffset, equals(const Offset(10.0, 0.0)));
    expect(e.normalizedGrowthDirection, equals(GrowthDirection.reverse));

    SliverConstraints f = d.copyWith(axisDirection: AxisDirection.left);
    expect(f.scrollOffsetAsOffset, equals(const Offset(-10.0, 0.0)));
    expect(f.normalizedGrowthDirection, equals(GrowthDirection.forward));

    SliverConstraints g = d.copyWith(growthDirection: GrowthDirection.forward);
    expect(g.scrollOffsetAsOffset, equals(const Offset(0.0, -10.0)));
    expect(g.normalizedGrowthDirection, equals(GrowthDirection.reverse));
  });

  test('SliverGeometry', () {
    expect(new SliverGeometry().debugAssertIsValid, isTrue);
    expect(() {
      new SliverGeometry(layoutExtent: 10.0, paintExtent: 9.0).debugAssertIsValid;
    }, throwsFlutterError);
    expect(() {
      new SliverGeometry(paintExtent: 9.0, maxPaintExtent: 8.0).debugAssertIsValid;
    }, throwsFlutterError);
  });
}
