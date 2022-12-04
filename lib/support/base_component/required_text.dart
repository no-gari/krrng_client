import 'package:flutter/material.dart';

class RequiredText extends StatelessWidget {
  RequiredText({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      child,
      Text('*',
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20))
    ]);
  }
}
