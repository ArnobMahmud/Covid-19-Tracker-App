import 'package:covid19_app/pages/home-page.dart';
import 'package:covid19_app/provider/covid-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import './ads/ad_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initialization: initFuture);
  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of our application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
      create: (context) => CovidDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid19 App',
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
