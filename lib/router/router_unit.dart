import 'package:flutter/material.dart';

class RouterUnit {
  const RouterUnit({
    @required this.title,
    @required this.buildRoute,
    @required this.routeName,
    this.icon,
    this.subtitle,
    this.category,
    this.documentationUrl,
  })  : assert(title != null),
        assert(routeName != null),
        assert(buildRoute != null);

  final String title;
  final IconData icon;
  final String subtitle;
  final RouterCategory category;
  final String routeName;
  final WidgetBuilder buildRoute;
  final String documentationUrl;

  @override
  String toString() => '$runtimeType($title $routeName)';
}

class RouterCategory {
  const RouterCategory._({
    @required this.name,
    @required this.icon,
  });

  final String name;
  final IconData icon;

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final typedOther = other;
    return typedOther.name == name && typedOther.icon == icon;
  }

  @override
  int get hashCode => hashValues(name, icon);

  @override
  String toString() => '$runtimeType($name)';
}

const RouterCategory kDemos = RouterCategory._(
  name: 'Studies',
  icon: Icons.arrow_back_ios,
);
