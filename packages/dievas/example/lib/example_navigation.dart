import 'package:flutter/material.dart';

abstract final class ExampleNavigation {
  static void dismiss(BuildContext context) => Navigator.of(context).pop();
}
