import 'package:flutter/material.dart';
class NotificationPayload extends StatelessWidget {
  final String text;
  const NotificationPayload({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(text),
      ),
    );
  }
}
