# PDF Pro - Production Architecture

A professional PDF toolkit built with a real backend and mobile frontend.

## Project Structure

```
pdf-pro/
├── apps/
│   └── mobile/                 # Flutter app (com.pdfpro.app)
│       ├── lib/
│       │   ├── services/       # API clients
│       │   ├── providers/      # State management
│       │   ├── screens/        # UI screens
│       │   └── models/         # Data models
│       └── pubspec.yaml        # Flutter dependencies
├── services/
│   └── pdf-api/               # Java backend
│       ├── src/main/
│       │   ├── java/
│       │   │   └── com/pdfpro/api/
│       │   │       ├── controller/  # REST endpoints
│       │   │       ├── service/     # Business logic
│       │   │       ├── dto/         # Data transfer objects
│       │   │       ├── exception/   # Error handling
│       │   │       └── util/        # Utilities
│       │   └── resources/
│       │       └── application.properties
│       └── pom.xml            # Maven dependencies
└── README.md
```

## Backend Setup (Java)

### Prerequisites
- Java 17+
- Maven 3.8+

### Run the Backend

```bash
cd services/pdf-api
mvn clean install
mvn spring-boot:run
```

The API will be available at `http://localhost:8080`

### Backend Features

✅ **PDF Operations** (using Apache PDFBox)
- Merge PDFs
- Split PDFs
- Rotate pages
- Delete/Extract pages
- Add watermarks
- Number pages
- Compress PDFs
- Protect with passwords
- Convert images to PDF
- Convert text to PDF
- Export PDF to images

✅ **API Features**
- CORS enabled for mobile app
- Multipart file upload (50MB limit)
- Comprehensive error handling
- Input validation
- Metadata extraction
- Health check endpoint

## Mobile Setup (Flutter)

### Prerequisites
- Flutter 3.3.0+
- Android SDK or iOS SDK

### Run the Mobile App

```bash
cd apps/mobile
flutter pub get
flutter run
```

### Mobile Features

✅ **File Management**
- PDF file picker
- Multiple file selection
- Image selection
- Text file selection

✅ **API Integration**
- Real-time connection to backend
- All PDF operations available
- File upload/download
- Progress tracking

✅ **User Experience**
- Professional dark UI
- Responsive design
- Error messages
- Success confirmations
- File browser integration

## API Endpoints

### Health & Info
```
GET /api/info/health
POST /api/info/metadata
```

### PDF Operations
```
POST /api/pdf/merge              # Combine multiple PDFs
POST /api/pdf/split              # Extract page range
POST /api/pdf/rotate             # Rotate pages
POST /api/pdf/delete-pages       # Remove specific pages
POST /api/pdf/extract-pages      # Extract specific pages
POST /api/pdf/watermark          # Add watermark text
POST /api/pdf/number-pages       # Add page numbers
POST /api/pdf/compress           # Reduce file size
POST /api/pdf/protect            # Password protect
POST /api/pdf/image-to-pdf       # Convert images to PDF
POST /api/pdf/txt-to-pdf         # Convert text to PDF
POST /api/pdf/pdf-to-image       # Export pages as images
```

## Configuration

### Backend (services/pdf-api/src/main/resources/application.properties)
```properties
server.port=8080
spring.servlet.multipart.max-file-size=50MB
spring.servlet.multipart.max-request-size=100MB
```

### Mobile (apps/mobile/lib/services/pdf_api_service.dart)
```dart
static const String baseUrl = 'http://localhost:8080/api';
```

Update this to your backend URL when deploying.

## Development Workflow

1. **Start the backend**
   ```bash
   cd services/pdf-api
   mvn spring-boot:run
   ```

2. **Start the mobile app (in another terminal)**
   ```bash
   cd apps/mobile
   flutter run
   ```

3. **Test API endpoints**
   - Use Postman or curl to test backend
   - Use Flutter app to test integration

## Testing the Integration

### Using cURL (test backend)
```bash
# Check health
curl http://localhost:8080/api/info/health

# Merge PDFs
curl -X POST -F "files=@file1.pdf" -F "files=@file2.pdf" \
  http://localhost:8080/api/pdf/merge > merged.pdf

# Compress PDF
curl -X POST -F "file=@document.pdf" \
  http://localhost:8080/api/pdf/compress > compressed.pdf
```

### Using Flutter App
- Launch app on Android/iOS device or emulator
- Select PDF operations from dashboard
- Pick files from device
- Download processed PDFs

## License

Apache 2.0 (aligns with Apache PDFBox)

## References

- Apache PDFBox: https://pdfbox.apache.org/
- Spring Boot: https://spring.io/projects/spring-boot
- Flutter: https://flutter.dev/
