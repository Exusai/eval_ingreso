import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'controllers/auth.dart';
import 'controllers/overridePokeAPI.dart';
import 'controllers/wrapper.dart';
import 'models/pokemon.dart';
import 'models/user.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Usuario?> (
          initialData: null,
          create: (context) => AuthService().user,
        ),
        StreamProvider<List<Pokemon>> (
          initialData: const [],
          create: (context) => OverridePokeAPI().getPokemonsAsStream,
          catchError: (context, error) {
            // En caso de error firebase quizás este vacio entonces copiar pokeapi
            OverridePokeAPI().getPokemons();
            return const [];
          },
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorSchemeSeed: Colors.redAccent,
          brightness: Brightness.light,

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              //primary: const Color(0xFFD90D32),
              enableFeedback: true,
            ),  
          ),
          // Define the default font family.
          fontFamily: 'Robotto',
          sliderTheme: const SliderThemeData(
            trackHeight: 18,
            inactiveTrackColor: Colors.grey,
            thumbShape: RoundSliderThumbShape(elevation: 0),
          ),
          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 36.0, fontWeight: FontWeight.normal, color: Colors.white),
            headline3: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300, color: Colors.black,  ),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        home: const Wrapper(),
      ),
    );
  }
}