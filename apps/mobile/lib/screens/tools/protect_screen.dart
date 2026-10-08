import 'package:flutter/material.dart';

class ProtectScreen extends StatelessWidget {
  const ProtectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Protect PDF')),
      body: const Center(child: Text('Protect PDF Tool')),
    );
  }
}
