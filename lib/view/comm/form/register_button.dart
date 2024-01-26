import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final Function()? onPressed;

  const RegisterButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Theme.of(context).disabledColor;
              } else {
                return Theme.of(context).colorScheme.primaryContainer;
              }
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Theme.of(context).disabledColor;
              } else {
                return Theme.of(context).colorScheme.onPrimaryContainer;
              }
            }),
          ),
          child: const Text('등록', style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15
          ),),
        ),
        const Padding(padding: EdgeInsets.only(right: 10)),
      ],
    );
  }
}
