import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/home/screens/main_nav.dart';
import '../features/routes/screens/map_screen.dart';
import '../features/community/screens/report_screen.dart';
import '../features/fitness/screens/fitness_screen.dart';
import '../features/emergency/screens/emergency_screen.dart';
import '../features/settings/screens/profile_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/auth/screens/onboarding_screen.dart';
import 'constants.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.splashRoute:
        return _buildRoute(
          settings,
          const SplashScreen(),
          fullscreenDialog: true,
        );
      
      case AppConstants.onboardingRoute:
        return _buildRoute(
          settings,
          const OnboardingScreen(),
          fullscreenDialog: true,
        );
      
      case AppConstants.loginRoute:
        return _buildRoute(
          settings,
          const LoginScreen(),
          fullscreenDialog: true,
        );
      
      case AppConstants.registerRoute:
        return _buildRoute(
          settings,
          const RegisterScreen(),
          fullscreenDialog: true,
        );
      
      case AppConstants.homeRoute:
        return _buildRoute(
          settings,
          const MainNav(),
        );
      
      case AppConstants.mapRoute:
        return _buildRoute(
          settings,
          const MapScreen(),
        );
      
      case AppConstants.reportRoute:
        return _buildRoute(
          settings,
          const ReportScreen(),
        );
      
      case AppConstants.fitnessRoute:
        return _buildRoute(
          settings,
          const FitnessScreen(),
        );
      
      case AppConstants.emergencyRoute:
        return _buildRoute(
          settings,
          const EmergencyScreen(),
        );
      
      case AppConstants.profileRoute:
        return _buildRoute(
          settings,
          const ProfileScreen(),
        );
      
      case AppConstants.settingsRoute:
        return _buildRoute(
          settings,
          const SettingsScreen(),
        );
      
      default:
        return _buildRoute(
          settings,
          Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
    }
  }

  static PageRoute<dynamic> _buildRoute(
    RouteSettings settings,
    Widget child, {
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder(
      settings: settings,
      fullscreenDialog: fullscreenDialog,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: AppConstants.pageTransitionDuration,
    );
  }
}
