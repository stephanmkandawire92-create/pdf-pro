package com.pdfpro.api.controller;

import com.pdfpro.api.dto.ApiResponse;
import com.pdfpro.api.dto.PdfMetadata;
import com.pdfpro.api.util.FileValidator;
import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/api/info")
@CrossOrigin(origins = "*")
public class InfoController {

    @PostMapping("/metadata")
    public ResponseEntity<ApiResponse<PdfMetadata>> getMetadata(@RequestParam("file") MultipartFile file) {
        if (!FileValidator.isValidPdf(file)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Invalid PDF file"));
        }

        try {
            PDDocument document = Loader.loadPDF(file.getBytes());
            PdfMetadata metadata = new PdfMetadata(
                    document.getNumberOfPages(),
                    file.getSize(),
                    file.getOriginalFilename(),
                    document.isEncrypted()
            );
            document.close();
            return ResponseEntity.ok(ApiResponse.success(metadata));
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Failed to read PDF metadata: " + e.getMessage()));
        }
    }

    @GetMapping("/health")
    public ResponseEntity<ApiResponse<String>> health() {
        return ResponseEntity.ok(ApiResponse.success("PDF Pro API is running"));
    }
}
