package com.pdfpro.api.dto;

public class PdfMetadata {
    private int pageCount;
    private long fileSizeBytes;
    private String fileName;
    private boolean isEncrypted;

    public PdfMetadata(int pageCount, long fileSizeBytes, String fileName, boolean isEncrypted) {
        this.pageCount = pageCount;
        this.fileSizeBytes = fileSizeBytes;
        this.fileName = fileName;
        this.isEncrypted = isEncrypted;
    }

    public int getPageCount() { return pageCount; }
    public long getFileSizeBytes() { return fileSizeBytes; }
    public String getFileName() { return fileName; }
    public boolean isEncrypted() { return isEncrypted; }
}
