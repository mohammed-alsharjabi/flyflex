// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'فلاي فلكس';

  @override
  String get appTagline => 'المقاعد غير المباعة. فرصتك.';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navBookings => 'حجوزاتي';

  @override
  String get navAlerts => 'التنبيهات';

  @override
  String get navProfile => 'حسابي';

  @override
  String get buttonRetry => 'حاول مجدداً';

  @override
  String get buttonContinue => 'متابعة';

  @override
  String get buttonConfirm => 'تأكيد';

  @override
  String get buttonCancel => 'إلغاء';

  @override
  String get buttonNext => 'التالي';

  @override
  String get buttonGetStarted => 'ابدأ الآن';

  @override
  String get buttonSkip => 'تخطي';

  @override
  String get buttonSignIn => 'تسجيل الدخول';

  @override
  String get buttonSignOut => 'تسجيل الخروج';

  @override
  String get buttonBack => 'رجوع';

  @override
  String get buttonSave => 'حفظ';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get errorGeneral => 'حدث خطأ ما';

  @override
  String get errorRetry => 'يرجى المحاولة مجدداً';

  @override
  String get errorNoWifi => 'لا يوجد اتصال بالإنترنت';

  @override
  String get statusLive => 'مباشر';

  @override
  String get onboarding1Title => 'اكتشف المقاعد غير المباعة';

  @override
  String get onboarding1Subtitle =>
      'تنشر شركات الطيران المقاعد غير المباعة قبيل الإقلاع. أنت تكتشفها أولاً.';

  @override
  String get onboarding2Title => 'احجز بخصم يصل إلى 83٪';

  @override
  String get onboarding2Subtitle =>
      'مقاعد الدرجات الفاخرة بجزء بسيط من السعر الأصلي. رفاهية بتعريف جديد.';

  @override
  String get onboarding3Title => 'سافر بفخامة. ادفع أقل.';

  @override
  String get onboarding3Subtitle =>
      'تجارب درجة الأعمال والدرجة الأولى في متناول الجميع. ترقيتك في انتظارك.';

  @override
  String get loginWelcome => 'أهلاً بعودتك';

  @override
  String get loginTagline => 'سجّل دخولك لاكتشاف المقاعد الفاخرة غير المباعة';

  @override
  String get loginEmail => 'البريد الإلكتروني';

  @override
  String get loginEmailHint => 'example@email.com';

  @override
  String get loginPassword => 'كلمة المرور';

  @override
  String get loginPasswordHint => 'أدخل كلمة المرور';

  @override
  String get loginContinueGuest => 'المتابعة كزائر';

  @override
  String get loginEmailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get loginEmailInvalid => 'أدخل بريداً إلكترونياً صحيحاً';

  @override
  String get loginPasswordRequired => 'كلمة المرور مطلوبة';

  @override
  String get loginPasswordMinLength =>
      'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get splashTagline => 'المقاعد الفاخرة غير المباعة';

  @override
  String get homeAvailableSeats => 'مقعد\nمتاح الآن';

  @override
  String get homeAverageSavings => 'متوسط\nالتوفير';

  @override
  String get homePartnerAirlines => 'شركة\nطيران شريكة';

  @override
  String get homeHeroTagline => 'مقاعد غير مباعة.\nفرصتك الآن.';

  @override
  String get homeHeroSubtitle =>
      'مقاعد فاخرة في اللحظة الأخيرة بخصم يصل إلى 83٪.\nمتاحة الآن.';

  @override
  String get homeFlightCategories => 'فئات الرحلات';

  @override
  String get homeDomesticFlights => 'رحلات داخلية';

  @override
  String get homeInternationalFlights => 'رحلات دولية';

  @override
  String get homeDomesticSubtitle => 'استكشف المملكة العربية السعودية';

  @override
  String get homeInternationalSubtitle => 'سافر إلى العالم';

  @override
  String get homeLastMinuteDeals => 'عروض اللحظة الأخيرة';

  @override
  String get homeDealsSubtitle => 'تبيع بسرعة · مقاعد محدودة';

  @override
  String get homePopularCities => 'المدن الشهيرة';

  @override
  String get homeExploreAll => 'عرض الكل';

  @override
  String homeRoutes(int count) {
    return '$count وجهة';
  }

  @override
  String get homeDomesticRoutes => '٢٤ وجهة';

  @override
  String get homeInternationalRoutes => '٤٨ وجهة';

  @override
  String citiesAvailable(int count) {
    return '$count مدينة متاحة';
  }

  @override
  String citiesFlights(int count) {
    return '$count رحلة';
  }

  @override
  String get flightsDomestic => 'الرحلات الداخلية';

  @override
  String get flightsInternational => 'الرحلات الدولية';

  @override
  String get flightsAll => 'الكل';

  @override
  String get flightsEconomy => 'الاقتصادية';

  @override
  String get flightsBusiness => 'الأعمال';

  @override
  String get flightsFirstClass => 'الدرجة الأولى';

  @override
  String get flightsDirect => 'مباشر';

  @override
  String flightsSeatsLeft(int count) {
    return 'تبقى $count';
  }

  @override
  String get flightsNoResults => 'لا توجد رحلات متاحة';

  @override
  String get flightsAvailable => 'الرحلات المتاحة';

  @override
  String get flightsSortPrice => 'ترتيب حسب السعر';

  @override
  String get flightsCurrency => 'ر.س';

  @override
  String get flightsAirlines => 'طيران';

  @override
  String get flightsSortAsc => 'السعر: من الأقل للأعلى';

  @override
  String get flightsSortDesc => 'السعر: من الأعلى للأقل';

  @override
  String get flightDetailsTitle => 'تفاصيل الرحلة';

  @override
  String get flightDetailsBookNow => 'احجز الآن';

  @override
  String get flightDetailsPriceBreakdown => 'تفاصيل السعر';

  @override
  String get flightDetailsBaseFare => 'سعر التذكرة';

  @override
  String get flightDetailsTaxes => 'الضرائب والرسوم';

  @override
  String get flightDetailsServiceFee => 'رسوم خدمة فلاي فلكس';

  @override
  String get flightDetailsTotal => 'الإجمالي';

  @override
  String flightDetailsSavings(String amount, int percent) {
    return 'وفّرت $amount ر.س ($percent٪)';
  }

  @override
  String get flightDetailsInfo => 'معلومات الرحلة';

  @override
  String get flightDetailsAircraft => 'نوع الطائرة';

  @override
  String get flightDetailsDepartureTerminal => 'صالة المغادرة';

  @override
  String get flightDetailsArrivalTerminal => 'صالة الوصول';

  @override
  String get flightDetailsBaggage => 'سماح الأمتعة';

  @override
  String get flightDetailsOnTime => 'نسبة الالتزام بالمواعيد';

  @override
  String get flightDetailsRefund => 'سياسة الاسترداد';

  @override
  String flightDetailsBoardBy(String time) {
    return 'الصعود قبل $time';
  }

  @override
  String flightDetailsSeatsLeft(int count) {
    return 'تبقى $count مقاعد';
  }

  @override
  String get flightDetailsCabin => 'الدرجة';

  @override
  String get flightDetailsStops => 'التوقفات';

  @override
  String get flightDetailsNonStop => 'بدون توقف';

  @override
  String get passengerTitle => 'بيانات المسافر';

  @override
  String get passengerFirstName => 'الاسم الأول';

  @override
  String get passengerFirstNameHint => 'كما في جواز السفر';

  @override
  String get passengerLastName => 'اسم العائلة';

  @override
  String get passengerLastNameHint => 'كما في جواز السفر';

  @override
  String get passengerDateOfBirth => 'تاريخ الميلاد';

  @override
  String get passengerGender => 'الجنس';

  @override
  String get passengerGenderMale => 'ذكر';

  @override
  String get passengerGenderFemale => 'أنثى';

  @override
  String get passengerPassportNumber => 'رقم جواز السفر';

  @override
  String get passengerPassportNumberHint => 'مثال: A12345678';

  @override
  String get passengerPassportExpiry => 'تاريخ انتهاء جواز السفر';

  @override
  String get passengerNationality => 'الجنسية';

  @override
  String get passengerNationalityHint => 'مثال: سعودي';

  @override
  String get passengerNationalId => 'الهوية الوطنية / الإقامة';

  @override
  String get passengerNationalIdHint => 'رقم مكون من 10 أرقام';

  @override
  String get passengerMobile => 'رقم الجوال';

  @override
  String get passengerMobileHint => 'مثال: +966 5X XXX XXXX';

  @override
  String get passengerEmail => 'البريد الإلكتروني';

  @override
  String get passengerEmailHint => 'اختياري';

  @override
  String get passengerContinue => 'المتابعة لاختيار المقعد';

  @override
  String get passengerRequired => 'هذا الحقل مطلوب';

  @override
  String get passengerInvalidEmail => 'أدخل بريداً إلكترونياً صحيحاً';

  @override
  String get passengerInvalidMobile => 'أدخل رقم جوال صحيحاً';

  @override
  String get passengerInvalidPassport => 'أدخل رقم جواز سفر صحيحاً';

  @override
  String get passengerInvalidNationalId => 'أدخل رقم هوية صحيحاً (10 أرقام)';

  @override
  String get passengerExpiredPassport => 'يجب أن يكون جواز السفر سارياً';

  @override
  String get passengerFlightSummary => 'ملخص الرحلة';

  @override
  String get passengerPersonalInfo => 'البيانات الشخصية';

  @override
  String get passengerTravelDoc => 'وثائق السفر';

  @override
  String get passengerContactInfo => 'معلومات الاتصال';

  @override
  String get passengerTravelDocSubtitle => 'ارفع جواز السفر   ';

  @override
  String get passengerPersonalInfoSubtitle =>
      'يجب أن تطابق البيانات جواز السفر';

  @override
  String get passengerContactInfoSubtitle => 'لإرسال تأكيد الحجز والتحديثات';

  @override
  String get passengerSelectNationality => 'اختر الجنسية';

  @override
  String get passengerSelectCountryCode => 'اختر رمز الدولة';

  @override
  String get passengerSearchCountry => 'ابحث عن الدولة...';

  @override
  String get passengerUploadPassport => 'رفع جواز السفر';

  @override
  String get passengerUploadPassportHint => 'JPG أو PNG أو PDF ';

  @override
  String get passengerChooseFile => 'اختر ملف';

  @override
  String get passengerPassportUploaded => 'تم رفع جواز السفر';

  @override
  String get passengerScanningPassport => 'جارٍ قراءة جواز السفر...';

  @override
  String get passengerScanSuccess => 'تم استخراج البيانات من جواز السفر بنجاح';

  @override
  String get passengerAutoFillBanner =>
      'تم ملء البيانات تلقائياً من جواز السفر — يمكنك تعديلها';

  @override
  String get passengerAutoFilled => 'تلقائي';

  @override
  String get passengerMobileLocalHint => '5X XXX XXXX';

  @override
  String get passengerUploadSourceTitle => 'رفع جواز السفر';

  @override
  String get passengerPickFromGallery => 'من معرض الصور';

  @override
  String get passengerPickFromGalleryHint => 'اختر صورة جواز السفر من ألبومك';

  @override
  String get passengerPickFromFiles => 'من الملفات';

  @override
  String get passengerPickFromFilesHint => 'اختر ملف PDF أو صورة من جهازك';

  @override
  String get passengerUploadFailed =>
      'تعذّر فتح الملفات. أعد تشغيل التطبيق وحاول مجدداً';

  @override
  String get passengerInvalidFileType =>
      'نوع الملف غير مدعوم. استخدم JPG أو PNG أو PDF';

  @override
  String get passengerFormIncomplete => 'يرجى إكمال جميع الحقول المطلوبة';

  @override
  String get seatTitle => 'اختر مقعدك';

  @override
  String get seatAvailable => 'متاح';

  @override
  String get seatSelected => 'محدد';

  @override
  String get seatOccupied => 'محجوز';

  @override
  String get seatPremium => 'مميز';

  @override
  String get seatConfirm => 'تأكيد المقعد';

  @override
  String get seatNoSelection => 'اختر مقعداً للمتابعة';

  @override
  String get seatFirstClass => 'الدرجة الأولى';

  @override
  String get seatBusiness => 'درجة الأعمال';

  @override
  String get seatEconomy => 'الدرجة الاقتصادية';

  @override
  String seatSelectedLabel(String seat) {
    return 'مقعد $seat';
  }

  @override
  String seatExtraCharge(String amount) {
    return '+$amount ر.س';
  }

  @override
  String get paymentTitle => 'الدفع';

  @override
  String get paymentSelectMethod => 'اختر طريقة الدفع';

  @override
  String get paymentCreditCard => 'بطاقة ائتمان';

  @override
  String get paymentApplePay => 'Apple Pay';

  @override
  String get paymentGooglePay => 'Google Pay';

  @override
  String get paymentBankTransfer => 'تحويل بنكي';

  @override
  String paymentPay(String amount) {
    return 'ادفع $amount ر.س';
  }

  @override
  String get paymentProcessing => 'جارٍ المعالجة...';

  @override
  String get paymentFailed => 'فشل الدفع. يرجى المحاولة مجدداً.';

  @override
  String get paymentSummary => 'ملخص الطلب';

  @override
  String get paymentVisaMastercard => 'Visa، Mastercard، Amex';

  @override
  String get paymentApplePaySub => 'ادفع باستخدام Face ID / Touch ID';

  @override
  String get paymentGooglePaySub => 'ادفع باستخدام حساب Google';

  @override
  String get paymentBankTransferSub => 'تحويل بنكي مباشر';

  @override
  String get ticketTitle => 'تذكرتك';

  @override
  String get ticketBoardingPass => 'بطاقة الصعود';

  @override
  String get ticketPassenger => 'المسافر';

  @override
  String get ticketSeat => 'المقعد';

  @override
  String get ticketGate => 'البوابة';

  @override
  String get ticketDate => 'التاريخ';

  @override
  String get ticketCabin => 'الدرجة';

  @override
  String get ticketBoardingTime => 'وقت الصعود';

  @override
  String get ticketDownload => 'تحميل التذكرة';

  @override
  String get ticketShare => 'مشاركة';

  @override
  String get ticketBackHome => 'العودة للرئيسية';

  @override
  String get ticketStatusConfirmed => 'مؤكد';

  @override
  String get ticketStatusCheckedIn => 'تم الإيداع';

  @override
  String get ticketStatusBoarded => 'صعد الطائرة';

  @override
  String get bookingsTitle => 'حجوزاتي';

  @override
  String bookingsUpcoming(int count) {
    return 'القادمة ($count)';
  }

  @override
  String bookingsPast(int count) {
    return 'السابقة ($count)';
  }

  @override
  String get bookingsNoUpcoming => 'لا توجد رحلات قادمة';

  @override
  String get bookingsNoPast => 'لا توجد رحلات سابقة';

  @override
  String get bookingsStatusUpcoming => 'قادمة';

  @override
  String get bookingsStatusCompleted => 'مكتملة';

  @override
  String get bookingsStatusCancelled => 'ملغاة';

  @override
  String get bookingsRef => 'رقم الحجز';

  @override
  String get profileTitle => 'حسابي';

  @override
  String get profileMyBookings => 'حجوزاتي';

  @override
  String get profileNotifications => 'الإشعارات';

  @override
  String get profilePaymentMethods => 'طرق الدفع';

  @override
  String get profileHelp => 'المساعدة والدعم';

  @override
  String get profileAbout => 'عن فلاي فلكس';

  @override
  String get profileSignOut => 'تسجيل الخروج';

  @override
  String get profileSignOutTitle => 'تسجيل الخروج';

  @override
  String get profileSignOutConfirm => 'هل أنت متأكد من تسجيل الخروج؟';

  @override
  String get profileTotalBookings => 'الحجوزات';

  @override
  String get profileTotalFlights => 'الرحلات';

  @override
  String get profileMemberSince => 'عضو منذ';

  @override
  String get profileTierBronze => 'برونزي';

  @override
  String get profileTierSilver => 'فضي';

  @override
  String get profileTierGold => 'ذهبي';

  @override
  String get profileTierPlatinum => 'بلاتيني';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get notificationsEmpty => 'لا توجد إشعارات حتى الآن';

  @override
  String get notificationsMarkAll => 'تحديد الكل كمقروء';

  @override
  String get cabinEconomy => 'اقتصادية';

  @override
  String get cabinBusiness => 'أعمال';

  @override
  String get cabinFirst => 'الدرجة الأولى';

  @override
  String get citiesDomestic => 'داخلية';

  @override
  String get citiesInternational => 'دولية';

  @override
  String get citiesFailedToLoad => 'تعذّر تحميل المدن';

  @override
  String get flightsDomesticRegion => 'المملكة العربية السعودية';

  @override
  String get flightsInternationalRegion => 'حول العالم';

  @override
  String get flightsOnePassenger => 'مسافر واحد';

  @override
  String get flightsNoResultsHint =>
      'جرّب تعديل الفلاتر أو\nالبحث عن مسار مختلف.';

  @override
  String flightsStop(int count) {
    return '$count توقف';
  }

  @override
  String flightsSeatsLeftFull(int count) {
    return 'تبقى $count مقاعد';
  }

  @override
  String homeYouSave(String amount) {
    return 'وفّرت $amount ر.س';
  }

  @override
  String homeDealsCount(int count) {
    return '$count عرض';
  }

  @override
  String get flightDetailsAmenities => 'المرافق';

  @override
  String get flightDetailsSellingFast => 'تبيع بسرعة!';

  @override
  String flightDetailsOnlySeatsLeft(int count) {
    return 'تبقى $count مقعد فقط';
  }

  @override
  String get flightDetailsLoading => 'جارٍ تحميل تفاصيل الرحلة…';

  @override
  String get flightDetailsFailedToLoad => 'تعذّر تحميل التفاصيل';

  @override
  String get flightDetailsTotalPrice => 'السعر الإجمالي';

  @override
  String get flightDetailsInclTaxes => 'شامل الضرائب والرسوم';

  @override
  String flightDetailsSavePercent(int percent) {
    return 'وفّر $percent٪';
  }

  @override
  String get flightDetailsTaxesPercent => 'الضرائب والرسوم (15٪)';

  @override
  String get seatSelectASeat => 'اختر مقعداً';

  @override
  String get seatTotal => 'الإجمالي';

  @override
  String get paymentSecureTitle => 'دفع آمن';

  @override
  String get paymentTotalAmount => 'المبلغ الإجمالي';

  @override
  String get paymentPayNow => 'ادفع الآن';

  @override
  String get paymentDoNotClose => 'يرجى عدم إغلاق هذه الشاشة';

  @override
  String get paymentCardNumber => 'رقم البطاقة';

  @override
  String get paymentCardNumberHint => '0000 0000 0000 0000';

  @override
  String get paymentExpiry => 'تاريخ الانتهاء';

  @override
  String get paymentExpiryHint => 'MM/YY';

  @override
  String get paymentCvv => 'CVV';

  @override
  String get paymentCvvHint => '•••';

  @override
  String get paymentCardHolder => 'حامل البطاقة';

  @override
  String get paymentExpires => 'تنتهي';

  @override
  String get paymentChoosePayment => 'اختر طريقة الدفع';

  @override
  String get paymentAirline => 'شركة الطيران';

  @override
  String get paymentFlyFlexFee => 'رسوم فلاي فلكس';

  @override
  String paymentYouSaveFlyFlex(String amount) {
    return 'وفّرت $amount ر.س مع فلاي فلكس!';
  }

  @override
  String get ticketBookingConfirmed => 'تم تأكيد الحجز!';

  @override
  String get ticketBoardingPassReady => 'بطاقة الصعود جاهزة';

  @override
  String get ticketSavedToDevice => 'تم حفظ التذكرة على الجهاز';

  @override
  String get ticketShareLinkCopied => 'تم نسخ رابط المشاركة';

  @override
  String get ticketViewMyBookings => 'عرض حجوزاتي';

  @override
  String get ticketDuration => 'المدة';

  @override
  String get ticketClass => 'الفئة';

  @override
  String get bookingsNoBookingsYet => 'لا توجد حجوزات بعد';

  @override
  String get bookingsEmptySubtitle =>
      'اكتشف المقاعد الفاخرة غير المباعة\nبأسعار لا تُقاوم';

  @override
  String get bookingsFindFlights => 'ابحث عن رحلات';

  @override
  String get profileLanguage => 'اللغة';

  @override
  String get profileLanguageSubtitle => 'العربية، الإنجليزية';

  @override
  String get profileLanguageArabic => 'العربية';

  @override
  String get profileLanguageEnglish => 'English';

  @override
  String get profilePersonalInfoSubtitle => 'الاسم، البريد، الجوال';

  @override
  String get profileTravelDocSubtitle => 'جواز السفر، الهوية';

  @override
  String get profilePaymentMethodsSubtitle => 'البطاقات، المحافظ الرقمية';

  @override
  String get profileNotificationsSubtitle => 'التنبيهات والتفضيلات';

  @override
  String get profileHelpSubtitle => 'دعم على مدار الساعة';

  @override
  String profileMember(String tier) {
    return 'عضو $tier';
  }

  @override
  String profilePoints(int points) {
    return '$points نقطة';
  }

  @override
  String get dateSelectPlaceholder => 'اختر التاريخ';

  @override
  String get notificationsEmptySubtitle =>
      'سنُعلمك بانخفاض الأسعار\nوتحديثات الحجز.';

  @override
  String get amenitySnacks => 'وجبات خفيفة';

  @override
  String get amenityUsbCharging => 'شحن USB';

  @override
  String get amenityFullMeal => 'وجبة كاملة';

  @override
  String get amenityWifi => 'واي فاي';

  @override
  String get amenityFlatBed => 'سرير مسطح';

  @override
  String get amenityLoungeAccess => 'دخول الصالة';

  @override
  String get amenityAmenityKit => 'حقيبة مستلزمات';

  @override
  String get amenityPrivateSuite => 'جناح خاص';

  @override
  String get amenityBar => 'بار';

  @override
  String get amenityPriorityBoarding => 'صعود أولوية';

  @override
  String get amenityShowerSpa => 'دش وسبا';

  @override
  String get amenityExtraLegroom => 'مساحة إضافية للأرجل';

  @override
  String get amenityEntertainment => 'ترفيه';

  @override
  String get amenityChauffeur => 'خدمة السائق';
}
