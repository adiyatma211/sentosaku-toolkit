import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const initialDashboardTourSeenKey = 'has_seen_dashboard_onboarding';

  Future<bool> shouldShowInitialDashboardTour() async {
    final preferences = await SharedPreferences.getInstance();
    return !(preferences.getBool(initialDashboardTourSeenKey) ?? false);
  }

  Future<void> markInitialDashboardTourSeen() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(initialDashboardTourSeenKey, true);
  }
}
