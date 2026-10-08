# PDF Pro API

A Spring Boot REST API powered by Apache PDFBox for professional PDF processing.

## Features

- Merge PDFs
- Split PDFs
- Rotate pages
- Delete specific pages
- Extract page ranges
- Add watermarks
- Number pages
- Compress PDFs
- Protect PDFs with passwords
- Convert images to PDF
- Convert text to PDF
- Export PDF pages as images

## Prerequisites

- Java 17+
- Maven 3.8+
- Apache PDFBox 3.0.2

## Build and Run

```bash
# Navigate to the API directory
cd services/pdf-api

# Build the project
mvn clean install

# Run the application
mvn spring-boot:run
```

The API will start on `http://localhost:8080`

## API Endpoints

### Health Check

```bash
GET /api/info/health
```

### PDF Metadata

```bash
POST /api/info/metadata
Content-Type: multipart/form-data

- file: PDF file
```

Response:
```json
{
  "status": "success",
  "data": {
    "pageCount": 10,
    "fileSizeBytes": 102400,
    "fileName": "document.pdf",
    "isEncrypted": false
  }
}
```

### Merge PDFs

```bash
POST /api/pdf/merge
Content-Type: multipart/form-data

- files: Multiple PDF files
```

### Split PDF

```bash
POST /api/pdf/split
Content-Type: multipart/form-data

- file: PDF file
- startPage: Page number to start (1-indexed)
- endPage: Page number to end (inclusive)
```

### Rotate PDF

```bash
POST /api/pdf/rotate
Content-Type: multipart/form-data

- file: PDF file
- degrees: 90, 180, or 270
```

### Delete Pages

```bash
POST /api/pdf/delete-pages
Content-Type: multipart/form-data

- file: PDF file
- pageNumbers: Comma-separated list of page numbers to delete
```

### Extract Pages

```bash
POST /api/pdf/extract-pages
Content-Type: multipart/form-data

- file: PDF file
- pageNumbers: Comma-separated list of page numbers to extract
```

### Add Watermark

```bash
POST /api/pdf/watermark
Content-Type: multipart/form-data

- file: PDF file
- text: Watermark text
```

### Number Pages

```bash
POST /api/pdf/number-pages
Content-Type: multipart/form-data

- file: PDF file
- prefix: (optional) Text prefix for page numbers (default: "Page ")
```

### Compress PDF

```bash
POST /api/pdf/compress
Content-Type: multipart/form-data

- file: PDF file
```

### Protect PDF

```bash
POST /api/pdf/protect
Content-Type: multipart/form-data

- file: PDF file
- password: Password to protect the PDF
```

### Image to PDF

```bash
POST /api/pdf/image-to-pdf
Content-Type: multipart/form-data

- files: Multiple image files (PNG, JPG, WebP)
```

### Text to PDF

```bash
POST /api/pdf/txt-to-pdf
Content-Type: multipart/form-data

- file: Text file (.txt)
```

### PDF to Image

```bash
POST /api/pdf/pdf-to-image
Content-Type: multipart/form-data

- file: PDF file
```

Response: ZIP file containing PNG images for each page

## Configuration

Edit `src/main/resources/application.properties`:

```properties
server.port=8080
spring.servlet.multipart.max-file-size=50MB
spring.servlet.multipart.max-request-size=100MB
```

## Error Handling

All endpoints return a consistent error response:

```json
{
  "status": "error",
  "message": "Error description",
  "timestamp": 1633024800000
}
```

## License

Apache 2.0
