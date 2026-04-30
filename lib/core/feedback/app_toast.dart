import 'package:flutter/material.dart';

enum AppToastType { success, error, info, warning }

class AppToast {
  const AppToast._();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> success(
    BuildContext context,
    String message, {
    String? title,
    String? details,
    bool showCloseAction = true,
    Duration duration = const Duration(milliseconds: 3000),
  }) {
    return show(
      context,
      message,
      type: AppToastType.success,
      title: title,
      details: details,
      showCloseAction: showCloseAction,
      duration: duration,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> error(
    BuildContext context,
    String message, {
    String? title,
    String? details,
    bool showCloseAction = true,
    Duration duration = const Duration(milliseconds: 3600),
  }) {
    return show(
      context,
      message,
      type: AppToastType.error,
      title: title,
      details: details,
      showCloseAction: showCloseAction,
      duration: duration,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> info(
    BuildContext context,
    String message, {
    String? title,
    String? details,
    bool showCloseAction = true,
    Duration duration = const Duration(milliseconds: 2800),
  }) {
    return show(
      context,
      message,
      type: AppToastType.info,
      title: title,
      details: details,
      showCloseAction: showCloseAction,
      duration: duration,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> warning(
    BuildContext context,
    String message, {
    String? title,
    String? details,
    bool showCloseAction = true,
    Duration duration = const Duration(milliseconds: 3200),
  }) {
    return show(
      context,
      message,
      type: AppToastType.warning,
      title: title,
      details: details,
      showCloseAction: showCloseAction,
      duration: duration,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context,
    String message, {
    required AppToastType type,
    String? title,
    String? details,
    bool showCloseAction = true,
    Duration duration = const Duration(milliseconds: 3000),
  }) {
    final messenger = ScaffoldMessenger.of(context);
    final resolvedTitle = title ?? _toastStyle(type).defaultTitle;

    messenger
      ..hideCurrentSnackBar()
      ..clearSnackBars();

    return messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: duration,
        dismissDirection: DismissDirection.horizontal,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 18),
        padding: EdgeInsets.zero,
        content: _AppToastCard(
          type: type,
          title: resolvedTitle,
          message: message,
          details: details,
          showCloseAction: showCloseAction,
          onClose: messenger.hideCurrentSnackBar,
        ),
      ),
    );
  }
}

class _AppToastCard extends StatelessWidget {
  const _AppToastCard({
    required this.type,
    required this.title,
    required this.message,
    required this.details,
    required this.showCloseAction,
    required this.onClose,
  });

  final AppToastType type;
  final String title;
  final String message;
  final String? details;
  final bool showCloseAction;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = _toastStyle(type);
    final accent = style.resolveColor(colorScheme);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: .96, end: 1),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: accent.withValues(alpha: .18)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: .12),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(22),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 10, 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(style.icon, color: accent, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (title.trim().isNotEmpty) ...[
                            Text(
                              title,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                          Text(
                            message,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          if (details != null &&
                              details!.trim().isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              details!.trim(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (showCloseAction)
                      IconButton(
                        onPressed: onClose,
                        tooltip: 'Tutup notifikasi',
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.close_rounded,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToastStyle {
  const _ToastStyle({
    required this.defaultTitle,
    required this.icon,
    required this.resolveColor,
  });

  final String defaultTitle;
  final IconData icon;
  final Color Function(ColorScheme colorScheme) resolveColor;
}

_ToastStyle _toastStyle(AppToastType type) {
  return switch (type) {
    AppToastType.success => _ToastStyle(
      defaultTitle: 'Berhasil',
      icon: Icons.check_circle_rounded,
      resolveColor: (colorScheme) => colorScheme.primary,
    ),
    AppToastType.error => _ToastStyle(
      defaultTitle: 'Terjadi Kesalahan',
      icon: Icons.error_rounded,
      resolveColor: (colorScheme) => colorScheme.error,
    ),
    AppToastType.info => _ToastStyle(
      defaultTitle: 'Info',
      icon: Icons.info_rounded,
      resolveColor: (colorScheme) => colorScheme.secondary,
    ),
    AppToastType.warning => _ToastStyle(
      defaultTitle: 'Perlu Diperhatikan',
      icon: Icons.warning_amber_rounded,
      resolveColor: (colorScheme) => colorScheme.tertiary,
    ),
  };
}
