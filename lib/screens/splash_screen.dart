import 'package:flutter/material.dart';
import 'package:new_flutter/models/app_state_manager.dart';
import 'package:new_flutter/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<AppStateManager>(context, listen: false).intializeApp();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              height: 200,
              image: AssetImage('assets/logo file/logo.png'),
            ),
            Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
