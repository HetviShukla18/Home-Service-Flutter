import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mad_mini_project/MyScreens/LandingPage.dart';
import 'package:mad_mini_project/MyScreens/Homepage.dart';
import 'package:mad_mini_project/MyScreens/LoginPage.dart';
import 'package:mad_mini_project/MyScreens/RegistrationPage.dart';
import 'package:mad_mini_project/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );
  
  runApp(
    // ClerkAuth(
    //   config: ClerkAuthConfig(
    //     publishableKey:
    //         "<YOUR_PUBLISHABLE_KEY>", //clerk key
    //   ),
    //
    // ),
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Services',
      debugShowCheckedModeBanner: false,
      home: LandingPage(title: 'Landing Page'),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => SignUpScreen(),
        '/home': (context) => NextPage1(),
        '/landing': (context) => LandingPage(title: 'Landing Page'),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkAuthStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        if (snapshot.data == true) {
          // User is logged in, go to home
          return NextPage1();
        } else {
          // User is not logged in, show registration page first
          return SignUpScreen();
        }
      },
    );
  }
  
  Future<bool> _checkAuthStatus() async {
    final user = Supabase.instance.client.auth.currentUser;
    return user != null;
  }
}
