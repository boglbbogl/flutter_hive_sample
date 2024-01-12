import 'package:hive_flutter/hive_flutter.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final int no;

  @HiveField(1)
  final String? content;

  @HiveField(2)
  final int tag;

  @HiveField(3)
  final bool isCheck;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime updatedAt;

  const Todo({
    required this.no,
    required this.content,
    required this.tag,
    required this.isCheck,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Todo.create(String? content, int current) => Todo(
        no: DateTime.now().millisecondsSinceEpoch,
        content: content,
        tag: current,
        isCheck: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
  @override
  String toString() =>
      "Todo(no: $no, content: $content, tag: $tag, isCheck: $isCheck, createdAt: $createdAt, updatedAt: $updatedAt)";
}
