import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/onboarding_service.dart';

final onboardingServiceProvider = Provider<OnboardingService>((ref) {
  return OnboardingService();
});

final shouldShowInitialDashboardTourProvider = FutureProvider<bool>((ref) {
  return ref.watch(onboardingServiceProvider).shouldShowInitialDashboardTour();
});
