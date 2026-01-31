import 'package:flutter/material.dart' as material show Dialog;
import 'package:flutter/widgets.dart';

import '../../styles/app_colors.dart';

class Dialog extends StatelessWidget {
  const Dialog({
    required this.child, super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return material.Dialog(
      backgroundColor: AppColors.neutral50,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
