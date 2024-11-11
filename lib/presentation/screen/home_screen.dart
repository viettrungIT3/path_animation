import 'package:flutter/material.dart';

import '../../utils/constants/string.dart';
import 'widgets/painter_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Fill'),
              Tab(text: 'Travel'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PainterContainer(isFill: true),
            PainterContainer(isFill: false),
          ],
        ),
      ),
    );
  }
}
