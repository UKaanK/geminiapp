import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminialapp/screen/myhomepage.dart';
import 'package:geminialapp/screen/onboardingpage.dart';
import 'package:geminialapp/utilites/themenotifier.dart';
import 'package:geminialapp/utilites/themes.dart';

void main() async{
  await dotenv.load(fileName : ".env");
  runApp(
    ProviderScope(child: MyApp())
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeMode=ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeMode,
      home: const OnBoarding()
    );
  }
}
