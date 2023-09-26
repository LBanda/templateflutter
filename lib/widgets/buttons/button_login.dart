import 'package:flutter/material.dart';

class MyLoginButton extends StatelessWidget {
  final Function onPressed;
  final bool enabled;
  final bool loading;

  const MyLoginButton(
      {super.key,
      required this.onPressed,
      required this.enabled,
      required this.loading});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.grey.withOpacity(0.5), backgroundColor: Colors.blue, shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 100),
      ),
      onPressed: enabled ? () => onPressed() : null,
      child: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text(
              "Iniciar Sesión",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
    );
  }
}