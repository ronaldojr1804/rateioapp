import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rateioapp/src/pages/home/homepage.dart';

import 'src/providers/rateio_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Rateio(0, 0),
      ),
      ChangeNotifierProvider(
        create: (context) => RateioProporcional(0),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculo Rateio',
      themeMode: ThemeMode.light,
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xff00ae9d),
          primaryContainer: Color(0xff003641),
          secondary: Color(0xff7db61c),
          secondaryContainer: Color(0xff49479d),
          tertiary: Color(0xffc9d200),
          tertiaryContainer: Color(0xffc9d200),
          appBarColor: Color(0xff00ae9d),
          error: Color(0xffb00020),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          useTextTheme: true,
          useM2StyleDividerInM3: true,
        ),
        keyColors: const FlexKeyColors(),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        //useMaterial3: true,
        //swapLegacyOnMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xff00ae9d),
          primaryContainer: Color(0xff003641),
          secondary: Color(0xff7db61c),
          secondaryContainer: Color(0xff49479d),
          tertiary: Color(0xffc9d200),
          tertiaryContainer: Color(0xffc9d200),
          appBarColor: Color(0xff00ae9d),
          error: Color(0xffb00020),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          useTextTheme: true,
          useM2StyleDividerInM3: true,
        ),
        keyColors: const FlexKeyColors(),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
