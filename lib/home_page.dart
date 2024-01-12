import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_sample/todo.dart';
import 'package:flutter_hive_sample/todo_edit_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void _addTodo(Object? value) async {
    if (value != null) {
      Todo todo = value as Todo;
      print(todo);
      Box<Todo> box = Hive.box<Todo>("todo");
      print(box.values);
      box.add(todo);
      // await box.add();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontSize: 24),
                            text: "TODO",
                            children: [
                          TextSpan(
                              text: " with Hive",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Color.fromRGBO(155, 155, 155, 1))),
                        ])),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        _showEditSheet();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: const Icon(
                          Icons.add_box_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                SliverList.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Text(
                          MediaQuery.of(context).viewInsets.bottom.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditSheet() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => const TodoEditWidget(),
      isScrollControlled: true,
    ).then(_addTodo);
  }
}
