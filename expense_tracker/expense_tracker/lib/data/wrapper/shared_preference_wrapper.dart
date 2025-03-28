import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  final String _onboardingCompleteKey = "OnboardingComplete";

  Future<void> remove(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  Future<void> setOnboardingComplete(bool value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(_onboardingCompleteKey, value);
  }

  Future<bool> getOnboardingComplete() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.getBool(_onboardingCompleteKey) ?? false;
    } catch (e) {
      remove(_onboardingCompleteKey);
    }
    return false;
  }

  Future<void> clearDataAfterLogout() async {

  }
}