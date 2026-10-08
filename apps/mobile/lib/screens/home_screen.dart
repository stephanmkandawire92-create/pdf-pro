import 'package:flutter/material.dart';
import '../models/pdf_tool.dart';
import '../data/tools.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PDF Pro',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Pro'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5B7CFF), Color(0xFF7C4DFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Professional PDF workspace'),
                    const SizedBox(height: 10),
                    Text(
                      'Convert, compress, secure, organize, and optimize documents in one place.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        _Badge('18 tools'),
                        _Badge('Real backend'),
                        _Badge('Secure'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Workspace tools',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: GridView.builder(
                  itemCount: pdfTools.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.88,
                  ),
                  itemBuilder: (context, index) {
                    final tool = pdfTools[index];
                    return ToolCard(tool: tool);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  const _Badge(this.text,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text),
    );
  }
}

class ToolCard extends StatelessWidget {
  final PdfTool tool;

  const ToolCard({required this.tool, super.key});

  @override
  Widget build(BuildContext context) {
    final accent = Color(tool.accent);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ToolDetailScreen(tool: tool),
          ),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF101B2B),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    _iconData(tool.icon),
                    color: accent,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF09B36A).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Live',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 14),
            Text(
              tool.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tool.subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const Spacer(),
            Text(
              tool.category,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconData(String key) {
    switch (key) {
      case 'compress': return Icons.compress;
      case 'image': return Icons.image;
      case 'photo': return Icons.photo_camera;
      case 'text': return Icons.text_snippet;
      case 'image_export': return Icons.image_aspect_ratio;
      case 'merge': return Icons.merge_type;
      case 'cut': return Icons.cut;
      case 'rotate': return Icons.rotate_90_degrees_ccw;
      case 'delete': return Icons.delete_forever;
      case 'copy': return Icons.copy_all;
      case 'watermark': return Icons.format_color_text;
      case 'numbers': return Icons.format_list_numbered;
      case 'shield': return Icons.shield;
      default: return Icons.insert_drive_file;
    }
  }
}

class ToolDetailScreen extends StatelessWidget {
  final PdfTool tool;

  const ToolDetailScreen({required this.tool, super.key});

  @override
  Widget build(BuildContext context) {
    final accent = Color(tool.accent);

    return Scaffold(
      appBar: AppBar(title: Text(tool.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [accent, accent.withOpacity(0.5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(_iconData(tool.icon), size: 42),
                  const SizedBox(height: 20),
                  Text(
                    tool.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(tool.subtitle),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              tool.description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.82),
                height: 1.7,
              ),
            ),
            const SizedBox(height: 18),
            const Text('Benefits'),
            const SizedBox(height: 10),
            ...tool.highlights.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, color: accent, size: 18),
                  const SizedBox(width: 10),
                  Expanded(child: Text(item)),
                ],
              ),
            )),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Run tool'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconData(String key) {
    switch (key) {
      case 'compress': return Icons.compress;
      case 'image': return Icons.image;
      case 'photo': return Icons.photo_camera;
      case 'text': return Icons.text_snippet;
      case 'image_export': return Icons.image_aspect_ratio;
      case 'merge': return Icons.merge_type;
      case 'cut': return Icons.cut;
      case 'rotate': return Icons.rotate_90_degrees_ccw;
      case 'delete': return Icons.delete_forever;
      case 'copy': return Icons.copy_all;
      case 'watermark': return Icons.format_color_text;
      case 'numbers': return Icons.format_list_numbered;
      case 'shield': return Icons.shield;
      default: return Icons.insert_drive_file;
    }
  }
}
