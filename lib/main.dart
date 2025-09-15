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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('Digital Pet'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.pets, color: Colors.white), text: 'Play'),
            Tab(icon: Icon(Icons.fastfood, color: Colors.white), text: 'Feed'),
            Tab(icon: Icon(Icons.bedtime, color: Colors.white), text: 'Rest'),
            Tab(icon: Icon(Icons.info, color: Colors.white), text: 'Status'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActionTab('Play with Pet', Colors.orange.shade200, _play),
          _buildActionTab('Feed Pet', Colors.green.shade200, _feed),
          _buildActionTab('Let Pet Rest', Colors.blue.shade200, _rest),
          _buildStatusTab(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal.shade700,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.home, color: Colors.white),
              Icon(Icons.settings, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTab(String text, Color color, VoidCallback onPressed) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  Widget _buildStatusTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.pets, size: 90, color: Colors.teal),
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              value: happiness / 100,
              backgroundColor: Colors.grey.shade300,
              color: Colors.teal,
              strokeWidth: 8,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Happiness: $happiness%',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
