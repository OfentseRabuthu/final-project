import 'package:flutter/material.dart';

class AppTheme {
  // Light theme definition
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    fontFamily: 'Roboto',  
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,  
      foregroundColor: Colors.white, 
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white, 
      ),
    ),
    cardTheme: const CardTheme(
      color: Colors.blue, 
      elevation: 4,        
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',  
        fontSize: 18,
        color: Colors.white,    
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        color: Colors.white,  
      ),
    ),
  );

  // Dark theme definition
  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    fontFamily: 'Roboto',  
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[800],  
      foregroundColor: Colors.white,      
      titleTextStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,  
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[800], 
      elevation: 4,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Roboto', 
        fontSize: 18,
        color: Colors.white,    
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        color: Colors.white,    
      ),
    ),
  );
}