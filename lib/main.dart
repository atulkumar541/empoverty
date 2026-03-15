import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/welcome_page.dart';
import 'pages/register_worker_page.dart';
import 'pages/home_page.dart';
import 'pages/service_provider_details_page.dart';
import 'providers/auth_provider.dart';
import 'providers/location_provider.dart';
import 'providers/shopkeeper_provider.dart';
import 'providers/worker_provider.dart';
import 'providers/service_provider.dart';
import 'theme/theme_config.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ShopkeeperProvider()),
        ChangeNotifierProvider(create: (_) => WorkerProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
      ],
      child: MaterialApp(
        title: 'EmPoverty',
        theme: AppThemeConfig.lightTheme(),
        darkTheme: AppThemeConfig.darkTheme(),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomePage(),
          '/register-worker': (context) => const RegisterWorkerPage(),
          '/home': (context) => const HomePage(),
          '/service-provider-details': (context) =>
              const ServiceProviderDetailsPage(),
        },
      ),
    );
  }
}
