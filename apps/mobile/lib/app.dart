import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

class PDFProApp extends StatelessWidget {
  const PDFProApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(brightness: Brightness.dark);

    return MaterialApp(
      title: 'PDF Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF08111F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B7CFF),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.manropeTextTheme(baseTheme.textTheme),
      ),
      home: const HomeScreen(),
    );
  }
}
