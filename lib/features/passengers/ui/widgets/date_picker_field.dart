import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_radius.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.selectedDate,
    this.firstDate,
    this.lastDate,
    this.validator,
  });

  final String label;
  final void Function(DateTime) onDateSelected;
  final DateTime? selectedDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(DateTime?)? validator;

  @override
  State<DatePickerField> createState() => DatePickerFieldState();
}

class DatePickerFieldState extends State<DatePickerField> {
  DateTime? _selected;
  bool _hasError = false;
  String? _errorMessage;

  DateTime? get value => _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedDate;
  }

  String? validate() {
    final result = widget.validator?.call(_selected);
    setState(() {
      _hasError = result != null;
      _errorMessage = result;
    });
    return result;
  }

  void refresh() {
    setState(() => _selected = widget.selectedDate);
  }

  @override
  void didUpdateWidget(covariant DatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _selected = widget.selectedDate;
    }
  }

  Future<void> _pick() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selected ?? widget.selectedDate ?? now,
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(now.year + 20),
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.goldPure,
            onPrimary: AppColors.navyDeep,
            surface: AppColors.navyMid,
            onSurface: AppColors.textPrimary,
          ),
          // ignore: deprecated_member_use
          dialogBackgroundColor: AppColors.navyDark,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: AppColors.goldPure),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selected = picked;
        _hasError = false;
        _errorMessage = null;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.goldPure,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pick,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.glassSurface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: _hasError ? AppColors.error : AppColors.glassBorder,
                width: _hasError ? 1.5 : 1.0,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_rounded,
                    color: AppColors.textMuted, size: 18),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selected != null
                        ? DateFormat('d MMM yyyy').format(_selected!)
                        : context.l10n.dateSelectPlaceholder,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: _selected != null
                          ? AppColors.textPrimary
                          : AppColors.textMuted,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textMuted, size: 20),
              ],
            ),
          ),
        ),
        if (_hasError && _errorMessage != null) ...[
          const SizedBox(height: 4),
          Text(
            _errorMessage!,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: AppColors.error,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}
