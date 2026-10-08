import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PdfApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  /// Check API health
  static Future<bool> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/info/health'),
      ).timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Get PDF metadata
  static Future<Map<String, dynamic>> getPdfMetadata(File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/info/metadata'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      
      if (response.statusCode == 200) {
        final json = jsonDecode(responseBody);
        return json['data'] ?? {};
      } else {
        throw Exception(jsonDecode(responseBody)['message'] ?? 'Failed to get metadata');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Merge multiple PDFs
  static Future<Uint8List> mergePdfs(List<File> files) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/merge'),
      );
      
      for (var file in files) {
        request.files.add(await http.MultipartFile.fromPath('files', file.path));
      }

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'Merge failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Split PDF by page range
  static Future<Uint8List> splitPdf(File file, int startPage, int endPage) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/split'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.fields['startPage'] = startPage.toString();
      request.fields['endPage'] = endPage.toString();

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'Split failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Rotate PDF pages
  static Future<Uint8List> rotatePdf(File file, int degrees) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/rotate'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.fields['degrees'] = degrees.toString();

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'Rotate failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Delete specific pages from PDF
  static Future<Uint8List> deletePages(File file, List<int> pageNumbers) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/delete-pages'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      for (var page in pageNumbers) {
        request.fields.addAll({'pageNumbers': page.toString()});
      }

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'Delete pages failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Extract specific pages from PDF
  static Future<Uint8List> extractPages(File file, List<int> pageNumbers) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/extract-pages'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      for (var page in pageNumbers) {
        request.fields.addAll({'pageNumbers': page.toString()});
      }

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'Extract pages failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Add watermark to PDF
  static Future<Uint8List> addWatermark(File file, String text) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/watermark'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.fields['text'] = text;

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'Watermark failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Number pages in PDF
  static Future<Uint8List> numberPages(File file, {String prefix = 'Page '}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/number-pages'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.fields['prefix'] = prefix;

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'Number pages failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Compress PDF
  static Future<Uint8List> compressPdf(File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/compress'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'Compress failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Protect PDF with password
  static Future<Uint8List> protectPdf(File file, String password) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/protect'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.fields['password'] = password;

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'Protect failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Convert images to PDF
  static Future<Uint8List> imagesToPdf(List<File> files) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/image-to-pdf'),
      );
      
      for (var file in files) {
        request.files.add(await http.MultipartFile.fromPath('files', file.path));
      }

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'Image to PDF failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Convert text file to PDF
  static Future<Uint8List> textToPdf(File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/txt-to-pdf'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'Text to PDF failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Convert PDF to images (returns ZIP)
  static Future<Uint8List> pdfToImages(File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/pdf/pdf-to-image'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();
      
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        final body = await response.stream.bytesToString();
        throw Exception(jsonDecode(body)['message'] ?? 'PDF to image failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
