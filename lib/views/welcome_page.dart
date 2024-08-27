import 'package:flutter/material.dart';
import 'package:todo_list_app/controllers/access_controller.dart';
import 'package:todo_list_app/views/home_page.dart';
import 'package:todo_list_app/views/login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();
    AccessController.instance.hasValidToken().then((hasToken) {
      if(hasToken){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20,),
            Text('Inicializando App'),
          ],
        ),
      ),
    );
  }
}