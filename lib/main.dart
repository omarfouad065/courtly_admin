import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const CourtlyAdminApp());
}

class CourtlyAdminApp extends StatelessWidget {
  const CourtlyAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courtly Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xF5F7FAFF),
      ),
      home:
          const DashboardScreen(), // TODO: Route to DashboardScreen after login
    );
  }
}
