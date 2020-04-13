// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class TextScaleValue {
  const TextScaleValue(this.scale, this.label);

  final double scale;
  final String label;

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final TextScaleValue typedOther = other;
    return scale == typedOther.scale && label == typedOther.label;
  }

  @override
  int get hashCode => hashValues(scale, label);

  @override
  String toString() {
    return '$runtimeType($label)';
  }
}

const List<TextScaleValue> textScaleValues = <TextScaleValue>[
  TextScaleValue(null, 'System Default'),
  TextScaleValue(0.8, 'Small'),
  TextScaleValue(1.0, 'Normal'),
  TextScaleValue(1.3, 'Large'),
  TextScaleValue(2.0, 'Huge'),
];
