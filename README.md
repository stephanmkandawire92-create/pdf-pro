# PDF Pro

A professional PDF productivity platform built as a monorepo with:

- Flutter mobile app for the user experience
- Java Spring Boot API using Apache PDFBox for real PDF processing
- A product structure that can scale to enterprise document workflows

This repository is designed as a real working foundation for a premium PDF toolkit app. It includes the same core professional features you requested, with a robust backend built around Apache PDFBox for real document operations.

## Architecture

- `apps/mobile` — Flutter app for file management, dashboard, workflow UX, and API calls
- `services/pdf-api` — Java backend that performs actual PDF operations using Apache PDFBox

## Implemented backend capabilities

The production backend includes working PDF operations for:

- Merge PDF
- Split PDF
- Rotate PDF
- Delete pages
- Extract pages
- Add watermark
- Number pages
- Compress PDF
- Image to PDF
- TXT to PDF
- Protect PDF
- PDF to image export

## Business use case

This is structured to support a real SaaS or enterprise workflow for:

- document conversion
- PDF cleanup and optimization
- professional document workflows
- business and personal productivity tools

## Product identity

- App name: PDF Pro
- Package: `com.pdfpro.app`
- License: Apache 2.0

## Run the backend

```bash
cd services/pdf-api
mvn spring-boot:run
```

The API will run on:

- `http://localhost:8080`

## Run the mobile app

```bash
cd apps/mobile
flutter pub get
flutter run
```

## Notes

This repository is intentionally structured as a real production foundation, not a mock UI. It combines a practical backend and a professional front-end that is ready to evolve into a full commercial product.
