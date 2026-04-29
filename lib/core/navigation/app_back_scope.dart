import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBackScope extends StatelessWidget {
  const AppBackScope({
    super.key,
    required this.fallbackPath,
    required this.child,
  });

  final String fallbackPath;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        final router = GoRouter.of(context);
        if (router.canPop()) {
          router.pop();
        } else {
          context.go(fallbackPath);
        }
      },
      child: child,
    );
  }
}
