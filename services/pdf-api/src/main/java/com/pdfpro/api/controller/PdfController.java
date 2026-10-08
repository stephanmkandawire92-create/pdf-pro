package com.pdfpro.api.controller;

import com.pdfpro.api.dto.ApiResponse;
import com.pdfpro.api.service.PdfService;
import com.pdfpro.api.util.FileValidator;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping("/api/pdf")
@CrossOrigin(origins = "*")
public class PdfController {

    private final PdfService pdfService;

    public PdfController(PdfService pdfService) {
        this.pdfService = pdfService;
    }

    @PostMapping(value = "/merge", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> merge(@RequestParam("files") List<MultipartFile> files) {
        if (files == null || files.isEmpty()) {
            return ResponseEntity.badRequest().body(ApiResponse.error("At least one PDF is required"));
        }

        if (!files.stream().allMatch(FileValidator::isValidPdf)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("All files must be valid PDFs"));
        }

        try {
            byte[] result = pdfService.merge(files);
            return createFileResponse(result, "merged_" + getTimestamp() + ".pdf");
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Merge failed: " + e.getMessage()));
        }
    }

    @PostMapping(value = "/split", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> split(
            @RequestParam("file") MultipartFile file,
            @RequestParam("startPage") int startPage,
            @RequestParam("endPage") int endPage) {
        if (!FileValidator.isValidPdf(file)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Invalid PDF file"));
        }

        try {
            byte[] result = pdfService.split(file, startPage, endPage);
            return createFileResponse(result, "split_" + getTimestamp() + ".pdf");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Split failed: " + e.getMessage()));
        }
    }

    @PostMapping(value = "/rotate", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> rotate(
            @RequestParam("file") MultipartFile file,
            @RequestParam("degrees") int degrees) {
        if (!FileValidator.isValidPdf(file)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Invalid PDF file"));
        }

        try {
            byte[] result = pdfService.rotate(file, degrees);
            return createFileResponse(result, "rotated_" + getTimestamp() + ".pdf");
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Rotate failed: " + e.getMessage()));
        }
    }

    @PostMapping(value = "/delete-pages", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> deletePages(
            @RequestParam("file") MultipartFile file,
            @RequestParam("pageNumbers") List<Integer> pageNumbers) {
        if (!FileValidator.isValidPdf(file)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Invalid PDF file"));
        }

        try {
            byte[] result = pdfService.deletePages(file, pageNumbers);
            return createFileResponse(result, "pages_deleted_" + getTimestamp() + ".pdf");
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Delete pages failed: " + e.getMessage()));
        }
    }

    @PostMapping(value = "/extract-pages", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> extractPages(
            @RequestParam("file") MultipartFile file,
            @RequestParam("pageNumbers") List<Integer> pageNumbers) {
        if (!FileValidator.isValidPdf(file)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Invalid PDF file"));
        }

        try {
            byte[] result = pdfService.extractPages(file, pageNumbers);
            return createFileResponse(result, "extracted_" + getTimestamp() + ".pdf");
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Extract pages failed: " + e.getMessage()));
        }
    }

    @PostMapping(value = "/watermark", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> watermark(
            @RequestParam("file") MultipartFile file,
            @RequestParam("text") String text) {
        if (!FileValidator.isValidPdf(file)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Invalid PDF file"));
        }

        try {
            byte[] result = pdfService.addWatermark(file, text);
            return createFileResponse(result, "watermarked_" + getTimestamp() + ".pdf");
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Watermark failed: " + e.getMessage()));
        }
    }

    @PostMapping(value = "/number-pages", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> numberPages(
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "prefix", defaultValue = "Page ") String prefix) {
        if (!FileValidator.isValidPdf(file)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Invalid PDF file"));
        }

        try {
            byte[] result = pdfService.numberPages(file, prefix);
            return createFileResponse(result, "numbered_" + getTimestamp() + ".pdf");
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Number pages failed: " + e.getMessage()));
        }
    }

    @PostMapping(value = "/compress", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> compress(@RequestParam("file") MultipartFile file) {
        if (!FileValidator.isValidPdf(file)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Invalid PDF file"));
        }

        try {
            byte[] result = pdfService.compress(file);
            return createFileResponse(result, "compressed_" + getTimestamp() + ".pdf");
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Compress failed: " + e.getMessage()));
        }
    }

    @PostMapping(value = "/protect", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> protect(
            @RequestParam("file") MultipartFile file,
            @RequestParam("password") String password) {
        if (!FileValidator.isValidPdf(file)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Invalid PDF file"));
        }

        try {
            byte[] result = pdfService.protect(file, password);
            return createFileResponse(result, "protected_" + getTimestamp() + ".pdf");
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Protect failed: " + e.getMessage()));
        }
    }

    @PostMapping(value = "/image-to-pdf", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> imageToPdf(@RequestParam("files") List<MultipartFile> files) {
        if (files == null || files.isEmpty()) {
            return ResponseEntity.badRequest().body(ApiResponse.error("At least one image is required"));
        }

        if (!FileValidator.isValidImages(files)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("All files must be valid images (PNG, JPG, WebP)"));
        }

        try {
            byte[] result = pdfService.imageToPdf(files);
            return createFileResponse(result, "from_images_" + getTimestamp() + ".pdf");
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Image to PDF failed: " + e.getMessage()));
        }
    }

    @PostMapping(value = "/txt-to-pdf", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> txtToPdf(@RequestParam("file") MultipartFile file) {
        if (!FileValidator.isValidText(file)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Invalid text file"));
        }

        try {
            byte[] result = pdfService.textToPdf(file);
            return createFileResponse(result, "from_text_" + getTimestamp() + ".pdf");
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("Text to PDF failed: " + e.getMessage()));
        }
    }

    @PostMapping(value = "/pdf-to-image", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> pdfToImage(@RequestParam("file") MultipartFile file) {
        if (!FileValidator.isValidPdf(file)) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Invalid PDF file"));
        }

        try {
            byte[] result = pdfService.pdfToImage(file);
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"pdf_to_images.zip\"")
                    .body(result);
        } catch (IOException e) {
            return ResponseEntity.internalServerError()
                    .body(ApiResponse.error("PDF to image failed: " + e.getMessage()));
        }
    }

    private ResponseEntity<byte[]> createFileResponse(byte[] fileBytes, String filename) {
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_PDF)
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
                .body(fileBytes);
    }

    private String getTimestamp() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
    }
}
