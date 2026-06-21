import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import '../../data/models/payment_model.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/credit_card_widget.dart';

class PaymentMethodsSection extends StatefulWidget {
  const PaymentMethodsSection({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod> onMethodSelected;

  @override
  State<PaymentMethodsSection> createState() => _PaymentMethodsSectionState();
}

class _PaymentMethodsSectionState extends State<PaymentMethodsSection> {
  final _cardNumberController = TextEditingController(text: '4242 4242 4242 4242');
  final _expiryController = TextEditingController(text: '12/27');
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.paymentChoosePayment,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...PaymentMethod.values.map(
          (method) => PaymentMethodCard(
            method: method,
            isSelected: widget.selectedMethod == method,
            onTap: () => widget.onMethodSelected(method),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          child: widget.selectedMethod == PaymentMethod.creditCard
              ? Column(
                  children: [
                    const SizedBox(height: 8),
                    CreditCardWidget(
                      cardHolderName: 'Mohammed Al-Sharjabi',
                      cardNumber: _cardNumberController.text,
                      expiry: _expiryController.text,
                    ),
                    const SizedBox(height: 20),
                    _CardFields(
                      cardNumberController: _cardNumberController,
                      expiryController: _expiryController,
                      cvvController: _cvvController,
                    ),
                  ],
                )
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: -0.05, end: 0, duration: 300.ms)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _CardFields extends StatelessWidget {
  const _CardFields({
    required this.cardNumberController,
    required this.expiryController,
    required this.cvvController,
  });

  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Column(
      children: [
        _GlassTextField(
          controller: cardNumberController,
          label: l.paymentCardNumber,
          hint: l.paymentCardNumberHint,
          icon: Icons.credit_card_rounded,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _GlassTextField(
                controller: expiryController,
                label: l.paymentExpiry,
                hint: l.paymentExpiryHint,
                icon: Icons.calendar_month_rounded,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _GlassTextField(
                controller: cvvController,
                label: l.paymentCvv,
                hint: l.paymentCvvHint,
                icon: Icons.lock_rounded,
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GlassTextField extends StatelessWidget {
  const _GlassTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: GoogleFonts.inter(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.inter(
                  color: AppColors.textHint,
                  fontSize: 14,
                ),
                prefixIcon: Icon(icon, color: AppColors.textMuted, size: 18),
                filled: true,
                fillColor: AppColors.glassSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.glassBorder,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.glassBorder,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.goldPure.withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
