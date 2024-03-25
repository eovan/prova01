import '../pages/comicoes.dart';
import '../pages/membros.dart';
import 'package:flutter/material.dart';

import '../pages/HomePage.dart';
import '../pages/details.dart';
import '../pages/search.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Lista de Deputados';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Deputados',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          //color: Colors.lightBlue, // cor de fundo
          foregroundColor: Colors.white, // cor do texto
          elevation: 2, // sombreamento
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: appTitle),
        Details.routeName: (context) => Details(),
        'search': (context) => SearchPage(title: 'Pesquisa'),
        "comicoes": (context) => Comicoes(),
        "membros": (context) => Membros(
              title: 'Membros',
            ),
      },
    );
  }
}
