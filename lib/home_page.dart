import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_sample/todo_page.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.amber,
      ),
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const TodoPage()));
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
                    return Container();
                  })
            ],
          ),
        ],
      ),
    );
  }
}
