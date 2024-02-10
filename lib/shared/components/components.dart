import 'package:flutter/material.dart';
import 'package:social_app/models/massage_model/massage_model.dart';
import 'package:social_app/shared/components/constatans.dart';
import 'package:social_app/shared/style/icon_broken.dart';
import 'package:toast/toast.dart';

// import 'package:fluttertoast/fluttertoast.dart';
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        maintainState: false,
      ),
    );

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
          maintainState: false,
    ),
    (Route<dynamic> route) => false);

PreferredSizeWidget customAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(IconBroken.Arrow___Left_2),
      ),
      titleSpacing: 5.0,
      title: Text('$title'),
      actions: actions,
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = false,
  Function? onTap, // Update the parameter name to onTap
  required String? Function(String?)? validate,
  required String label,
  required IconData icon,
  bool is_clickable = true,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    enabled: is_clickable,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit as void Function(String)?,
    onChanged: onChange as void Function(String)?,
    onTap: onTap as void Function()?,
    validator: validate,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: suffixPressed,
              icon: Icon(
                suffix,
              ),
            )
          : null,
      border: const OutlineInputBorder(),
    ),
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () => function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) =>
    TextButton(
      onPressed: function, // Remove the parentheses here
      child: Text(
        text.toUpperCase(),
      ),
    );

void showToast({
  required String massage,
  required ToastStates state,
}) =>
    Toast.show(
      backgroundColor: chooseToastColor(state)!,
      massage,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      textStyle: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
      ),
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color? chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }

  return color;
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: sender_color,
      ),
    );

Widget chatBubble(MessageModel model) => Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(
          left: 16.0,
          top: 16.0,
          bottom: 16.0,
          right: 16.0,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: sender_color,
        ),
        child: Text(
          '${model.text}',
        ),
      ),
    );

Widget myChatBubble(MessageModel model) => Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(
          left: 16.0,
          top: 16.0,
          bottom: 16.0,
          right: 16.0,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: reciever_color[300],
        ),
        child: Text(
          '${model.text}',
        ),
      ),
    );
