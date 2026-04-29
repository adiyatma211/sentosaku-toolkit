import 'dart:io';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/logging/app_logger.dart';
import 'report_models.dart';

class ExportService {
  const ExportService(this._logger);

  final AppLogger _logger;

  Future<File> exportPdf(ExportReportData data) async {
    const action = 'reports.exportPdf';
    final logData = _exportLogData(data, 'pdf');
    _logger.logTransactionStart(action, logData);
    try {
      final document = pw.Document();
      final dateFormat = DateFormat('dd MMM yyyy HH:mm', 'id_ID');

      document.addPage(
        pw.MultiPage(
          build: (context) => [
            pw.Text(
              data.title,
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 6),
            pw.Text('Periode: ${data.filterLabel}'),
            pw.Text('Dibuat: ${dateFormat.format(data.generatedAt)}'),
            pw.SizedBox(height: 16),
            pw.TableHelper.fromTextArray(
              headers: data.columns,
              data: data.rows,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellStyle: const pw.TextStyle(fontSize: 9),
              cellAlignment: pw.Alignment.centerLeft,
            ),
          ],
        ),
      );

      final file = await _exportFile(data, 'pdf');
      await file.writeAsBytes(await document.save());
      _logger.logTransactionSuccess(action, {...logData, 'path': file.path});
      return file;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<File> exportCsv(ExportReportData data) async {
    const action = 'reports.exportCsv';
    final logData = _exportLogData(data, 'csv');
    _logger.logTransactionStart(action, logData);
    try {
      final rows = <List<String>>[
        ['Judul', data.title],
        ['Periode', data.filterLabel],
        ['Dibuat', DateFormat('yyyy-MM-dd HH:mm:ss').format(data.generatedAt)],
        const [],
        data.columns,
        ...data.rows,
      ];
      final csv = const ListToCsvConverter().convert(rows);
      final file = await _exportFile(data, 'csv');
      await file.writeAsString(csv);
      _logger.logTransactionSuccess(action, {...logData, 'path': file.path});
      return file;
    } catch (error, stackTrace) {
      _logger.logTransactionError(action, error, stackTrace, logData);
      rethrow;
    }
  }

  Future<File> exportExcel(ExportReportData data) {
    return exportCsv(data);
  }

  Future<File> _exportFile(ExportReportData data, String extension) async {
    final documents = await getApplicationDocumentsDirectory();
    final directory = Directory(p.join(documents.path, 'exports'));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final timestamp = DateFormat(
      'yyyy-MM-dd_HH-mm-ss',
    ).format(data.generatedAt);
    final title = data.title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    return File(p.join(directory.path, '${title}_$timestamp.$extension'));
  }

  Map<String, Object?> _exportLogData(ExportReportData data, String format) {
    return {
      'title': data.title,
      'filterLabel': data.filterLabel,
      'format': format,
      'rowCount': data.rows.length,
    };
  }
}
