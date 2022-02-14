import 'package:app_pelis/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:app_pelis/src/providers/title_movie_provider.dart';
import 'package:app_pelis/src/pages/home_page.dart';

import 'package:app_pelis/src/pages/pelicula_detalle_page.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => {
    runApp(MyApp())
  });

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieTitleProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Info Películas',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage(),
          'detalle': (BuildContext context) => PeliculaDetalle(),
        },
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.deepPurple,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepPurple,
            elevation: 0,

          ),
          scaffoldBackgroundColor: Color(0xfff2f2f2),
          textTheme: Typography.blackRedmond
        ),
      ),
    );
  }
}
