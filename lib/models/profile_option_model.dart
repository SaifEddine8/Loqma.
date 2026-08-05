import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileOptionModel {

  final String title;
  final IconData icon;
  final Function(BuildContext) onTap;

  ProfileOptionModel({
    required this.title,
    required this.icon,
    required this.onTap,
  });


}