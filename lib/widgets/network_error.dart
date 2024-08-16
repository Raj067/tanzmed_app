import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class NetworkErrorMessage extends StatelessWidget {
  const NetworkErrorMessage(
      {super.key,
      this.message =
          "Time out, try checking your internet connection and try again"});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(
            BootstrapIcons.exclamation_circle_fill, // Add Bootstrap icon
            color: Colors.red, // Icon color
          ),
          const SizedBox(width: 10), // Add spacing between icon and text
          Expanded(
            child: Text(
              message,
              style:
                  const TextStyle(color: Colors.black), // Text color (optional)
            ),
          ),
        ],
      ),
    );
  }
}
