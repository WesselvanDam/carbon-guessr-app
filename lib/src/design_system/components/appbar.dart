import 'dart:ui';

import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class AppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBar({required this.children, super.key});

  final List<Widget> children;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.neutral100)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(spacing: 12, children: children),
        ),
      ),
    );
  }
}
