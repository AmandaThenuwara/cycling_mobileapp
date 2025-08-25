class AppConstants {
  // App Information
  static const String appName = 'EcoCycle';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Safe Cycling, Green Future';
  
  // Route Names
  static const String splashRoute = '/splash';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String mapRoute = '/map';
  static const String reportRoute = '/report';
  static const String fitnessRoute = '/fitness';
  static const String emergencyRoute = '/emergency';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
  
  // API Endpoints (Mock for now)
  static const String baseUrl = 'https://api.ecocycle.com';
  static const String authEndpoint = '/auth';
  static const String routesEndpoint = '/routes';
  static const String reportsEndpoint = '/reports';
  static const String usersEndpoint = '/users';
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String isFirstTimeKey = 'is_first_time';
  static const String themeKey = 'theme_mode';
  static const String emergencyContactsKey = 'emergency_contacts';
  
  // Default Values
  static const double defaultLatitude = 40.7128; // New York
  static const double defaultLongitude = -74.0060;
  static const double defaultZoom = 15.0;
  
  // Animation Durations
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  
  // Eco-friendly Metrics
  static const double co2SavedPerKm = 0.2; // kg CO2 saved per km cycled
  static const double caloriesPerKm = 30.0; // calories burned per km
  
  // Hazard Types
  static const List<String> hazardTypes = [
    'Pothole',
    'Unsafe Road',
    'Heavy Traffic',
    'Theft Prone Area',
    'Poor Lighting',
    'Construction',
    'Weather Hazard',
    'Other'
  ];
  
  // Route Types
  static const List<String> routeTypes = [
    'Safest',
    'Fastest',
    'Eco-Friendly',
    'Scenic'
  ];
  
  // Achievement Types
  static const List<String> achievementTypes = [
    'First Ride',
    'Distance Milestone',
    'Eco Warrior',
    'Community Helper',
    'Safety Champion',
    'Weekly Streak'
  ];
  
  // Notification Types
  static const String notificationHazard = 'hazard_alert';
  static const String notificationAchievement = 'achievement_unlocked';
  static const String notificationEmergency = 'emergency_alert';
  static const String notificationRoute = 'route_update';
  
  // Error Messages
  static const String networkError = 'Network connection error. Please check your internet connection.';
  static const String locationError = 'Unable to get your location. Please enable location services.';
  static const String permissionError = 'Permission denied. Please grant the required permissions.';
  static const String generalError = 'Something went wrong. Please try again.';
  
  // Success Messages
  static const String reportSubmitted = 'Hazard report submitted successfully!';
  static const String rideStarted = 'Ride started! Stay safe on the road.';
  static const String rideCompleted = 'Great ride! Your stats have been updated.';
  static const String profileUpdated = 'Profile updated successfully!';
  
  // Placeholder Images
  static const String placeholderAvatar = 'assets/images/placeholder_avatar.png';
  static const String placeholderMap = 'assets/images/placeholder_map.png';
  static const String placeholderHazard = 'assets/images/placeholder_hazard.png';
  
  // Icons
  static const String iconHome = 'assets/icons/home.svg';
  static const String iconMap = 'assets/icons/map.svg';
  static const String iconReport = 'assets/icons/report.svg';
  static const String iconFitness = 'assets/icons/fitness.svg';
  static const String iconEmergency = 'assets/icons/emergency.svg';
  static const String iconProfile = 'assets/icons/profile.svg';
  static const String iconBike = 'assets/icons/bike.svg';
  static const String iconEco = 'assets/icons/eco.svg';
  static const String iconSafety = 'assets/icons/safety.svg';
}
