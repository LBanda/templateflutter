import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/views/home_page.dart';
import 'package:flutter_template/views/login_page.dart';
import 'package:provider/provider.dart';

import 'services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())], 

    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()));
  }
}
