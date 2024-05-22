import 'dart:io';

import 'package:festo_app/api/client.dart';
import 'package:festo_app/samples.dart';
import 'package:festo_app/secrets.dart' as secrets;
import 'package:festo_app/views/add_items/add_items_view.dart';
import 'package:festo_app/views/chat/chat_view.dart';
import 'package:festo_app/views/sales_billing/sales_billing_view.dart';
import 'package:festo_app/views/sales_billing/voucher_form_view.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 30),
  ));
  final BASE_FESTO_API_URL = remoteConfig.getString('BASE_FESTO_API_URL');
  runApp(MultiRepositoryProvider(providers: [
    RepositoryProvider<ApiClient>(
        create: (context) => ApiClient(BASE_FESTO_API_URL, headers: {
              HttpHeaders.authorizationHeader: secrets.SELLER_AUTH_TOKEN
            }))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color(0xfff2f2f2),
        colorScheme: ColorScheme(
          primary: Colors.black,
          secondary: Colors.grey[600]!,
          surface: Colors.white,
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
              color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          displaySmall: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Colors.grey[700], fontSize: 16),
          titleSmall: TextStyle(color: Colors.grey[600], fontSize: 14),
          bodyLarge: const TextStyle(color: Colors.black, fontSize: 14),
          bodyMedium: TextStyle(color: Colors.grey[800], fontSize: 12),
          labelLarge: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          bodySmall: TextStyle(color: Colors.grey[600], fontSize: 12),
          labelSmall: TextStyle(color: Colors.grey[500], fontSize: 10),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.black,
          textTheme: ButtonTextTheme.primary,
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.black,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      home: const AddItemsPage(
        imageUrl:
            'https://storage.googleapis.com/vyser-product-database/kurkure-masala-munch-crisps/20240517_132915.png',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Greate')
      ]),
      body:
          ChatView(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
