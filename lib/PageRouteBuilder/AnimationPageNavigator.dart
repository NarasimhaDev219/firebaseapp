import 'package:flutter/material.dart';

class AnimationPageNavigator extends PageRouteBuilder {
  final Widget widget;
  AnimationPageNavigator({this.widget})
      : super(
             transitionDuration: Duration(seconds: 1),
       pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secAnimation) {
        return widget;
      },
      transitionsBuilder: (context,animation,
          secAnimation, widget) {
      //  animation = CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(2.0, 0.0),
            end: Offset.zero
          ).animate(animation),
          child: SlideTransition(
           position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(2.0, 0.0),
          ).animate(secAnimation),
          child: widget,
            ),
        );
      },
      
     );
}
