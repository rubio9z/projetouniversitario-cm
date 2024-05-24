import 'package:flutter/material.dart';
import 'package:projetoapp/presentation/pages/login/login_page.dart';
import 'package:projetoapp/presentation/pages/views/home_view.dart';

main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}
