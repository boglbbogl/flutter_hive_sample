import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
