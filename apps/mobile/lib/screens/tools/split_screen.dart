import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/workflow_provider.dart';

class SplitScreen extends StatefulWidget {
  const SplitScreen({super.key});

  @override
  State<SplitScreen> createState() => _SplitScreenState();
}

class _SplitScreenState extends State<SplitScreen> {
  late TextEditingController _startPageController;
  late TextEditingController _endPageController;

  @override
  void initState() {
    super.initState();
    _startPageController = TextEditingController();
    _endPageController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WorkflowProvider>().clearMessages();
    });
  }

  @override
  void dispose() {
    _startPageController.dispose();
    _endPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Split PDF'),
        elevation: 0,
      ),
      body: Consumer<WorkflowProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [const Color(0xFFAB47BC), const Color(0xFFAB47BC).withOpacity(0.4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.cut, size: 36, color: Colors.white),
                      const SizedBox(height: 16),
                      Text(
                        'Extract Pages',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Extract a specific page range from your PDF',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                if (provider.selectedFile != null) ..._buildSplitControls(provider),
                if (provider.selectedFile == null) ..._buildUploadArea(provider),
                if (provider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.withOpacity(0.3)),
                      ),
                      child: Text(
                        provider.errorMessage!,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildUploadArea(WorkflowProvider provider) {
    return [
      GestureDetector(
        onTap: provider.isLoading ? null : () => provider.loadPdfFile(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 48),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 48,
                color: Colors.white.withOpacity(0.6),
              ),
              const SizedBox(height: 16),
              Text(
                'Select PDF to split',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildSplitControls(WorkflowProvider provider) {
    return [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.picture_as_pdf, color: const Color(0xFFAB47BC), size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.selectedFile!.path.split('/').last,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (provider.pdfMetadata != null) ...[const SizedBox(height: 4), Text('${provider.pdfMetadata!['pageCount']} pages', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12))],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Page range', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _startPageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Start',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _endPageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'End',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: provider.isLoading ? null : () => _handleSplit(provider),
                icon: provider.isLoading ? null : const Icon(Icons.check_circle_outline),
                label: Text(provider.isLoading ? 'Splitting...' : 'Split PDF'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFAB47BC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  void _handleSplit(WorkflowProvider provider) {
    final startPage = int.tryParse(_startPageController.text);
    final endPage = int.tryParse(_endPageController.text);

    if (startPage == null || endPage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid page numbers')),
      );
      return;
    }

    // TODO: Implement split logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Split pages $startPage to $endPage')),
    );
  }
}
