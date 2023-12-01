import 'package:flutter/material.dart';
import 'package:std_ass/to_do/buttons.dart';

class DialogBox extends StatelessWidget {
  final Controller;

  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    super.key,
    this.Controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(249, 243, 211, 0.7),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: Controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new Task",
              ),
            ),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save
                Button(text: "Save", onPressed: onSave),
                const SizedBox(width: 8),
                // Cancel
                Button(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
