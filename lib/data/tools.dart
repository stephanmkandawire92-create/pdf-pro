import 'package:flutter/material.dart';

import '../models/pdf_tool.dart';

const List<PdfTool> pdfTools = [
  PdfTool(
    id: 'compress',
    title: 'Compress PDF',
    subtitle: 'Reduce file size while keeping quality',
    category: 'Optimize',
    icon: Icons.compress,
    accentColor: Color(0xFF7C4DFF),
    highlights: ['Smart optimization', 'Quality preserved', 'Faster sharing'],
    description:
        'Shrink large PDF documents for email, cloud sharing, and faster uploads without sacrificing readability.',
  ),
  PdfTool(
    id: 'image-to-pdf',
    title: 'Image to PDF',
    subtitle: 'Convert PNG, JPG, WebP images to PDF',
    category: 'Convert',
    icon: Icons.image,
    accentColor: Color(0xFF3DDC97),
    highlights: ['Batch support', 'Auto page sizing', 'High-resolution export'],
    description:
        'Turn your photos and screenshots into a clean, organized PDF document ready for storage or sending.',
  ),
  PdfTool(
    id: 'jpg-to-pdf',
    title: 'JPG to PDF',
    subtitle: 'Convert JPEG photos to PDF',
    category: 'Convert',
    icon: Icons.photo_camera,
    accentColor: Color(0xFF00C2FF),
    highlights: ['Quick conversion', 'Simple workflow', 'Preview before save'],
    description:
        'Convert albums, receipts, and scanned photos into a single PDF in just a few taps.',
  ),
  PdfTool(
    id: 'txt-to-pdf',
    title: 'TXT to PDF',
    subtitle: 'Convert plain text files to PDF',
    category: 'Convert',
    icon: Icons.text_snippet,
    accentColor: Color(0xFFF9A826),
    highlights: ['Plain text support', 'Page layout ready', 'Professional export'],
    description:
        'Transform notes, reports, and text documents into polished PDFs with a great presentation.',
  ),
  PdfTool(
    id: 'pdf-to-image',
    title: 'PDF to Image',
    subtitle: 'Export every PDF page as an image',
    category: 'Export',
    icon: Icons.photo_library,
    accentColor: Color(0xFFEC407A),
    highlights: ['Page-by-page export', 'PNG output', 'Fast conversion'],
    description:
        'Extract all pages as image files for easier sharing, previews, or design workflows.',
  ),
  PdfTool(
    id: 'pdf-to-word',
    title: 'PDF to Word',
    subtitle: 'Extract content to DOCX',
    category: 'Convert',
    icon: Icons.description,
    accentColor: Color(0xFF00B8D9),
    highlights: ['DOCX output', 'Content extraction', 'Editable results'],
    description:
        'Convert document content into a Word file that can be edited and revised after extraction.',
  ),
  PdfTool(
    id: 'pdf-to-excel',
    title: 'PDF to Excel',
    subtitle: 'Extract tables to CSV',
    category: 'Convert',
    icon: Icons.table_chart,
    accentColor: Color(0xFF4CAF50),
    highlights: ['Table extraction', 'CSV ready', 'Better analytics'],
    description:
        'Capture tabular data from PDFs and export it to spreadsheet-friendly CSV files.',
  ),
  PdfTool(
    id: 'pdf-to-ppt',
    title: 'PDF to PPT',
    subtitle: 'Convert slides to PowerPoint',
    category: 'Convert',
    icon: Icons.slideshow,
    accentColor: Color(0xFFFF7043),
    highlights: ['Presentation-friendly', 'Slide layout', 'Editable deck'],
    description:
        'Transform PDF content into presentation-ready PowerPoint slides for business and education use.',
  ),
  PdfTool(
    id: 'word-to-pdf',
    title: 'Word to PDF',
    subtitle: 'DOCX to PDF',
    category: 'Convert',
    icon: Icons.file_present,
    accentColor: Color(0xFF42A5F5),
    highlights: ['DOCX support', 'Layout fidelity', 'Fast conversion'],
    description:
        'Convert editable Word documents into clean, professional PDF files while preserving formatting.',
  ),
  PdfTool(
    id: 'html-to-pdf',
    title: 'HTML to PDF',
    subtitle: 'HTML to PDF',
    category: 'Convert',
    icon: Icons.code,
    accentColor: Color(0xFF8E24AA),
    highlights: ['Web pages', 'Print-ready output', 'Brand-safe style'],
    description:
        'Create polished PDFs from web pages, HTML templates, and digital reports for sharing or archiving.',
  ),
  PdfTool(
    id: 'merge',
    title: 'Merge PDF',
    subtitle: 'Combine multiple PDFs into one',
    category: 'Organize',
    icon: Icons.merge_type,
    accentColor: Color(0xFF26A69A),
    highlights: ['Multi-file merge', 'Custom order', 'One final file'],
    description:
        'Combine several PDF documents into a single file in the exact order you want.',
  ),
  PdfTool(
    id: 'split',
    title: 'Split PDF',
    subtitle: 'Extract a page range into new PDF',
    category: 'Organize',
    icon: Icons.cut,
    accentColor: Color(0xFFAB47BC),
    highlights: ['Page ranges', 'Selective output', 'Simple workflow'],
    description:
        'Split large documents into smaller sections without losing quality or structure.',
  ),
  PdfTool(
    id: 'rotate',
    title: 'Rotate PDF',
    subtitle: 'Rotate all pages 90°, 180° or 270°',
    category: 'Organize',
    icon: Icons.rotate_90_degrees_ccw,
    accentColor: Color(0xFFFFA726),
    highlights: ['Orientation fixes', 'Batch rotation', 'Quick correction'],
    description:
        'Fix page orientation issues in just a few clicks, preserving document integrity.',
  ),
  PdfTool(
    id: 'delete-pages',
    title: 'Delete Pages',
    subtitle: 'Remove specific pages from a PDF',
    category: 'Edit',
    icon: Icons.delete_forever,
    accentColor: Color(0xFFE53935),
    highlights: ['Selective deletion', 'Clean output', 'Fast edit'],
    description:
        ' Remove unnecessary pages and export a cleaner, more focused document.',
  ),
  PdfTool(
    id: 'extract-pages',
    title: 'Extract Pages',
    subtitle: 'Pull specific pages into a new PDF',
    category: 'Organize',
    icon: Icons.file_copy,
    accentColor: Color(0xFF5C6BC0),
    highlights: ['Custom page selection', 'New output file', 'Easier sharing'],
    description:
        'Extract only the pages you need and build a smaller, more relevant file.',
  ),
  PdfTool(
    id: 'watermark',
    title: 'Watermark PDF',
    subtitle: 'Add diagonal text watermark to pages',
    category: 'Edit',
    icon: Icons.format_color_text,
    accentColor: Color(0xFF66BB6A),
    highlights: ['Text watermark', 'Branding', 'Page-level control'],
    description:
        'Add professional stamps or branding marks to your PDFs while keeping the content readable.',
  ),
  PdfTool(
    id: 'number-pages',
    title: 'Number Pages',
    subtitle: 'Stamp page numbers on every page',
    category: 'Edit',
    icon: Icons.format_list_numbered,
    accentColor: Color(0xFF29B6F6),
    highlights: ['Page numbering', 'Professional output', 'Document tracking'],
    description:
        'Add sequential page numbers to formal documents, proposals, and reports.',
  ),
  PdfTool(
    id: 'protect',
    title: 'Protect PDF',
    subtitle: 'Password protect and encrypt your documents',
    category: 'Security',
    icon: Icons.shield,
    accentColor: Color(0xFFFB8C00),
    highlights: ['Password protection', 'Secure sharing', 'Privacy-first'],
    description:
        'Safeguard confidential files with password protection and security controls designed for business use.',
  ),
];
