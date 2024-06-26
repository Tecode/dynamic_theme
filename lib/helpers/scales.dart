// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class TextScaleValue {
  const TextScaleValue(this.scale, this.label);

  final double scale;
  final String label;

  @override
  bool operator ==(other) {
    if (runtimeType != other.runtimeType) return false;
    final dynamic typedOther = other;
    return scale == typedOther.scale && label == typedOther.label;
  }

  @override
  int get hashCode => Object.hash(scale, label);

  @override
  String toString() => '$runtimeType($label)';
}

const List<TextScaleValue> textScaleValues = <TextScaleValue>[
  TextScaleValue(1.0, 'System Default'),
  TextScaleValue(0.8, 'Small'),
  TextScaleValue(1.0, 'Normal'),
  TextScaleValue(1.3, 'Large'),
  TextScaleValue(2.0, 'Huge'),
];
