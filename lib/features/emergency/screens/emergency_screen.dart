import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency SOS')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Send SOS (placeholder)'),
        ),
      ),
    );
  }
}
