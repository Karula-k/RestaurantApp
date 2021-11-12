import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restourantapp/pages/list_restaurant.dart';
import 'package:restourantapp/pages/view_pages_menu.dart';

import 'model/restaurant.dart';

void main() {
  //fake cors delete if u test in real device
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ListRestaurant.routeName,
      routes: {
        ListRestaurant.routeName: (context) => const ListRestaurant(),
        ViewDetailsMenu.routeNamed: (context) => ViewDetailsMenu(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}

//fake cors delete if u test in real device
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
