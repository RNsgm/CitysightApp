import 'package:citysight_app/cache/cached_content.dart';
import 'package:citysight_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CacheContentAdapter());
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const Citysight());
}

class Citysight extends StatelessWidget {
  const Citysight({super.key});

  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color(0xFF2B49E4)));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      localizationsDelegates: [
         GlobalMaterialLocalizations.delegate
       ],
       supportedLocales: [
         const Locale('ru')
       ],
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(),
      theme: ThemeData(
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF304FFE)),  
            
          )
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        colorScheme: const ColorScheme.light(
          primary: Colors.white,
          inversePrimary: Color(0xFF2B49E4),
          secondary: Color(0xFFF77E75),
          primaryContainer: Color(0xFFD8E2FF),
          secondaryContainer: Color(0xFFF5F5F5),
        ),
        textTheme: TextTheme(
          labelMedium: GoogleFonts.lato(fontSize: 12,),
          labelLarge: GoogleFonts.lato(fontSize: 14,),
          bodySmall: GoogleFonts.lato(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 1.5),
          titleLarge: GoogleFonts.oswald(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: Colors.black, height: 1.2),
          labelSmall: GoogleFonts.lato(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: Color(0xFF1F35A4)),
          bodyMedium: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: Color(0xAB000000)),
          
        )
      ),
      themeMode: ThemeMode.light,
      title: "Citysight",
      initialRoute: '/',
      routes: {
        '/':(context) => Home(),
      },
    );
  }
}