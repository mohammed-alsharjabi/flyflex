import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../data/constants/countries.dart';
import '../../data/models/country_model.dart';
import '../../data/models/passenger_model.dart';
import '../../logic/controllers/passport_file_picker.dart';
import '../../logic/controllers/passport_scan_service.dart';
import '../widgets/passenger_form_field.dart';
import '../widgets/gender_selector.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/passenger_section_card.dart';
import '../widgets/passport_upload_card.dart';
import '../widgets/nationality_selector_field.dart';
import '../widgets/mobile_number_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/utils/l10n_extension.dart';

class PassengerFormSection extends StatefulWidget {
  const PassengerFormSection({
    super.key,
    required this.onSaved,
    this.initial,
  });

  final void Function(PassengerModel) onSaved;
  final PassengerModel? initial;

  @override
  State<PassengerFormSection> createState() => PassengerFormSectionState();
}

class PassengerFormSectionState extends State<PassengerFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _dobKey = GlobalKey<DatePickerFieldState>();
  final _expiryKey = GlobalKey<DatePickerFieldState>();
  final _mobileKey = GlobalKey<MobileNumberFieldState>();

  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _passportNumber;
  late final TextEditingController _nationalId;
  late final TextEditingController _mobileLocal;
  late final TextEditingController _email;

  String _gender = 'male';
  DateTime? _dateOfBirth;
  DateTime? _passportExpiry;
  CountryModel _nationalityCountry = Countries.saudiArabia;
  CountryModel _phoneCountry = Countries.saudiArabia;
  String? _passportFileName;
  bool _isScanning = false;
  bool _hasScannedPassport = false;
  String? _nationalityError;

  @override
  void initState() {
    super.initState();
    final p = widget.initial;
    _firstName = TextEditingController(text: p?.firstName ?? '');
    _lastName = TextEditingController(text: p?.lastName ?? '');
    _passportNumber = TextEditingController(text: p?.passportNumber ?? '');
    _nationalId = TextEditingController(text: p?.nationalId ?? '');
    _email = TextEditingController(text: p?.email ?? '');
    _passportFileName = p?.passportFileName;
    _gender = p?.gender ?? 'male';
    _dateOfBirth = p?.dateOfBirth;
    _passportExpiry = p?.passportExpiry;

    if (p?.countryCode != null) {
      _nationalityCountry = Countries.byCode(p!.countryCode!);
      _phoneCountry = _nationalityCountry;
    } else if (p?.nationality != null) {
      _nationalityCountry =
          Countries.findByNationality(p!.nationality) ?? Countries.saudiArabia;
      _phoneCountry = _nationalityCountry;
    }

    final fullMobile = p?.mobile ?? p?.phone ?? '';
    _mobileLocal = TextEditingController(
      text: fullMobile.isEmpty
          ? ''
          : Countries.stripDialCode(fullMobile, _phoneCountry),
    );
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _passportNumber.dispose();
    _nationalId.dispose();
    _mobileLocal.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _pickAndScanPassport() async {
    try {
      final pickResult = await PassportFilePicker.pick(context);
      if (pickResult == null || !mounted) return;

      setState(() {
        _passportFileName = pickResult.fileName;
        _isScanning = true;
      });

      final result =
          await PassportScanService.scanFromFile(pickResult.fileName);
      if (!mounted) return;

      setState(() {
        _firstName.text = result.firstName;
        _lastName.text = result.lastName;
        _passportNumber.text = result.passportNumber;
        _dateOfBirth = result.dateOfBirth;
        _passportExpiry = result.passportExpiry;
        _gender = result.gender;
        _nationalityCountry = result.country;
        _phoneCountry = result.country;
        _hasScannedPassport = true;
        _isScanning = false;
        _nationalityError = null;
      });

      _dobKey.currentState?.refresh();
      _expiryKey.currentState?.refresh();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.passengerScanSuccess,
            style: GoogleFonts.inter(color: AppColors.textPrimary),
          ),
          backgroundColor: AppColors.navyLight,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      );
    } on PassportPickException catch (e) {
      if (!mounted) return;
      setState(() => _isScanning = false);
      if (e.error == PassportPickError.invalidType) {
        _showUploadError(context.l10n.passengerInvalidFileType);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _isScanning = false);
      _showUploadError(context.l10n.passengerUploadFailed);
    }
  }

  void _showUploadError(String message) {
    _showFormError(message);
  }

  void _showFormError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(color: AppColors.textPrimary),
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }

  void _onNationalityChanged(CountryModel country) {
    setState(() {
      _nationalityCountry = country;
      _phoneCountry = country;
      _nationalityError = null;
    });
  }

  void submit() {
    final formValid = _formKey.currentState?.validate() ?? false;
    final dobError = _dobKey.currentState?.validate();
    final expiryError = _expiryKey.currentState?.validate();
    final mobileError = _mobileKey.currentState?.validate();

    final nationalityError = _nationalityCountry.code.isEmpty
        ? context.l10n.passengerRequired
        : null;
    setState(() => _nationalityError = nationalityError);

    if (!formValid ||
        dobError != null ||
        expiryError != null ||
        mobileError != null ||
        nationalityError != null) {
      _showFormError(context.l10n.passengerFormIncomplete);
      return;
    }

    final fullMobile = Countries.buildFullMobile(
      _phoneCountry,
      _mobileLocal.text.trim(),
    );

    final passenger = PassengerModel(
      id: widget.initial?.id ?? const Uuid().v4(),
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      dateOfBirth: _dateOfBirth!,
      passportNumber: _passportNumber.text.trim().toUpperCase(),
      passportExpiry: _passportExpiry!,
      nationality: _nationalityCountry.localizedName(context),
      countryCode: _nationalityCountry.code,
      gender: _gender,
      nationalId: _nationalId.text.trim().isEmpty
          ? null
          : _nationalId.text.trim(),
      mobile: fullMobile,
      email: _email.text.trim().isEmpty ? null : _email.text.trim(),
      phone: fullMobile,
      passportFileName: _passportFileName,
    );
    widget.onSaved(passenger);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PassengerSectionCard(
            title: l10n.passengerTravelDoc,
            subtitle: l10n.passengerTravelDocSubtitle,
            children: [
              PassportUploadCard(
                fileName: _passportFileName,
                isScanning: _isScanning,
                onPickFile: _pickAndScanPassport,
                onRemove: () => setState(() {
                  _passportFileName = null;
                  _hasScannedPassport = false;
                }),
              ),
              if (_hasScannedPassport) ...[
                const SizedBox(height: 12),
                _AutoFillBanner(message: l10n.passengerAutoFillBanner),
              ],
              const SizedBox(height: 16),
              PassengerFormField(
                label: l10n.passengerPassportNumber.toUpperCase(),
                hint: l10n.passengerPassportNumberHint,
                controller: _passportNumber,
                prefixIcon: Icons.book_outlined,
                textCapitalization: TextCapitalization.characters,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return l10n.passengerRequired;
                  }
                  if (v.trim().length < 6) return l10n.passengerInvalidPassport;
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DatePickerField(
                key: _expiryKey,
                label: l10n.passengerPassportExpiry.toUpperCase(),
                selectedDate: _passportExpiry,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 20)),
                onDateSelected: (d) => setState(() => _passportExpiry = d),
                validator: (date) {
                  if (date == null) return l10n.passengerRequired;
                  final today = DateTime.now();
                  final expiryDay = DateTime(date.year, date.month, date.day);
                  final todayDay = DateTime(today.year, today.month, today.day);
                  if (expiryDay.isBefore(todayDay)) {
                    return l10n.passengerExpiredPassport;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              PassengerFormField(
                label: l10n.passengerNationalId.toUpperCase(),
                hint: l10n.passengerNationalIdHint,
                controller: _nationalId,
                prefixIcon: Icons.badge_outlined,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  if (v.trim().length != 10) {
                    return l10n.passengerInvalidNationalId;
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          PassengerSectionCard(
            title: l10n.passengerPersonalInfo,
            subtitle: l10n.passengerPersonalInfoSubtitle,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PassengerFormField(
                      label: l10n.passengerFirstName.toUpperCase(),
                      hint: l10n.passengerFirstNameHint,
                      controller: _firstName,
                      prefixIcon: Icons.person_outline_rounded,
                      textCapitalization: TextCapitalization.words,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? l10n.passengerRequired
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PassengerFormField(
                      label: l10n.passengerLastName.toUpperCase(),
                      hint: l10n.passengerLastNameHint,
                      controller: _lastName,
                      prefixIcon: Icons.person_outline_rounded,
                      textCapitalization: TextCapitalization.words,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? l10n.passengerRequired
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GenderSelector(
                selectedGender: _gender,
                onChanged: (g) => setState(() => _gender = g),
              ),
              const SizedBox(height: 12),
              DatePickerField(
                key: _dobKey,
                label: l10n.passengerDateOfBirth.toUpperCase(),
                selectedDate: _dateOfBirth,
                firstDate: DateTime(1920),
                lastDate: DateTime.now(),
                onDateSelected: (d) => setState(() => _dateOfBirth = d),
                validator: (date) =>
                    date == null ? l10n.passengerRequired : null,
              ),
              const SizedBox(height: 12),
              NationalitySelectorField(
                selectedCountry: _nationalityCountry,
                onChanged: _onNationalityChanged,
                errorText: _nationalityError,
                isAutoFilled: _hasScannedPassport,
              ),
            ],
          ),
          const SizedBox(height: 16),
          PassengerSectionCard(
            title: l10n.passengerContactInfo,
            subtitle: l10n.passengerContactInfoSubtitle,
            children: [
              MobileNumberField(
                key: _mobileKey,
                country: _phoneCountry,
                controller: _mobileLocal,
                onCountryChanged: (c) => setState(() => _phoneCountry = c),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return l10n.passengerRequired;
                  }
                  if (v.trim().length < 8) return l10n.passengerInvalidMobile;
                  return null;
                },
              ),
              const SizedBox(height: 12),
              PassengerFormField(
                label: l10n.passengerEmail.toUpperCase(),
                hint: l10n.passengerEmailHint,
                controller: _email,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final emailReg = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                  if (!emailReg.hasMatch(v.trim())) {
                    return l10n.passengerInvalidEmail;
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _AutoFillBanner extends StatelessWidget {
  const _AutoFillBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.goldPure.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.goldPure.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.auto_awesome_rounded,
            color: AppColors.goldPure,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.goldLight,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
