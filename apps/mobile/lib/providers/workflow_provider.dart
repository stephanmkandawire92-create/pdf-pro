import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf_pro/services/file_picker_service.dart';
import 'package:pdf_pro/services/pdf_api_service.dart';
import 'package:permission_handler/permission_handler.dart';

class WorkflowProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  File? _selectedFile;
  List<File>? _selectedFiles;
  Map<String, dynamic>? _pdfMetadata;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  File? get selectedFile => _selectedFile;
  List<File>? get selectedFiles => _selectedFiles;
  Map<String, dynamic>? get pdfMetadata => _pdfMetadata;

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  Future<bool> requestPermissions() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> loadPdfFile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final file = await FilePickerService.pickPdfFile();
      if (file != null) {
        _selectedFile = file;
        await fetchPdfMetadata(file);
        _successMessage = 'PDF loaded successfully';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMultiplePdfs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final files = await FilePickerService.pickMultiplePdfs();
      if (files.isNotEmpty) {
        _selectedFiles = files;
        _successMessage = '${files.length} PDFs loaded successfully';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadImages() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final files = await FilePickerService.pickImageFiles();
      if (files.isNotEmpty) {
        _selectedFiles = files;
        _successMessage = '${files.length} images loaded successfully';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadTextFile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final file = await FilePickerService.pickTextFile();
      if (file != null) {
        _selectedFile = file;
        _successMessage = 'Text file loaded successfully';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPdfMetadata(File file) async {
    try {
      _pdfMetadata = await PdfApiService.getPdfMetadata(file);
    } catch (e) {
      _errorMessage = 'Failed to load metadata: $e';
    }
    notifyListeners();
  }

  Future<void> mergePdfs() async {
    if (_selectedFiles == null || _selectedFiles!.isEmpty) {
      _errorMessage = 'Please select PDF files to merge';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await PdfApiService.mergePdfs(_selectedFiles!);
      final filename = 'merged_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await FilePickerService.saveFile(result, filename);
      _successMessage = 'PDF merged successfully: $filename';
      _selectedFiles = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> compressPdf() async {
    if (_selectedFile == null) {
      _errorMessage = 'Please select a PDF to compress';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await PdfApiService.compressPdf(_selectedFile!);
      final filename = 'compressed_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await FilePickerService.saveFile(result, filename);
      _successMessage = 'PDF compressed successfully: $filename';
      _selectedFile = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> rotatePdf(int degrees) async {
    if (_selectedFile == null) {
      _errorMessage = 'Please select a PDF to rotate';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await PdfApiService.rotatePdf(_selectedFile!, degrees);
      final filename = 'rotated_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await FilePickerService.saveFile(result, filename);
      _successMessage = 'PDF rotated successfully: $filename';
      _selectedFile = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> imagesToPdf() async {
    if (_selectedFiles == null || _selectedFiles!.isEmpty) {
      _errorMessage = 'Please select images to convert';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await PdfApiService.imagesToPdf(_selectedFiles!);
      final filename = 'from_images_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await FilePickerService.saveFile(result, filename);
      _successMessage = 'PDF created from images: $filename';
      _selectedFiles = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> textToPdf() async {
    if (_selectedFile == null) {
      _errorMessage = 'Please select a text file to convert';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await PdfApiService.textToPdf(_selectedFile!);
      final filename = 'from_text_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await FilePickerService.saveFile(result, filename);
      _successMessage = 'PDF created from text: $filename';
      _selectedFile = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
