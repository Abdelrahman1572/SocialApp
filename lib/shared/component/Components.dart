import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget DefaultFormField({
  required TextEditingController Controller,
  required TextInputType Type,
  required Validator,
  onChange,
  onSubmit,
  suffixpressed,
  onTap,
  bool isPassword = false,
  IconData? suffix,
  bool IsClickable = true,
  required String Label,
  required IconData Prefix,
}) =>
    TextFormField(
      controller: Controller,
      keyboardType: Type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      obscureText: isPassword,
      style: const TextStyle(fontSize: 20),
      enabled: IsClickable,
      validator: Validator,
      decoration: InputDecoration(
        labelText: Label,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        floatingLabelStyle: const TextStyle(fontSize: 24),
        prefixIcon: Icon(Prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );

Widget MyDivider() => Container(
  height: 1.0,
  width: double.infinity,
  color: Colors.grey[300],
);

void NavigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void NavigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

void showToasts({required String message, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color colors;
  switch (state) {
    case ToastStates.SUCCESS:
      colors = Colors.green;
      break;
    case ToastStates.ERROR:
      colors = Colors.red;
      break;
    case ToastStates.WARNING:
      colors = Colors.amber;
      break;
  }
  return colors;
}
