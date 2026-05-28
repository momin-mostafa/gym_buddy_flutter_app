import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/configuration.dart' show Configuration;
import 'package:flutter/material.dart';
import 'package:gym_buddy/authentication/view/login.view.dart';
import 'package:gym_buddy/authentication/view_model/auth.vm.dart';
import 'package:gym_buddy/nutrients/data_source/ingredients.db.dart';
import 'package:gym_buddy/nutrients/data_source/ingredients.supabase.api.dart';
import 'package:gym_buddy/nutrients/ingredients_selector.v.dart';
import 'package:gym_buddy/nutrients/nutrients.repo.dart';
import 'package:gym_buddy/splash/splash.v.dart';
import 'package:gym_buddy/user_interaction_tracker.dart'
    show UserInteractionTracker;
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show Supabase, FlutterAuthClientOptions;

import 'authentication/auth.service.dart';
import 'home/home.v.dart' show HomeView;
import 'nutrients/nutrients.vm.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthVM(authService: SupabaseAuthService()),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              NutrientsVM(NutrientsRepo(NutrientsSupabaseApiDataSource())),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: theme,
      home: SplashScreen(),
    );
  }
}

const white = Color(0xFFFEF9F5);
const fitGreen = Color(0xFF72A624);
const sage = Color(0x6672A624);
const darkSage = Color(0xFF18151C);
const black = Color(0xFF18151C);

final theme = ThemeData(
  colorScheme: .fromSeed(seedColor: sage),
  scaffoldBackgroundColor: white,
  inputDecorationTheme: InputDecorationThemeData(
    border: OutlineInputBorder(),
    filled: true,
    fillColor: Colors.white,
  ),
  cardTheme: CardThemeData(color: Colors.white),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  ),
  appBarTheme: AppBarThemeData(
    backgroundColor: fitGreen,
    foregroundColor: darkSage,
    // Color(0xFF85C79A
    // E5EEE4
    // ),
    titleTextStyle: TextStyle(color: Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(50),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: fitGreen, // Color(0xFF85C79A),
    foregroundColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: fitGreen,
    selectedItemColor: fitGreen,
    unselectedItemColor: darkSage,
  ),
);
