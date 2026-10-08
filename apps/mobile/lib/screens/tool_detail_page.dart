import 'package:flutter/material.dart';
import 'package:pdf_pro/screens/tools/compress_screen.dart';
import 'package:pdf_pro/screens/tools/merge_screen.dart';
import 'package:pdf_pro/screens/tools/split_screen.dart';
import 'package:pdf_pro/screens/tools/rotate_screen.dart';
import 'package:pdf_pro/screens/tools/image_to_pdf_screen.dart';
import 'package:pdf_pro/screens/tools/txt_to_pdf_screen.dart';
import 'package:pdf_pro/screens/tools/watermark_screen.dart';
import 'package:pdf_pro/screens/tools/protect_screen.dart';
import '../data/tools.dart';
import '../models/pdf_tool.dart';

class ToolDetailPage extends StatelessWidget {
  final PdfTool tool;

  const ToolDetailPage({required this.tool, super.key});

  @override
  Widget build(BuildContext context) {
    final accent = Color(tool.accentColor);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
              ),
              // Hero gradient card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      colors: [
                        accent,
                        accent.withOpacity(0.4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: accent.withOpacity(0.3),
                        blurRadius: 28,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          _getIconData(tool.icon),
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        tool.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tool.subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              // Description section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About this tool',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      tool.description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        height: 1.7,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              // Benefits section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key features',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...tool.highlights.map((highlight) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.check,
                              size: 16,
                              color: accent,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              highlight,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.85),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Action button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: () => _navigateToTool(context, tool.id),
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Open tool'),
                    style: FilledButton.styleFrom(
                      backgroundColor: accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String icon) {
    final iconMap = {
      'compress': Icons.compress,
      'image': Icons.image,
      'photo': Icons.photo_camera,
      'text': Icons.text_snippet,
      'image_export': Icons.image_aspect_ratio,
      'merge': Icons.merge_type,
      'cut': Icons.cut,
      'rotate': Icons.rotate_90_degrees_ccw,
      'delete': Icons.delete_forever,
      'copy': Icons.copy_all,
      'watermark': Icons.format_color_text,
      'numbers': Icons.format_list_numbered,
      'shield': Icons.shield,
    };
    return iconMap[icon] ?? Icons.insert_drive_file;
  }

  void _navigateToTool(BuildContext context, String toolId) {
    switch (toolId) {
      case 'compress':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CompressScreen()));
        break;
      case 'merge':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const MergeScreen()));
        break;
      case 'split':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SplitScreen()));
        break;
      case 'rotate':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const RotateScreen()));
        break;
      case 'image-to-pdf':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ImageToPdfScreen()));
        break;
      case 'txt-to-pdf':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TxtToPdfScreen()));
        break;
      case 'watermark':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const WatermarkScreen()));
        break;
      case 'protect':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ProtectScreen()));
        break;
    }
  }
}
