// lib/models/khmer_id_model.dart

class KhmerIdModel {
  final String? idNumber;
  final String? firstNameKh;
  final String? lastNameKh;
  final String? firstNameEn;
  final String? lastNameEn;
  final String? dateOfBirth;
  final String? gender;
  final String? address;
  final String? expiryDate;
  final String? rawText;

  KhmerIdModel({
    this.idNumber,
    this.firstNameKh,
    this.lastNameKh,
    this.firstNameEn,
    this.lastNameEn,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.expiryDate,
    this.rawText,
  });

  /// Parse raw OCR text from Khmer National ID card.
  /// Khmer ID cards have both Khmer and Latin text sections.
  factory KhmerIdModel.fromOcrText(String rawText) {
    String? idNumber;
    String? firstNameEn;
    String? lastNameEn;
    String? dateOfBirth;
    String? gender;
    String? expiryDate;

    final lines = rawText.split('\n').map((l) => l.trim()).toList();

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      // ID Number: 9 digits
      final idMatch = RegExp(r'\b(\d{9})\b').firstMatch(line);
      if (idMatch != null && idNumber == null) {
        idNumber = idMatch.group(1);
      }

      // English name lines — typically "SURNAME / GIVEN NAME"
      if (line.contains('/')) {
        final parts = line.split('/');
        if (parts.length == 2) {
          lastNameEn = parts[0].trim().replaceAll(RegExp(r'[^A-Z\s]'), '');
          firstNameEn = parts[1].trim().replaceAll(RegExp(r'[^A-Z\s]'), '');
        }
      }

      // Date pattern DD MMM YYYY or DD/MM/YYYY
      final dateMatch = RegExp(
        r'\b(\d{2}[\s/\-]\w{3,9}[\s/\-]\d{4})\b',
      ).firstMatch(line);
      if (dateMatch != null) {
        final dateStr = dateMatch.group(1)!;
        if (line.toLowerCase().contains('expir') ||
            line.toLowerCase().contains('valid')) {
          expiryDate = dateStr;
        } else if (dateOfBirth == null) {
          dateOfBirth = dateStr;
        }
      }

      // Gender
      if (RegExp(r'\bMALE\b', caseSensitive: false).hasMatch(line)) {
        gender = 'Male';
      } else if (RegExp(r'\bFEMALE\b', caseSensitive: false).hasMatch(line)) {
        gender = 'Female';
      }
    }

    return KhmerIdModel(
      idNumber: idNumber,
      firstNameEn: firstNameEn,
      lastNameEn: lastNameEn,
      dateOfBirth: dateOfBirth,
      gender: gender,
      expiryDate: expiryDate,
      rawText: rawText,
    );
  }

  bool get isValid =>
      idNumber != null &&
      idNumber!.length == 9 &&
      (firstNameEn != null || lastNameEn != null);

  @override
  String toString() =>
      'KhmerIdModel(id: $idNumber, name: $firstNameEn $lastNameEn)';
}