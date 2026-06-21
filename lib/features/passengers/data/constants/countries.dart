import '../models/country_model.dart';

class Countries {
  Countries._();

  static const CountryModel saudiArabia = CountryModel(
    code: 'SA',
    nameEn: 'Saudi Arabia',
    nameAr: 'المملكة العربية السعودية',
    dialCode: '+966',
    flagEmoji: '🇸🇦',
  );

  static const List<CountryModel> all = [
    saudiArabia,
    CountryModel(
      code: 'AE',
      nameEn: 'United Arab Emirates',
      nameAr: 'الإمارات العربية المتحدة',
      dialCode: '+971',
      flagEmoji: '🇦🇪',
    ),
    CountryModel(
      code: 'EG',
      nameEn: 'Egypt',
      nameAr: 'مصر',
      dialCode: '+20',
      flagEmoji: '🇪🇬',
    ),
    CountryModel(
      code: 'JO',
      nameEn: 'Jordan',
      nameAr: 'الأردن',
      dialCode: '+962',
      flagEmoji: '🇯🇴',
    ),
    CountryModel(
      code: 'KW',
      nameEn: 'Kuwait',
      nameAr: 'الكويت',
      dialCode: '+965',
      flagEmoji: '🇰🇼',
    ),
    CountryModel(
      code: 'QA',
      nameEn: 'Qatar',
      nameAr: 'قطر',
      dialCode: '+974',
      flagEmoji: '🇶🇦',
    ),
    CountryModel(
      code: 'BH',
      nameEn: 'Bahrain',
      nameAr: 'البحرين',
      dialCode: '+973',
      flagEmoji: '🇧🇭',
    ),
    CountryModel(
      code: 'OM',
      nameEn: 'Oman',
      nameAr: 'عُمان',
      dialCode: '+968',
      flagEmoji: '🇴🇲',
    ),
    CountryModel(
      code: 'LB',
      nameEn: 'Lebanon',
      nameAr: 'لبنان',
      dialCode: '+961',
      flagEmoji: '🇱🇧',
    ),
    CountryModel(
      code: 'IQ',
      nameEn: 'Iraq',
      nameAr: 'العراق',
      dialCode: '+964',
      flagEmoji: '🇮🇶',
    ),
    CountryModel(
      code: 'YE',
      nameEn: 'Yemen',
      nameAr: 'اليمن',
      dialCode: '+967',
      flagEmoji: '🇾🇪',
    ),
    CountryModel(
      code: 'SY',
      nameEn: 'Syria',
      nameAr: 'سوريا',
      dialCode: '+963',
      flagEmoji: '🇸🇾',
    ),
    CountryModel(
      code: 'PS',
      nameEn: 'Palestine',
      nameAr: 'فلسطين',
      dialCode: '+970',
      flagEmoji: '🇵🇸',
    ),
    CountryModel(
      code: 'MA',
      nameEn: 'Morocco',
      nameAr: 'المغرب',
      dialCode: '+212',
      flagEmoji: '🇲🇦',
    ),
    CountryModel(
      code: 'TN',
      nameEn: 'Tunisia',
      nameAr: 'تونس',
      dialCode: '+216',
      flagEmoji: '🇹🇳',
    ),
    CountryModel(
      code: 'DZ',
      nameEn: 'Algeria',
      nameAr: 'الجزائر',
      dialCode: '+213',
      flagEmoji: '🇩🇿',
    ),
    CountryModel(
      code: 'LY',
      nameEn: 'Libya',
      nameAr: 'ليبيا',
      dialCode: '+218',
      flagEmoji: '🇱🇾',
    ),
    CountryModel(
      code: 'SD',
      nameEn: 'Sudan',
      nameAr: 'السودان',
      dialCode: '+249',
      flagEmoji: '🇸🇩',
    ),
    CountryModel(
      code: 'TR',
      nameEn: 'Turkey',
      nameAr: 'تركيا',
      dialCode: '+90',
      flagEmoji: '🇹🇷',
    ),
    CountryModel(
      code: 'PK',
      nameEn: 'Pakistan',
      nameAr: 'باكستان',
      dialCode: '+92',
      flagEmoji: '🇵🇰',
    ),
    CountryModel(
      code: 'IN',
      nameEn: 'India',
      nameAr: 'الهند',
      dialCode: '+91',
      flagEmoji: '🇮🇳',
    ),
    CountryModel(
      code: 'GB',
      nameEn: 'United Kingdom',
      nameAr: 'المملكة المتحدة',
      dialCode: '+44',
      flagEmoji: '🇬🇧',
    ),
    CountryModel(
      code: 'US',
      nameEn: 'United States',
      nameAr: 'الولايات المتحدة',
      dialCode: '+1',
      flagEmoji: '🇺🇸',
    ),
    CountryModel(
      code: 'FR',
      nameEn: 'France',
      nameAr: 'فرنسا',
      dialCode: '+33',
      flagEmoji: '🇫🇷',
    ),
    CountryModel(
      code: 'DE',
      nameEn: 'Germany',
      nameAr: 'ألمانيا',
      dialCode: '+49',
      flagEmoji: '🇩🇪',
    ),
  ];

  static CountryModel byCode(String code) =>
      all.firstWhere((c) => c.code == code, orElse: () => saudiArabia);

  static CountryModel? findByNationality(String nationality) {
    final normalized = nationality.trim().toLowerCase();
    if (normalized.isEmpty) return null;
    for (final country in all) {
      if (country.nameEn.toLowerCase() == normalized ||
          country.nameAr == nationality.trim()) {
        return country;
      }
    }
    return null;
  }

  static CountryModel? findByDialCode(String dialCode) {
    final normalized = dialCode.trim();
    for (final country in all) {
      if (country.dialCode == normalized) return country;
    }
    return null;
  }

  static String stripDialCode(String fullNumber, CountryModel country) {
    var digits = fullNumber.replaceAll(RegExp(r'[\s\-()]'), '');
    final dialDigits = country.dialCode.replaceAll('+', '');
    if (digits.startsWith('+')) {
      digits = digits.substring(1);
    }
    if (digits.startsWith(dialDigits)) {
      return digits.substring(dialDigits.length);
    }
    if (digits.startsWith('0')) {
      return digits.substring(1);
    }
    return digits;
  }

  static String buildFullMobile(CountryModel country, String localNumber) {
    final local = localNumber.replaceAll(RegExp(r'[\s\-()]'), '');
    return '${country.dialCode}$local';
  }
}
