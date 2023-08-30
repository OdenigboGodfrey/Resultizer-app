import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer/theme/themenotifer.dart';
import 'package:resultizer/view/splash_view/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        MultiProvider(providers: [
          ChangeNotifierProvider(
            create: (context) => ColorNotifire(),
          )
        ])
      ],
      child: GetMaterialApp(
        title: "resultizer",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const SplashView(),
      ),
    );
  }
}
