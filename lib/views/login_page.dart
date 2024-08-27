import 'package:flutter/material.dart';
import 'package:todo_list_app/components/app_bar_component.dart';
import 'package:todo_list_app/components/form_text_field_component.dart';
import 'package:todo_list_app/components/main_button_component.dart';
import 'package:todo_list_app/controllers/access_controller.dart';
import 'package:todo_list_app/views/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwdController = TextEditingController();

  Future<void> _login() async {
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if(_formKey.currentState!.validate()) {
      bool login = await AccessController.instance.login(_usernameController.text, _passwdController.text);

      if(login) {
        navigator.pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          )
        );
      } else {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Usuário ou senha inválidos'),
            backgroundColor: Colors.red,
          )
        );
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        leading: false, title: 'ToDo App'
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ToDo App',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ), 
                    FormTextField(
                      labelText: 'Usuário',
                      hintText: 'Usuário de Acesso',
                      textController: _usernameController,
                      textInputAction: TextInputAction.next,
                      inputValidator: (username) {
                        if (username == null || username.isEmpty) {
                          return 'Preencha o campo usuário';
                        }
                        return null;
                      },
                    ),
                    FormTextField(
                      labelText: 'Senha',
                      hintText: 'Senha de Acesso',
                      obscureText: true,
                      textController: _passwdController,
                      textInputAction: TextInputAction.done,
                      inputValidator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Preencha o campo senha';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) async {
                        await _login();
                      },
                    ),
                    mainButton(
                      buttonText: 'Entrar',
                      buttonFunction: () async {
                        await _login();
                      }
                    )
                  ]))
            ],
          ),
        ),
      )
    );
  }
}