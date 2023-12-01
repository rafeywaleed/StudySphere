import "package:flutter/material.dart";

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key, required void Function() onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }
}
