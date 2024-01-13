import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_sample/_sample/todo.dart';
import 'package:flutter_hive_sample/_sample/todo_color.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onChecked;
  final Function() onTap;
  final Function(int?) onDeleted;
  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onChecked,
    required this.onTap,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      onLongPress: () {
        HapticFeedback.mediumImpact();
        _showDeleteSheet(context, onDeleted);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 22),
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                onChecked(todo.copyWith(isCheck: !todo.isCheck));
              },
              child: Icon(
                todo.isCheck ? Icons.check_box : Icons.check_box_outline_blank,
                color: const Color.fromRGBO(115, 115, 115, 1),
                size: 32,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4, left: 4),
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: TodoColor.colorOf(todo.tag),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8, top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.content.isEmpty ? "none content" : todo.content,
                      style: todo.content.isEmpty
                          ? const TextStyle(
                              color: Color.fromRGBO(115, 115, 115, 1),
                              fontSize: 16,
                            )
                          : const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                        text: TextSpan(
                      text: todo.updatedAt
                          .toString()
                          .substring(0, 10)
                          .replaceAll("-", ". "),
                      style: const TextStyle(
                        color: Color.fromRGBO(215, 215, 215, 1),
                        fontSize: 12,
                      ),
                      children: [
                        if (todo.createdAt != todo.updatedAt) ...[
                          const TextSpan(
                              text: "  (수정됨)",
                              style: TextStyle(
                                fontSize: 10,
                                color: Color.fromRGBO(115, 115, 115, 1),
                              )),
                        ],
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDeleteSheet(
    BuildContext context,
    Function(int?) onTap,
  ) =>
      showModalBottomSheet(
        context: context,
        builder: (context) => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 112 + MediaQuery.of(context).padding.bottom,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                2,
                (index) => GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    onTap(index == 0 ? todo.no : null);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: index == 0 ? 12 : 0),
                    alignment: Alignment.centerLeft,
                    color: Colors.transparent,
                    height: 50,
                    child: Text(index == 0 ? "Delete" : "All",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: index == 0 ? Colors.black : Colors.red,
                          fontSize: 16,
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
