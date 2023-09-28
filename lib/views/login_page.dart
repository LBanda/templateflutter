import 'package:flutter/material.dart';
import 'package:flutter_template/views/register_page.dart';
import 'package:flutter_template/widgets/fields/textfield.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../widgets/alerts/alerta_generica.dart';
import '../widgets/buttons/button_login.dart';
import '../widgets/fields/input_decorations.dart';
import 'home_page.dart';

// ignore: camel_case_types
class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<StatefulWidget> createState() => _loginPageState();
}

// ignore: camel_case_types
class _loginPageState extends State<loginPage> {
  final usernameCrtl = TextEditingController();
  final passwordCrtl = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(30),
          child: Column(
            children: [
              Image.asset("assets/images/logo.png", height: 150,),
              const SizedBox(height: 30),
              TextFieldGeneric(
                textController: usernameCrtl, hintText: 'Usuario', labelText: 'Usuario', keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passwordCrtl,
                obscureText: _obscureText,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off, size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              MyLoginButton(
                onPressed: () async {
                  final username = usernameCrtl.text.trim();
                  final password = passwordCrtl.text.trim();

                  if (username.isEmpty || password.isEmpty) {
                    mostrarAlerta(context, 'Campos vacíos',
                        'Por favor, complete todos los campos');
                    return;
                  }
                  //Pueden agregar mas validaciones antes de pasar al back

                  authService.autenticando = true;

                  final loginOk = await authService.login(username, password);

                  authService.autenticando = false;

                  if (loginOk) {
                    usernameCrtl.clear();
                    passwordCrtl.clear();
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    mostrarAlerta(
                        context, 'Login erroneo', 'Verifique sus datos');
                  }
                },
                enabled: !authService.autenticando,
                loading: authService
                    .autenticando, 
              ),
              const SizedBox(height: 15),
              const Text('o'),
              const SizedBox(height: 15,),
              TextButton(
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                },
                child: const Text('Crear una nueva cuenta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}