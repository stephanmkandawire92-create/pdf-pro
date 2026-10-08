class PdfTool {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String icon;
  final int accent;
  final String description;
  final List<String> highlights;

  const PdfTool({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.accent,
    required this.description,
    required this.highlights,
  });
}
