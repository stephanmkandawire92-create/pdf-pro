import 'package:flutter/material.dart';

class TxtToPdfScreen extends StatelessWidget {
  const TxtToPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text to PDF')),
      body: const Center(child: Text('Text to PDF Tool')),
    );
  }
}
