import 'package:flutter/material.dart';

extension Styling on Widget {
  symmetricPadding({double? horizontal, double? vertical}) => Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? 0, vertical: vertical ?? 0),
      child: this);
  onlyPadding({double? t, double? b, double? l, double? r}) => Padding(
      padding: EdgeInsets.only(
          top: t ?? 0, bottom: b ?? 0, left: l ?? 0, right: r ?? 0),
      child: this);
  center() => Center(child: this);
}

extension Gap on num {
  heightGap() => SizedBox(height: this.toDouble());
  widthGap() => SizedBox(width: this.toDouble());
}
