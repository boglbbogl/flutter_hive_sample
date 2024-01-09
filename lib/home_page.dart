import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Color.fromRGBO(26, 26, 26, 1),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hive Sample",
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w900,
                    fontSize: 24),
              ),
            ),
          ),

          // SliverToBoxAdapter(
          //   child: GestureDetector(
          //     onTap: () async {},
          //     child: Container(
          //       color: Colors.orange,
          //       height: 50,
          //       child: Text("GET"),
          //     ),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: GestureDetector(
          //     onTap: () async {
          //       Box box = Hive.box("car_factory");
          //       box.clear();
          //       box.addAll(cars);
          //       print(box.values);
          //       // box.add();
          //       // print(box.values);
          //     },
          //     child: Container(
          //       color: Colors.orange,
          //       height: 50,
          //       child: Text("CREATE"),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
