
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, 
    required this.label,
    required this.onPressed,
  });
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color.fromARGB(255, 247, 46, 129)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          child: Text(label),
          onPressed: () {},
        ));
  }
}
