import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class kTextFormField extends StatelessWidget {
  kTextFormField({
    required this.lable,
    Key? key,
    required this.kController,
    this.suffixIcon,
    required this.obscure,
    required this.icon,
    required this.validator,
  }) : super(key: key);

  final TextEditingController kController;
  String lable;
  Widget icon;
  Widget? suffixIcon;
  bool obscure;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.white54,
          Colors.white.withOpacity(0.8),
          Colors.white54
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        // keyboardAppearance: TextInputType.text,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.start,
        controller: kController,
        cursorHeight: 25,
        cursorRadius: const Radius.circular(9),
        scrollPadding: const EdgeInsets.symmetric(horizontal: 5),
        // style: ,
        validator: validator,
        obscureText: obscure,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: icon,
          labelText: lable,
          labelStyle:
          const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: Colors.redAccent,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignInside),
          ),
        ),
      ),
    );
  }
}
