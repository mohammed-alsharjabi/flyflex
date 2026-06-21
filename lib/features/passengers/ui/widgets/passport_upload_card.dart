import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_radius.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';

class PassportUploadCard extends StatelessWidget {
  const PassportUploadCard({
    super.key,
    required this.fileName,
    required this.isScanning,
    required this.onPickFile,
    required this.onRemove,
  });

  final String? fileName;
  final bool isScanning;
  final Future<void> Function() onPickFile;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasFile = fileName != null && fileName!.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: hasFile
              ? AppColors.goldPure.withValues(alpha: 0.5)
              : AppColors.glassBorder,
          width: hasFile ? 1.5 : 1,
        ),
        color: hasFile
            ? AppColors.goldPure.withValues(alpha: 0.06)
            : AppColors.glassSurface,
      ),
      child: Stack(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isScanning ? null : onPickFile,
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: hasFile ? _UploadedContent(
                  fileName: fileName!,
                  onRemove: isScanning ? null : onRemove,
                  l10n: l10n,
                ) : _EmptyContent(l10n: l10n),
              ),
            ),
          ),
          if (isScanning) _ScanningOverlay(l10n: l10n),
        ],
      ),
    );
  }
}

class _EmptyContent extends StatelessWidget {
  const _EmptyContent({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.goldPure.withValues(alpha: 0.12),
            border: Border.all(
              color: AppColors.goldPure.withValues(alpha: 0.3),
            ),
          ),
          child: const Icon(
            Icons.upload_file_rounded,
            color: AppColors.goldPure,
            size: 26,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          l10n.passengerUploadPassport,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.passengerUploadPassportHint,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textMuted,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: AppColors.goldGradient),
            borderRadius: BorderRadius.circular(AppRadius.chip),
          ),
          child: Text(
            l10n.passengerChooseFile,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.navyDeep,
            ),
          ),
        ),
      ],
    );
  }
}

class _UploadedContent extends StatelessWidget {
  const _UploadedContent({
    required this.fileName,
    required this.onRemove,
    required this.l10n,
  });

  final String fileName;
  final VoidCallback? onRemove;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            color: AppColors.goldPure.withValues(alpha: 0.15),
          ),
          child: const Icon(
            Icons.description_rounded,
            color: AppColors.goldPure,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.passengerPassportUploaded,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.goldLight,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                fileName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        if (onRemove != null)
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.textMuted,
              size: 20,
            ),
          ),
      ],
    );
  }
}

class _ScanningOverlay extends StatelessWidget {
  const _ScanningOverlay({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          color: AppColors.navyDeep.withValues(alpha: 0.82),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.goldPure,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.passengerScanningPassport,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
