import 'package:flutter/material.dart';

class Connecting extends StatefulWidget {
  const Connecting({Key? key}) : super(key: key);

  @override
  State<Connecting> createState() => _ConnectingState();
}

class _ConnectingState extends State<Connecting> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            Text(
              "Connecting...",
              style: TextStyle(fontSize: 20),
            )
          ],
        ));
  }
}
