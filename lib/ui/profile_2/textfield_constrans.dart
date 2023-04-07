import 'package:flutter/material.dart';

class TextFormFieldContainer extends StatelessWidget {
  final String labelText;
  final String hintText;
  final EdgeInsets padding;
  final double width;
  final double height;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const TextFormFieldContainer({super.key, 
    required this.labelText,
    required this.hintText,
    this.padding = const EdgeInsets.only(left: 20),
    this.width = double.infinity,
    this.height = 55,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
