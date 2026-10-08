package com.pdfpro.api.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.pdfbox.Loader;
import org.apache.pdfbox.cos.COSName;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.encryption.AccessPermission;
import org.apache.pdfbox.pdmodel.encryption.StandardProtectionPolicy;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.text.PDFTextStripper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Service
public class PdfService {

    private static final Log logger = LogFactory.getLog(PdfService.class);

    public byte[] merge(List<MultipartFile> files) throws IOException {
        if (files == null || files.isEmpty()) {
            throw new IllegalArgumentException("At least one PDF is required");
        }

        PDFMergerUtility merger = new PDFMergerUtility();
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        for (MultipartFile file : files) {
            if (!file.getOriginalFilename().toLowerCase().endsWith(".pdf")) {
                throw new IllegalArgumentException("Only PDF files are allowed");
            }
            try (InputStream inputStream = file.getInputStream()) {
                merger.addSource(inputStream);
            }
        }

        merger.setDestinationStream(outputStream);
        merger.mergeDocuments(null);
        return outputStream.toByteArray();
    }

    public byte[] split(MultipartFile file, int startPage, int endPage) throws IOException {
        try (PDDocument source = Loader.loadPDF(file.getBytes())) {
            int totalPages = source.getNumberOfPages();
            int start = Math.max(1, startPage);
            int end = Math.min(totalPages, endPage);
            if (start > end) {
                throw new IllegalArgumentException("Start page cannot be greater than end page");
            }

            try (PDDocument destination = new PDDocument()) {
                for (int i = start - 1; i < end; i++) {
                    destination.addPage(source.getPage(i));
                }
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                destination.save(out);
                return out.toByteArray();
            }
        }
    }

    public byte[] rotate(MultipartFile file, int degrees) throws IOException {
        try (PDDocument document = Loader.loadPDF(file.getBytes())) {
            for (int i = 0; i < document.getNumberOfPages(); i++) {
                document.getPage(i).setRotation(degrees);
            }
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            document.save(out);
            return out.toByteArray();
        }
    }

    public byte[] deletePages(MultipartFile file, List<Integer> pageNumbers) throws IOException {
        try (PDDocument source = Loader.loadPDF(file.getBytes())) {
            List<Integer> pagesToRemove = normalizePageNumbers(pageNumbers, source.getNumberOfPages());
            try (PDDocument destination = new PDDocument()) {
                for (int i = 0; i < source.getNumberOfPages(); i++) {
                    if (!pagesToRemove.contains(i + 1)) {
                        destination.addPage(source.getPage(i));
                    }
                }
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                destination.save(out);
                return out.toByteArray();
            }
        }
    }

    public byte[] extractPages(MultipartFile file, List<Integer> pageNumbers) throws IOException {
        try (PDDocument source = Loader.loadPDF(file.getBytes())) {
            List<Integer> selectedPages = normalizePageNumbers(pageNumbers, source.getNumberOfPages());
            try (PDDocument destination = new PDDocument()) {
                for (int pageNumber : selectedPages) {
                    destination.addPage(source.getPage(pageNumber - 1));
                }
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                destination.save(out);
                return out.toByteArray();
            }
        }
    }

    public byte[] addWatermark(MultipartFile file, String text) throws IOException {
        try (PDDocument document = Loader.loadPDF(file.getBytes())) {
            for (int i = 0; i < document.getNumberOfPages(); i++) {
                PDPage page = document.getPage(i);
                PDRectangle rectangle = page.getMediaBox();

                try (PDPageContentStream contentStream = new PDPageContentStream(document, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
                    contentStream.saveGraphicsState();
                    contentStream.setNonStrokingColor(Color.LIGHT_GRAY);
                    contentStream.setFont(PDType1Font.HELVETICA_BOLD, 38);
                    contentStream.beginText();
                    double centerX = rectangle.getWidth() / 2;
                    double centerY = rectangle.getHeight() / 2;
                    contentStream.setTextMatrix(new AffineTransform(1, 0, 0, 1, centerX, centerY).getMatrix());
                    contentStream.showText(text);
                    contentStream.endText();
                    contentStream.restoreGraphicsState();
                }
            }

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            document.save(out);
            return out.toByteArray();
        }
    }

    public byte[] numberPages(MultipartFile file, String prefix) throws IOException {
        try (PDDocument document = Loader.loadPDF(file.getBytes())) {
            for (int i = 0; i < document.getNumberOfPages(); i++) {
                PDPage page = document.getPage(i);
                PDRectangle rectangle = page.getMediaBox();

                try (PDPageContentStream contentStream = new PDPageContentStream(document, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
                    contentStream.beginText();
                    contentStream.setFont(PDType1Font.HELVETICA_BOLD, 12);
                    contentStream.setNonStrokingColor(Color.DARK_GRAY);
                    contentStream.newLineAtOffset(rectangle.getWidth() - 80, 20);
                    contentStream.showText((prefix == null || prefix.isBlank() ? "Page " : prefix) + (i + 1));
                    contentStream.endText();
                }
            }

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            document.save(out);
            return out.toByteArray();
        }
    }

    public byte[] compress(MultipartFile file) throws IOException {
        try (PDDocument document = Loader.loadPDF(file.getBytes())) {
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            document.save(outputStream);
            return outputStream.toByteArray();
        }
    }

    public byte[] protect(MultipartFile file, String password) throws IOException {
        if (password == null || password.isBlank()) {
            throw new IllegalArgumentException("Password is required");
        }

        try (PDDocument document = Loader.loadPDF(file.getBytes())) {
            AccessPermission accessPermission = new AccessPermission();
            StandardProtectionPolicy policy = new StandardProtectionPolicy(password, password, accessPermission);
            policy.setEncryptionKeyLength(128);
            document.protect(policy);

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            document.save(out);
            return out.toByteArray();
        }
    }

    public byte[] imageToPdf(List<MultipartFile> files) throws IOException {
        try (PDDocument document = new PDDocument()) {
            for (MultipartFile file : files) {
                if (file == null || file.isEmpty()) {
                    continue;
                }
                byte[] data = file.getBytes();
                PDImageXObject image = PDImageXObject.createFromByteArray(document, data, file.getOriginalFilename());
                PDPage page = new PDPage(new org.apache.pdfbox.pdmodel.common.PDRectangle(image.getWidth(), image.getHeight()));
                document.addPage(page);

                try (PDPageContentStream contentStream = new PDPageContentStream(document, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
                    contentStream.drawImage(image, 0, 0, image.getWidth(), image.getHeight());
                }
            }

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            document.save(out);
            return out.toByteArray();
        }
    }

    public byte[] textToPdf(MultipartFile file) throws IOException {
        String text = new String(file.getBytes(), java.nio.charset.StandardCharsets.UTF_8);
        try (PDDocument document = new PDDocument()) {
            PDPage page = new PDPage();
            document.addPage(page);

            try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                contentStream.beginText();
                contentStream.setFont(PDType1Font.HELVETICA, 12);
                contentStream.newLineAtOffset(50, 700);
                String[] lines = text.split("\\r?\\n");
                for (String line : lines) {
                    contentStream.showText(line);
                    contentStream.newLineAtOffset(0, -18);
                }
                contentStream.endText();
            }

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            document.save(out);
            return out.toByteArray();
        }
    }

    public byte[] pdfToImage(MultipartFile file) throws IOException {
        try (PDDocument document = Loader.loadPDF(file.getBytes())) {
            PDFRenderer renderer = new PDFRenderer(document);
            ByteArrayOutputStream zipBuffer = new ByteArrayOutputStream();
            try (ZipOutputStream zipOut = new ZipOutputStream(zipBuffer)) {
                for (int pageIndex = 0; pageIndex < document.getNumberOfPages(); pageIndex++) {
                    BufferedImage image = renderer.renderImageWithDPI(pageIndex, 180);
                    ByteArrayOutputStream imageOut = new ByteArrayOutputStream();
                    ImageIO.write(image, "png", imageOut);

                    zipOut.putNextEntry(new ZipEntry("page-" + (pageIndex + 1) + ".png"));
                    zipOut.write(imageOut.toByteArray());
                    zipOut.closeEntry();
                }
            }
            return zipBuffer.toByteArray();
        }
    }

    private List<Integer> normalizePageNumbers(List<Integer> pageNumbers, int totalPages) {
        List<Integer> normalized = new ArrayList<>();
        for (Integer value : pageNumbers) {
            if (value == null || value < 1 || value > totalPages) {
                continue;
            }
            normalized.add(value);
        }
        if (normalized.isEmpty()) {
            throw new IllegalArgumentException("At least one valid page number is required");
        }
        return normalized;
    }
}
