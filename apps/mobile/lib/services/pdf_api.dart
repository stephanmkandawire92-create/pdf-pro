import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class PdfApiClient {
  PdfApiClient({this.baseUrl = 'http://localhost:8080/api/pdf'});

  final String baseUrl;

  Future<http.StreamedResponse> uploadMultipart(
    String endpoint,
    List<File> files, {
    Map<String, String> fields = const {},
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final request = http.MultipartRequest('POST', uri);

    for (final entry in fields.entries) {
      request.fields[entry.key] = entry.value;
    }

    for (final file in files) {
      request.files.add(
        await http.MultipartFile.fromPath('files', file.path, filename: file.uri.pathSegments.last),
      );
    }

    return request.send();
  }

  Future<List<int>> downloadBinary(String endpoint, {Map<String, String> fields = const {}}) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(fields),
    );

    if (response.statusCode != 200) {
      throw Exception('Request failed: ${response.statusCode}');
    }

    return response.bodyBytes;
  }
}
