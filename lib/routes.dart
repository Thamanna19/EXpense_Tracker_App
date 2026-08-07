import 'package:flutter/material.dart';

import 'screens/auth/login_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/analytics/analytics_screen.dart';


abstract final class AppRoutes {


  static const splash = '/';

  static const login = '/login';

  static const register = '/register';

  static const dashboard = '/dashboard';

  static const transactions = '/transactions';

  static const analytics = '/analytics';

  static const budget = '/budget';

  static const categories = '/categories';

  static const reports = '/reports';

  static const profile = '/profile';

  static const settings = '/settings';





  static Route onGenerateRoute(RouteSettings settings) {


    switch (settings.name) {


      case AppRoutes.splash:

        return MaterialPageRoute(

          builder: (_) =>
              const SplashScreen(),

        );




      case AppRoutes.login:

        return MaterialPageRoute(

          builder: (_) =>
              const LoginScreen(),

        );





      case AppRoutes.register:

        return MaterialPageRoute(

          builder: (_) =>
              const RegisterScreen(),

        );





      case AppRoutes.dashboard:

        return MaterialPageRoute(

          builder: (_) =>
              const DashboardScreen(),

        );






      case AppRoutes.analytics:

        return MaterialPageRoute(

          builder: (_) =>
              const AnalyticsScreen(),

        );







      default:

        return MaterialPageRoute(

          builder: (_) =>
              const SplashScreen(),

        );

    }


  }


}