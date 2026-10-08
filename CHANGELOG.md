version: 1.0.0+1

changes:
  - "Initial production architecture setup"
  - "Backend: Java Spring Boot + Apache PDFBox"
  - "Frontend: Flutter mobile app with API integration"
  - "Implemented core PDF operations"
  - "Added file validation and error handling"
  - "Connected mobile app to backend API"

features:
  - Merge PDF
  - Split PDF
  - Rotate PDF
  - Delete pages
  - Extract pages
  - Add watermark
  - Number pages
  - Compress PDF
  - Protect PDF
  - Image to PDF
  - Text to PDF
  - PDF to Image

backend:
  - Spring Boot 3.3.3
  - Apache PDFBox 3.0.2
  - CORS configured
  - Multipart file upload support (50MB limit)
  - Error handling and validation

mobile:
  - Flutter 3.3.0+
  - HTTP client for API communication
  - File picker integration
  - State management with Provider
  - File save functionality

architecture:
  - Monorepo structure
  - Separation of concerns
  - Real API integration
  - Production-ready code
