import 'package:flutter/material.dart';
import 'input_decorations.dart';

class TextFieldGeneric extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  
  final String labelText;
  final TextInputType keyboardType;
  const TextFieldGeneric({super.key, required this.textController, required this.hintText, required this.labelText, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(

            controller: textController,
            keyboardType: keyboardType,
            decoration: InputDecorations.authInputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, size: 20,),
                  onPressed: () => textController.clear(),
                ),
                hintText: hintText, labelText: labelText)));
  }
}
