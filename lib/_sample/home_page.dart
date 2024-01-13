import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_sample/_sample/todo.dart';
import 'package:flutter_hive_sample/_sample/todo_edit_widget.dart';
import 'package:flutter_hive_sample/_sample/todo_item_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<Todo> _box;
  final ValueNotifier<List<Todo>> _todos = ValueNotifier([]);
  @override
  void initState() {
    super.initState();
    _box = Hive.box<Todo>("todo");
    _init();
  }

  void _init() async {
    _todos.value = _box.values.map((e) => e).toList();
    _sort();
  }

  void _updated(Object? value) async {
    if (value != null) {
      Todo todo = value as Todo;
      _box.put("${todo.no}", todo);
      int i = _todos.value.indexWhere((e) => e.no == todo.no);
      if (i < 0) {
        _todos.value = List.from(_todos.value)..add(todo);
      } else {
        _todos.value = List.from(_todos.value)
          ..removeAt(i)
          ..insert(i, todo);
      }
      _sort();
    }
  }

  void _sort() {
    _todos.value = [
      ..._todos.value.where((e) => !e.isCheck).toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt)),
      ..._todos.value.where((e) => e.isCheck).toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt)),
    ];
  }

  void _onChecked(Todo todo, int index) {
    _box.put("${todo.no}", todo);
    _todos.value = List.from(_todos.value)
      ..removeAt(index)
      ..insert(index, todo);
    _sort();
  }

  void _onDeleted(int? no) {
    if (no == null) {
      _box.clear();
      _todos.value = [];
    } else {
      _box.delete("$no");
      _todos.value = List.from(_todos.value)..removeWhere((e) => e.no == no);
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
                ValueListenableBuilder(
                    valueListenable: _todos,
                    builder: (context, todos, child) {
                      return SliverList.builder(
                          itemCount: todos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TodoItemWidget(
                              todo: todos[index],
                              onTap: () => _showEditSheet(todo: todos[index]),
                              onChecked: (Todo todo) => _onChecked(todo, index),
                              onDeleted: _onDeleted,
                            );
                          });
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditSheet({Todo? todo}) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => TodoEditWidget(
        update: todo,
      ),
      isScrollControlled: true,
    ).then(_updated);
  }
}
