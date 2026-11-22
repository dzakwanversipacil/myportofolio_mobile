String formatPortfolioDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}

String? validateRequiredText(
  String? value, {
  required String fieldName,
  int? maxLength,
}) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) return '$fieldName tidak boleh kosong.';
  if (maxLength != null && text.length > maxLength) {
    return '$fieldName maksimal $maxLength karakter.';
  }
  return null;
}

String? validateOptionalHttpUrl(String? value) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) return null;

  final uri = Uri.tryParse(text);
  if (uri == null ||
      !uri.hasScheme ||
      !uri.hasAuthority ||
      (uri.scheme != 'http' && uri.scheme != 'https')) {
    return 'URL gambar harus berupa alamat HTTP atau HTTPS yang valid.';
  }
  return null;
}

String? validateDateOrder(DateTime? startDate, DateTime? endDate) {
  if (startDate != null && endDate != null && endDate.isBefore(startDate)) {
    return 'Tanggal selesai tidak boleh sebelum tanggal mulai.';
  }
  return null;
}
