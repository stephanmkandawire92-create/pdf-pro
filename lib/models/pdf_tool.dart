import 'package:flutter/material.dart';

class PdfTool {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final Color accentColor;
  final List<String> highlights;
  final String description;

  const PdfTool({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.accentColor,
    required this.highlights,
    required this.description,
  });
}
