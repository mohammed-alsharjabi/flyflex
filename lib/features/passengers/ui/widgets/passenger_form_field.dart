import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_radius.dart';

class PassengerFormField extends StatefulWidget {
  const PassengerFormField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.obscureText = false,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final bool obscureText;
  final bool enabled;
  final TextCapitalization textCapitalization;

  @override
  State<PassengerFormField> createState() => _PassengerFormFieldState();
}

class _PassengerFormFieldState extends State<PassengerFormField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.removeListener(_onFocusChange);
      _focusNode.dispose();
    }
    super.dispose();
  }

  Color get _borderColor {
    if (_hasError) return AppColors.error;
    if (_isFocused) return AppColors.goldPure;
    return AppColors.glassBorder;
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
            color: _isFocused ? AppColors.goldLight : AppColors.goldPure,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: _borderColor,
              width: (_hasError || _isFocused) ? 1.5 : 1.0,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppColors.goldPure.withValues(alpha: 0.10),
                      blurRadius: 12,
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.textCapitalization,
            onFieldSubmitted: widget.onFieldSubmitted,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
            cursorColor: AppColors.goldPure,
            cursorWidth: 1.5,
            validator: (value) {
              final result = widget.validator?.call(value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _hasError = result != null;
                    _errorMessage = result;
                  });
                }
              });
              return result;
            },
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle:
                  GoogleFonts.inter(fontSize: 14, color: AppColors.textMuted),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(start: 14, end: 10),
                      child: Icon(
                        widget.prefixIcon,
                        color: AppColors.textMuted,
                        size: 18,
                      ),
                    )
                  : widget.prefixText != null
                      ? Padding(
                          padding: const EdgeInsetsDirectional.only(start: 16, end: 4),
                          child: Text(
                            widget.prefixText!,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        )
                      : null,
              suffixIcon: widget.suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10, end: 14),
                      child: IconTheme(
                        data: const IconThemeData(
                            color: AppColors.textMuted, size: 18),
                        child: widget.suffixIcon!,
                      ),
                    )
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: widget.prefixIcon != null ? 0 : 16,
                vertical: 14,
              ),
              errorStyle: const TextStyle(height: 0, fontSize: 0),
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
