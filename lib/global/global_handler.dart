import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget uiLabel(String? text, {
  double fontSize = 16,
  Color? textColor,
  FontWeight fontWeight = FontWeight.normal,
  TextOverflow overflow = TextOverflow.ellipsis,
  int? maxLines,
  TextStyle? style,
}) {
  return Text(
    text ?? "",
    overflow: overflow,
    softWrap:true,
    maxLines: maxLines,
    style: style ?? TextStyle(
      decoration: TextDecoration.none,
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

class GlobalHandler {

  static pushViewController(BuildContext context,Widget page) {
    //rootNavigator=true时，会隐藏底部导航栏
    Navigator.of(context, rootNavigator: true).push(
        CupertinoPageRoute(builder: (context) {
          return page;
        })
    );
  }

  static popViewController(BuildContext context) {
    Navigator.of(context).pop();
  }

  static const Color _toastBackgroundColor = Colors.black;
  static const Color _toastTextColor = Colors.white;

  static showToast(String message,{int duration = 1}) {
    Fluttertoast.showToast(msg: message, timeInSecForIosWeb: duration, gravity: ToastGravity.CENTER, backgroundColor: _toastBackgroundColor, textColor: _toastTextColor);
  }

  static Future<T?> showLoading <T>(BuildContext context) {
    return showDialogView(context: context, backgroundColor: const Color.fromRGBO(255, 255, 255, 0),builder: (context) {
      return GlobalHandler.loadingView(context);
    });
  }

  static void dismissLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static Widget loadingView(BuildContext context) {
    return Container(
      child: Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: Container(
            width: 80,
            height: 80,
            color: Colors.white,
            child: const Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<T?> showDialogView<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    required Color backgroundColor,
    required WidgetBuilder builder,
  }) {
    Widget _buildMaterialDialogTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
        child: child,
      );
    }

    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(
              builder: (BuildContext context) {
                return theme != null
                    ? Theme(data: theme, child: pageChild)
                    : pageChild;
              }
          ),
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: backgroundColor,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

}