import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  primaryColor: defaultColor,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    backwardsCompatibility: false,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 40,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: defaultColor,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontWeight:FontWeight.bold ,
          fontSize: 25,
          color: Colors.black
      ),
      subtitle1: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600
      )
  ),
);
ThemeData darkTheme =  ThemeData(
    scaffoldBackgroundColor: HexColor('333739'),
    //brightness: Brightness.light,
    primaryColor: defaultColor,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
          color: Colors.white
      ),
      elevation: 0,
      backgroundColor: HexColor('333739'),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontWeight:FontWeight.bold ,
              fontSize: 25,
              color: Colors.white
          ),
          subtitle1: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600
          )
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
        size: 40,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: defaultColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: HexColor('333739'),
        unselectedItemColor: Colors.grey
    ),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontWeight:FontWeight.bold ,
            fontSize: 25,
            color: Colors.white
        )
    )
);