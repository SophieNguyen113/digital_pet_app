import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DigitalPetTabs(),
    );
  }
}

class DigitalPetTabs extends StatefulWidget {
  const DigitalPetTabs({super.key});

  @override
  State<DigitalPetTabs> createState() => _DigitalPetTabsState();
}

class _DigitalPetTabsState extends State<DigitalPetTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int happiness = 50;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _play() => setState(() => happiness = (happiness + 10).clamp(0, 100));
  void _feed() => setState(() => happiness = (happiness + 5).clamp(0, 100));
  void _rest() => setState(() => happiness = (happiness - 5).clamp(0, 100));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Pet'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.pets), text: 'Play'),
            Tab(icon: Icon(Icons.fastfood), text: 'Feed'),
            Tab(icon: Icon(Icons.bedtime), text: 'Rest'),
            Tab(icon: Icon(Icons.info), text: 'Status'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: ElevatedButton(onPressed: _play, child: const Text('Play with Pet'))),
          Center(child: ElevatedButton(onPressed: _feed, child: const Text('Feed Pet'))),
          Center(child: ElevatedButton(onPressed: _rest, child: const Text('Let Pet Rest'))),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.pets, size: 80, color: Colors.teal),
                Text('Happiness: $happiness%'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.teal,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home, color: Colors.white),
              Icon(Icons.settings, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
