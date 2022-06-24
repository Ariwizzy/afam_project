import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
class WhitePaper extends StatefulWidget {
  const WhitePaper({Key key}) : super(key: key);

  @override
  _WhitePaperState createState() => _WhitePaperState();
}

class _WhitePaperState extends State<WhitePaper> {
  bool _isLoading = true;
   PDFDocument _pdf;

  void _loadFile() async {
    // Load the pdf file from the internet
    _pdf = await PDFDocument.fromAsset('assets/fnst.pdf');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('White Paper'),
      ),
      body: Center(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : PDFViewer(document: _pdf)),
    );
  }
}
