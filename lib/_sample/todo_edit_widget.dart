import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_sample/_sample/todo.dart';
import 'package:flutter_hive_sample/_sample/todo_color.dart';

class TodoEditWidget extends StatefulWidget {
  final Todo? update;
  const TodoEditWidget({
    super.key,
    required this.update,
  });

  @override
  State<TodoEditWidget> createState() => _TodoEditWidgetState();
}

class _TodoEditWidgetState extends State<TodoEditWidget> {
  late TextEditingController controller;
  ValueNotifier<int> current = ValueNotifier(0);

  List<Color> colors = [];

  void onChanged(int index) => current.value = index;

  @override
  void initState() {
    super.initState();
    if (widget.update != null) {
      controller = TextEditingController(text: widget.update!.content);
      current.value = widget.update!.tag;
    } else {
      controller = TextEditingController();
    }

    colors = TodoColor.setColors();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - (kToolbarHeight),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.update == null ? "CREATE TODO" : "UPDATE TODO",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).pop(
                        widget.update == null
                            ? Todo.create(controller.text, current.value)
                            : widget.update!.copyWith(
                                content: controller.text, tag: current.value),
                      );
                    },
                    child: Text(
                      widget.update == null ? "SAVE" : "CHAGNGE",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _form(
              "content",
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    )),
                child: TextFormField(
                  controller: controller,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            _form(
              "tag",
              ValueListenableBuilder<int>(
                  valueListenable: current,
                  builder: (context, value, child) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 10,
                        children: [
                          ...List.generate(
                            colors.length,
                            (index) => GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                onChanged(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    border: value == index
                                        ? Border.all(
                                            color: const Color.fromRGBO(
                                                91, 91, 91, 1),
                                            width: 2,
                                          )
                                        : null,
                                    borderRadius: BorderRadius.circular(8),
                                    color: value == index
                                        ? colors[index]
                                        : colors[index].withOpacity(0.6),
                                  ),
                                  child: Visibility(
                                    visible: value == index,
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Container _form(
    String content,
    Widget child,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              content,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(115, 115, 115, 1)),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
