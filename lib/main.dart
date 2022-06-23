import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonebook_app/src/screens/home_view.dart';

void main() async {
  await _initServices();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phonebook App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      ),
      home: const HomeView(),
    );
  }
}
