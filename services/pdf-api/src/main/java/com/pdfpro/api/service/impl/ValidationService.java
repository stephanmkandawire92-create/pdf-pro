package com.pdfpro.api.service.impl;

import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public class ValidationService {

    public static boolean isValidPdfDocument(MultipartFile file) {
        try {
            PDDocument.load(file.getInputStream()).close();
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    public static int getPageCount(MultipartFile file) throws IOException {
        try (PDDocument document = Loader.loadPDF(file.getBytes())) {
            return document.getNumberOfPages();
        }
    }
}
