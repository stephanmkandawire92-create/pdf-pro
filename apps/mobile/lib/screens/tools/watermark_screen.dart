import 'package:flutter/material.dart';

class WatermarkScreen extends StatelessWidget {
  const WatermarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watermark PDF')),
      body: const Center(child: Text('Watermark PDF Tool')),
    );
  }
}
