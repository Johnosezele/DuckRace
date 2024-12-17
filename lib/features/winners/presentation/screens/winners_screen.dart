import 'package:flutter/material.dart';

class WinnersScreen extends StatelessWidget {
  const WinnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Winners'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10, // Example count, replace with actual winners data
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('#${index + 1}'),
              ),
              title: Text('Winner ${index + 1}'),
              subtitle: Text('Prize: Duck Race Trophy ${index + 1}'),
              trailing: const Icon(Icons.emoji_events),
            ),
          );
        },
      ),
    );
  }
}
