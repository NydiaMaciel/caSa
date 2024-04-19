import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:demo_casa_3/screens/generals/login.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales:[
        const Locale('es'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: appBarcolor,
        dialogBackgroundColor: color25,
        focusColor: color6,
        buttonTheme: ButtonThemeData(
          buttonColor: color6,
          splashColor: appBarcolor4,
          focusColor: color6,
        ),
        
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: fucsia,
          circularTrackColor: color6,
          linearMinHeight: 20.0,
        ),
      ),
      home: Login(),
    );
  }
}