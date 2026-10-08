import 'package:flutter/material.dart';

class RotateScreen extends StatelessWidget {
  const RotateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rotate PDF')),
      body: const Center(child: Text('Rotate PDF Tool')),
    );
  }
}
