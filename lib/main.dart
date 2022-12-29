import 'package:flutter/material.dart';
import 'package:surveyapp/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:surveyapp/home_page.dart';
import 'package:surveyapp/theme/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale(defaultLanguageCode, '');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();

    currentTheme.addListener(() {
      setState(() {});
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      onGenerateTitle: (context) {
        var t = AppLocalizations.of(context);
        return t!.appTitle;
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: CustomTheme.appLightTheme(context),
      darkTheme: CustomTheme.appDarkTheme(context),
      debugShowCheckedModeBanner: false,
      themeMode: currentTheme.currentTheme(),
      // home: ScorePage(dimensionList: [
      //   Dimension(dimensionName: "asdasd", totalScore: 3, maxScore: 36),
      //   Dimension(dimensionName: "sssss", totalScore: 3, maxScore: 36),
      //   Dimension(dimensionName: "ccc", totalScore: 3, maxScore: 36),
      // ], userId: 0),
      home: const HomePage(),
    );
  }
}
