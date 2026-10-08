package com.pdfpro.api.controller;

import com.pdfpro.api.service.PdfService;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/pdf")
@CrossOrigin(origins = "*")
public class PdfController {

    private final PdfService pdfService;

    public PdfController(PdfService pdfService) {
        this.pdfService = pdfService;
    }

    @PostMapping(value = "/merge", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> merge(@RequestParam("files") List<MultipartFile> files) throws IOException {
        return ResponseEntity.ok().body(pdfService.merge(files));
    }

    @PostMapping(value = "/split", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> split(
            @RequestParam("file") MultipartFile file,
            @RequestParam("startPage") int startPage,
            @RequestParam("endPage") int endPage) throws IOException {
        return ResponseEntity.ok().body(pdfService.split(file, startPage, endPage));
    }

    @PostMapping(value = "/rotate", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> rotate(
            @RequestParam("file") MultipartFile file,
            @RequestParam("degrees") int degrees) throws IOException {
        return ResponseEntity.ok().body(pdfService.rotate(file, degrees));
    }

    @PostMapping(value = "/delete-pages", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> deletePages(
            @RequestParam("file") MultipartFile file,
            @RequestParam("pageNumbers") List<Integer> pageNumbers) throws IOException {
        return ResponseEntity.ok().body(pdfService.deletePages(file, pageNumbers));
    }

    @PostMapping(value = "/extract-pages", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> extractPages(
            @RequestParam("file") MultipartFile file,
            @RequestParam("pageNumbers") List<Integer> pageNumbers) throws IOException {
        return ResponseEntity.ok().body(pdfService.extractPages(file, pageNumbers));
    }

    @PostMapping(value = "/watermark", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> watermark(
            @RequestParam("file") MultipartFile file,
            @RequestParam("text") String text) throws IOException {
        return ResponseEntity.ok().body(pdfService.addWatermark(file, text));
    }

    @PostMapping(value = "/number-pages", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> numberPages(
            @RequestParam("file") MultipartFile file,
            @RequestParam("prefix") String prefix) throws IOException {
        return ResponseEntity.ok().body(pdfService.numberPages(file, prefix));
    }

    @PostMapping(value = "/compress", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> compress(@RequestParam("file") MultipartFile file) throws IOException {
        return ResponseEntity.ok().body(pdfService.compress(file));
    }

    @PostMapping(value = "/protect", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> protect(
            @RequestParam("file") MultipartFile file,
            @RequestParam("password") String password) throws IOException {
        return ResponseEntity.ok().body(pdfService.protect(file, password));
    }

    @PostMapping(value = "/image-to-pdf", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> imageToPdf(@RequestParam("files") List<MultipartFile> files) throws IOException {
        return ResponseEntity.ok().body(pdfService.imageToPdf(files));
    }

    @PostMapping(value = "/txt-to-pdf", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<byte[]> txtToPdf(@RequestParam("file") MultipartFile file) throws IOException {
        return ResponseEntity.ok().body(pdfService.textToPdf(file));
    }

    @PostMapping(value = "/pdf-to-image", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    public ResponseEntity<byte[]> pdfToImage(@RequestParam("file") MultipartFile file) throws IOException {
        return ResponseEntity.ok().body(pdfService.pdfToImage(file));
    }

    @ExceptionHandler(FileUploadException.class)
    public ResponseEntity<String> handleUploadError(FileUploadException ex) {
        return ResponseEntity.badRequest().body("Upload failed: " + ex.getMessage());
    }
}
