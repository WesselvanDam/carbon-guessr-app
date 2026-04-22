import 'dart:async';

import 'package:flutter/material.dart';

import 'snackbar.dart';

class AppSnackbarPresenter {
  AppSnackbarPresenter._();

  static OverlayEntry? _currentEntry;
  static AnimationController? _currentController;
  static Timer? _dismissTimer;

  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    unawaited(
      _show(
        context,
        snackbar: AppSnackbar.success(
          message: message,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
        duration: duration,
      ),
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    unawaited(
      _show(
        context,
        snackbar: AppSnackbar.error(
          message: message,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
        duration: duration,
      ),
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    unawaited(
      _show(
        context,
        snackbar: AppSnackbar.warning(
          message: message,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
        duration: duration,
      ),
    );
  }

  static void showNeutral(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(milliseconds: 2500),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    unawaited(
      _show(
        context,
        snackbar: AppSnackbar.neutral(
          message: message,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
        duration: duration,
      ),
    );
  }

  static Future<void> _show(
    BuildContext context, {
    required AppSnackbar snackbar,
    required Duration duration,
  }) async {
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) {
      return;
    }

    await _dismissCurrent();

    final animationController = AnimationController(
      vsync: overlay,
      duration: const Duration(milliseconds: 220),
      reverseDuration: const Duration(milliseconds: 180),
    );
    final animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    final entry = OverlayEntry(
      builder: (overlayContext) {
        final mediaQuery = MediaQuery.maybeOf(overlayContext);
        final safeBottom = mediaQuery?.padding.bottom ?? 0;
        final bottomInset = mediaQuery?.viewInsets.bottom ?? 0;

        return Positioned(
          left: 16,
          right: 16,
          bottom: safeBottom + bottomInset + 16,
          child: Material(
            type: MaterialType.transparency,
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(animation),
                child: snackbar,
              ),
            ),
          ),
        );
      },
    );

    _currentEntry = entry;
    _currentController = animationController;

    overlay.insert(entry);
    await animationController.forward();

    _dismissTimer = Timer(duration, () {
      unawaited(_dismissCurrent());
    });
  }

  static Future<void> _dismissCurrent() async {
    _dismissTimer?.cancel();
    _dismissTimer = null;

    final entry = _currentEntry;
    final controller = _currentController;
    _currentEntry = null;
    _currentController = null;

    if (entry == null || controller == null) {
      return;
    }

    try {
      if (controller.status != AnimationStatus.dismissed) {
        await controller.reverse();
      }
    } catch (_) {
      // If vsync is no longer active, remove immediately.
    } finally {
      entry.remove();
      controller.dispose();
    }
  }
}
