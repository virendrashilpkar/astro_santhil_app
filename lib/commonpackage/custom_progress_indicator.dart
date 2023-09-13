import 'dart:async';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatefulWidget {
  final bool isLoading;
  final String label;
  final int seconds;
  final VoidCallback? nextScreen;

  const CustomProgressIndicator(
      {Key? key,
      required this.label,
      this.isLoading = false,
      this.nextScreen,
      this.seconds = 1})
      : super(key: key);

  @override
  State<CustomProgressIndicator> createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  @override
  void initState() {
    if (!widget.isLoading) {
      switchScreen();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              const SizedBox(height: 20.0),
              Text("${widget.label}",style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }

  void switchScreen() {
    Timer timer = Timer(Duration(seconds: widget.seconds),
        widget.nextScreen ?? () => Navigator.of(context).pop());
  }
}
