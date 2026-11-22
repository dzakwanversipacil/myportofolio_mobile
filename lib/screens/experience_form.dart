import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _organizationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _titleController.dispose();
    _organizationController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  Future<void> _selectDate({required bool isStartDate}) async {
    final initialDate = isStartDate
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? _startDate ?? DateTime.now());

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null || !mounted) return;

    setState(() {
      if (isStartDate) {
        _startDate = selectedDate;
        _startDateController.text = _formatDate(selectedDate);
      } else {
        _endDate = selectedDate;
        _endDateController.text = _formatDate(selectedDate);
      }
    });
  }

  String? _validateRequiredText(
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

  String? _validateImageUrl(String? value) {
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

  String? _validateEndDate(String? _) {
    if (_startDate != null &&
        _endDate != null &&
        _endDate!.isBefore(_startDate!)) {
      return 'Tanggal selesai tidak boleh sebelum tanggal mulai.';
    }
    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ringkasan Pengalaman'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SummaryRow(label: 'Judul', value: _titleController.text.trim()),
              _SummaryRow(
                label: 'Organisasi',
                value: _organizationController.text.trim(),
              ),
              _SummaryRow(
                label: 'Deskripsi',
                value: _descriptionController.text.trim(),
              ),
              _SummaryRow(
                label: 'Tanggal mulai',
                value: _startDateController.text,
              ),
              _SummaryRow(
                label: 'Tanggal selesai',
                value: _endDateController.text.isEmpty
                    ? 'Masih berlangsung'
                    : _endDateController.text,
              ),
              _SummaryRow(
                label: 'URL gambar',
                value: _imageUrlController.text.trim().isEmpty
                    ? '-'
                    : _imageUrlController.text.trim(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    String? hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(),
      alignLabelWithHint: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Pengalaman')),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Pengalaman Baru',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Lengkapi detail pengalaman sesuai data portofolio web.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      maxLength: 255,
                      decoration: _inputDecoration(
                        label: 'Judul Pengalaman',
                        hint: 'Contoh: Data Scientist Intern',
                      ),
                      validator: (value) => _validateRequiredText(
                        value,
                        fieldName: 'Judul pengalaman',
                        maxLength: 255,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _organizationController,
                      textInputAction: TextInputAction.next,
                      maxLength: 255,
                      decoration: _inputDecoration(
                        label: 'Organisasi',
                        hint: 'Contoh: Google',
                      ),
                      validator: (value) => _validateRequiredText(
                        value,
                        fieldName: 'Organisasi',
                        maxLength: 255,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      minLines: 3,
                      maxLines: 5,
                      textInputAction: TextInputAction.newline,
                      decoration: _inputDecoration(
                        label: 'Deskripsi',
                        hint: 'Jelaskan tanggung jawab dan pencapaianmu.',
                      ),
                      validator: (value) =>
                          _validateRequiredText(value, fieldName: 'Deskripsi'),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _startDateController,
                      readOnly: true,
                      onTap: () => _selectDate(isStartDate: true),
                      decoration: _inputDecoration(
                        label: 'Tanggal Mulai',
                        hint: 'Pilih tanggal',
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                      ),
                      validator: (_) => _startDate == null
                          ? 'Tanggal mulai harus dipilih.'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _endDateController,
                      readOnly: true,
                      onTap: () => _selectDate(isStartDate: false),
                      decoration: _inputDecoration(
                        label: 'Tanggal Selesai (opsional)',
                        hint: 'Kosongkan jika masih berlangsung',
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                      ),
                      validator: _validateEndDate,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _imageUrlController,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      decoration: _inputDecoration(
                        label: 'URL Gambar (opsional)',
                        hint: 'https://example.com/image.jpg',
                      ),
                      validator: _validateImageUrl,
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Simpan'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 2),
          Text(value),
        ],
      ),
    );
  }
}
