import 'package:flutter/material.dart';
import 'package:flutter_template/views/login_page.dart';
import 'package:flutter_template/widgets/fields/textfield.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/alerts/alerta_generica.dart';
import '../widgets/buttons/button_register.dart'; 
import '../widgets/fields/input_decorations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
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
                textController: emailController,
                hintText: 'Email',
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              TextFieldGeneric(
                textController: usernameController,
                hintText: 'Usuario',
                labelText: 'Usuario',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Contraseña',
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      size: 20,
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
              MyRegisterButton(
                onPressed: () async {
                  final email = emailController.text.trim();
                  final username = usernameController.text.trim();
                  final password = passwordController.text.trim();

                  if (email.isEmpty || username.isEmpty || password.isEmpty) {
                    mostrarAlerta(
                      context,
                      'Campos vacíos',
                      'Por favor, complete todos los campos',
                    );
                    return;
                  }
                  //Pueden agregar mas validaciones antes de pasar al back

                  authService.autenticando = true;

                  final registerOk = await authService.register(email, username, password);

                  authService.autenticando = false;

                  if (registerOk) {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const loginPage()),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    mostrarAlerta(
                      context,
                      'Registro fallido',
                      'No se pudo completar el registro',
                    );
                  }
                },
                enabled: !authService.autenticando,
                loading: authService.autenticando,
              ),
              const SizedBox(height: 15),
              const Text('¿Ya tienes una cuenta?'),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: const Text('Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
