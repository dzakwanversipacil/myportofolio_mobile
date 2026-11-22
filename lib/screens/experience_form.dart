import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/utils/form_validation.dart';
import 'package:myportofolio_mobile/widgets/form_summary_row.dart';
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
        _startDateController.text = formatPortfolioDate(selectedDate);
      } else {
        _endDate = selectedDate;
        _endDateController.text = formatPortfolioDate(selectedDate);
      }
    });
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
              FormSummaryRow(
                label: 'Judul',
                value: _titleController.text.trim(),
              ),
              FormSummaryRow(
                label: 'Organisasi',
                value: _organizationController.text.trim(),
              ),
              FormSummaryRow(
                label: 'Deskripsi',
                value: _descriptionController.text.trim(),
              ),
              FormSummaryRow(
                label: 'Tanggal mulai',
                value: _startDateController.text,
              ),
              FormSummaryRow(
                label: 'Tanggal selesai',
                value: _endDateController.text.isEmpty
                    ? 'Masih berlangsung'
                    : _endDateController.text,
              ),
              FormSummaryRow(
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
                      key: const ValueKey('experience-title'),
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      maxLength: 255,
                      decoration: _inputDecoration(
                        label: 'Judul Pengalaman',
                        hint: 'Contoh: Data Scientist Intern',
                      ),
                      validator: (value) => validateRequiredText(
                        value,
                        fieldName: 'Judul pengalaman',
                        maxLength: 255,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      key: const ValueKey('experience-organization'),
                      controller: _organizationController,
                      textInputAction: TextInputAction.next,
                      maxLength: 255,
                      decoration: _inputDecoration(
                        label: 'Organisasi',
                        hint: 'Contoh: Google',
                      ),
                      validator: (value) => validateRequiredText(
                        value,
                        fieldName: 'Organisasi',
                        maxLength: 255,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      key: const ValueKey('experience-description'),
                      controller: _descriptionController,
                      minLines: 3,
                      maxLines: 5,
                      textInputAction: TextInputAction.newline,
                      decoration: _inputDecoration(
                        label: 'Deskripsi',
                        hint: 'Jelaskan tanggung jawab dan pencapaianmu.',
                      ),
                      validator: (value) =>
                          validateRequiredText(value, fieldName: 'Deskripsi'),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      key: const ValueKey('experience-start-date'),
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
                      key: const ValueKey('experience-end-date'),
                      controller: _endDateController,
                      readOnly: true,
                      onTap: () => _selectDate(isStartDate: false),
                      decoration: _inputDecoration(
                        label: 'Tanggal Selesai (opsional)',
                        hint: 'Kosongkan jika masih berlangsung',
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                      ),
                      validator: (_) => validateDateOrder(_startDate, _endDate),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      key: const ValueKey('experience-image-url'),
                      controller: _imageUrlController,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      decoration: _inputDecoration(
                        label: 'URL Gambar (opsional)',
                        hint: 'https://example.com/image.jpg',
                      ),
                      validator: validateOptionalHttpUrl,
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      key: const ValueKey('experience-save'),
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
