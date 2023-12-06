// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'package:book_distribution_case_one/book_distribution_listing_page/functionalities/constants.dart';
import 'package:flutter/material.dart';

class AddRemoveBookButton extends StatefulWidget {
  final String sign;
  final function;
  const AddRemoveBookButton(this.sign, {required this.function, super.key});

  @override
  State<AddRemoveBookButton> createState() =>
      _AddRemoveBookButtonState(sign, function: function);
}

class _AddRemoveBookButtonState extends State<AddRemoveBookButton> {
  final String sign;
  final function;
  _AddRemoveBookButtonState(this.sign, {required this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: function,
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: sign != '+'
                ? const BorderRadius.only(
                    topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))
                : const BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8))),
        child: Center(child: Text(sign)),
      ),
    );
  }
}


