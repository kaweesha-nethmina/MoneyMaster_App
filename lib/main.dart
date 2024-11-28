import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/auth/auth_screen.dart';  // Import your auth screen
import './screens/home/home_screen.dart';  // Import your home screen
import './screens/dashboard/dashboard.dart';  // Import your dashboard screen

void main() async {
  // Ensure that Flutter bindings are initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  // Run the app after Firebase initialization
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoneyMaster',  // The name of your app
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Set a primary color for your app
      ),
      initialRoute: '/',  // Start with the AuthScreen
      routes: {
        '/': (context) => const AuthScreen(),  // Auth screen for login/sign-up
        '/home': (context) => const HomeScreen(),  // Home screen after successful login
        '/dashboard': (context) => const DashboardPage(),  // Dashboard screen after home
      },
    );
  }
}
