import 'package:flutter/material.dart';

import '../data/assessment_repository.dart';

class AssessmentSummaryCard extends StatelessWidget {
  const AssessmentSummaryCard({super.key, required this.summary});

  final AssessmentPeriodSummary summary;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ringkasan assessment',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              '${summary.sessionAssessmentCount} assessment sesi, ${summary.reviewCycleCount} review cycle.',
            ),
            const SizedBox(height: 12),
            for (final digest in summary.aspectDigests)
              if (digest.count > 0) ...[
                Text(
                  _labelForKey(digest.fieldKey),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(digest.latestEntry ?? '-'),
                const SizedBox(height: 8),
              ],
          ],
        ),
      ),
    );
  }

  String _labelForKey(String key) {
    return switch (key) {
      'pemahamanMateri' => 'Pemahaman materi',
      'keaktifanTanyaJawab' => 'Keaktifan tanya jawab',
      'ketepatanKerapianTugas' => 'Ketepatan dan kerapian tugas',
      'konsistensiKehadiranFokus' => 'Konsistensi kehadiran dan fokus',
      'targetMateriDrilling' => 'Target materi / drilling',
      'sikapBelajarRespon' => 'Sikap belajar dan respon',
      _ => key,
    };
  }
}
