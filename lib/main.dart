import 'package:flutter/material.dart';
import 'package:myapp/ui/home.dart';

import 'component/Constants.dart';
import 'package:provider/provider.dart';
import 'component/Theme.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeNotifier())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeNotifier>(context).currentThemeData,
      initialRoute: '/',
      routes: routes,
      onGenerateRoute: _generateRoute,
      navigatorKey: navigatorKey,
    );
  }

  final routes = {
    '/': (BuildContext context) => const MyHomePage(title: "My"),
  };

  Route _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: "Tes",
                ));

      default:
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: "Tes",
                ));
    }
  }
}
