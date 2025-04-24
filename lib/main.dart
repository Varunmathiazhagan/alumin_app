import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'screens/role_selection.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/alumni_home.dart';
import 'screens/student_home.dart';
import 'screens/admin_home.dart';
import 'screens/home.dart';
import 'screens/alumni_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyComXG27FpCCwvh2aCclFDylHOUF5Rfgds",
        authDomain: "alumni-app-5.firebaseapp.com",
        projectId: "alumni-app-5",
        storageBucket: "alumni-app-5.appspot.com",
        messagingSenderId: "295775818288",
        appId: "1:295775818288:web:4659ca84f50c6d9c0ad3f5",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(AlumniApp());
}

class AlumniApp extends StatelessWidget {
  const AlumniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alumni App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue.shade800),
          titleTextStyle: TextStyle(
            color: Colors.blue.shade800,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => RoleSelectionPage());
          case '/login':
            final args = settings.arguments as Map<String, String>?;
            return MaterialPageRoute(
              builder: (_) => LoginPage(
                role: args?['role'] ?? 'alumni',
              ),
            );
          case '/signup':
            final args = settings.arguments as Map<String, String>?;
            return MaterialPageRoute(
              builder: (_) => SignupPage(
                role: args?['role'] ?? 'alumni',
              ),
            );
          case '/alumni_home':
            return MaterialPageRoute(builder: (_) => AlumniHomePage());
          case '/student_home':
            return MaterialPageRoute(builder: (_) => StudentHomePage());
          case '/admin_home':
            return MaterialPageRoute(builder: (_) => AdminHomePage());
          case '/home':
            return MaterialPageRoute(builder: (_) => const OpenSourceHomePage());
          case '/alumnihome':
            return MaterialPageRoute(builder: (_) => AlumniHomePage());
          default:
            return MaterialPageRoute(builder: (_) => RoleSelectionPage());
        }
      },
    );
  }
}