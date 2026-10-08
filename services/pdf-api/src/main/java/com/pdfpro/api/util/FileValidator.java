package com.pdfpro.api.util;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public class FileValidator {

    private static final List<String> ALLOWED_PDF_TYPES = List.of(
            "application/pdf",
            "application/x-pdf"
    );

    private static final List<String> ALLOWED_IMAGE_TYPES = List.of(
            "image/jpeg",
            "image/png",
            "image/webp"
    );

    private static final List<String> ALLOWED_TEXT_TYPES = List.of(
            "text/plain",
            "application/octet-stream"
    );

    public static boolean isValidPdf(MultipartFile file) {
        return file != null && !file.isEmpty() &&
               (ALLOWED_PDF_TYPES.contains(file.getContentType()) ||
                file.getOriginalFilename().endsWith(".pdf"));
    }

    public static boolean isValidImage(MultipartFile file) {
        return file != null && !file.isEmpty() &&
               ALLOWED_IMAGE_TYPES.contains(file.getContentType());
    }

    public static boolean isValidText(MultipartFile file) {
        return file != null && !file.isEmpty() &&
               file.getOriginalFilename().endsWith(".txt");
    }

    public static boolean isValidImages(List<MultipartFile> files) {
        return files != null && !files.isEmpty() &&
               files.stream().allMatch(FileValidator::isValidImage);
    }
}
