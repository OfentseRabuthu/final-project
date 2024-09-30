class Settings {
  bool useCelsius;
  bool enableNotifications;
  bool useDarkMode;
  String locale;

  Settings({
    this.useCelsius = true,
    this.enableNotifications = true,
    this.useDarkMode = false,
    this.locale = 'en',
  });

  Settings copyWith({
    bool? useCelsius,
    bool? enableNotifications,
    bool? useDarkMode,
    String? locale,
  }) {
    return Settings(
      useCelsius: useCelsius ?? this.useCelsius,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      useDarkMode: useDarkMode ?? this.useDarkMode,
      locale: locale ?? this.locale,
    );
  }
}