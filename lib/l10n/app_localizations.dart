import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'FlyFlex'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Unsold Seats. Your Opportunity.'**
  String get appTagline;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get navAlerts;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @buttonRetry.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get buttonRetry;

  /// No description provided for @buttonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get buttonContinue;

  /// No description provided for @buttonConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get buttonConfirm;

  /// No description provided for @buttonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get buttonCancel;

  /// No description provided for @buttonNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get buttonNext;

  /// No description provided for @buttonGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get buttonGetStarted;

  /// No description provided for @buttonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get buttonSkip;

  /// No description provided for @buttonSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get buttonSignIn;

  /// No description provided for @buttonSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get buttonSignOut;

  /// No description provided for @buttonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get buttonBack;

  /// No description provided for @buttonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get buttonSave;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @errorGeneral.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGeneral;

  /// No description provided for @errorRetry.
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get errorRetry;

  /// No description provided for @errorNoWifi.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errorNoWifi;

  /// No description provided for @statusLive.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get statusLive;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Discover Unsold Seats'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Airlines publish seats not sold before takeoff. You discover them first.'**
  String get onboarding1Subtitle;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Book at Up to 83% Off'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Premium cabin seats at a fraction of the original price. Luxury, redefined.'**
  String get onboarding2Subtitle;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Fly Premium. Pay Less.'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Business and First Class experiences, made accessible. Your upgrade awaits.'**
  String get onboarding3Subtitle;

  /// No description provided for @loginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginWelcome;

  /// No description provided for @loginTagline.
  ///
  /// In en, this message translates to:
  /// **'Sign in to discover premium unsold seats'**
  String get loginTagline;

  /// No description provided for @loginEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get loginEmail;

  /// No description provided for @loginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get loginEmailHint;

  /// No description provided for @loginPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPassword;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get loginPasswordHint;

  /// No description provided for @loginContinueGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get loginContinueGuest;

  /// No description provided for @loginEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get loginEmailRequired;

  /// No description provided for @loginEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get loginEmailInvalid;

  /// No description provided for @loginPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get loginPasswordRequired;

  /// No description provided for @loginPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get loginPasswordMinLength;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Premium Unsold Seats'**
  String get splashTagline;

  /// No description provided for @homeAvailableSeats.
  ///
  /// In en, this message translates to:
  /// **'Available\nSeats Now'**
  String get homeAvailableSeats;

  /// No description provided for @homeAverageSavings.
  ///
  /// In en, this message translates to:
  /// **'Average\nSavings'**
  String get homeAverageSavings;

  /// No description provided for @homePartnerAirlines.
  ///
  /// In en, this message translates to:
  /// **'Partner\nAirlines'**
  String get homePartnerAirlines;

  /// No description provided for @homeHeroTagline.
  ///
  /// In en, this message translates to:
  /// **'Unsold Seats.\nYour Opportunity.'**
  String get homeHeroTagline;

  /// No description provided for @homeHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Premium last-minute seats at up to 83% off.\nAvailable right now.'**
  String get homeHeroSubtitle;

  /// No description provided for @homeFlightCategories.
  ///
  /// In en, this message translates to:
  /// **'Flight Categories'**
  String get homeFlightCategories;

  /// No description provided for @homeDomesticFlights.
  ///
  /// In en, this message translates to:
  /// **'Domestic Flights'**
  String get homeDomesticFlights;

  /// No description provided for @homeInternationalFlights.
  ///
  /// In en, this message translates to:
  /// **'International Flights'**
  String get homeInternationalFlights;

  /// No description provided for @homeDomesticSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore Saudi Arabia'**
  String get homeDomesticSubtitle;

  /// No description provided for @homeInternationalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fly Worldwide'**
  String get homeInternationalSubtitle;

  /// No description provided for @homeLastMinuteDeals.
  ///
  /// In en, this message translates to:
  /// **'Last Minute Deals'**
  String get homeLastMinuteDeals;

  /// No description provided for @homeDealsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Selling fast · Limited seats available'**
  String get homeDealsSubtitle;

  /// No description provided for @homePopularCities.
  ///
  /// In en, this message translates to:
  /// **'Popular Cities'**
  String get homePopularCities;

  /// No description provided for @homeExploreAll.
  ///
  /// In en, this message translates to:
  /// **'Explore all'**
  String get homeExploreAll;

  /// No description provided for @homeRoutes.
  ///
  /// In en, this message translates to:
  /// **'{count} routes'**
  String homeRoutes(int count);

  /// No description provided for @homeDomesticRoutes.
  ///
  /// In en, this message translates to:
  /// **'24 routes'**
  String get homeDomesticRoutes;

  /// No description provided for @homeInternationalRoutes.
  ///
  /// In en, this message translates to:
  /// **'48 routes'**
  String get homeInternationalRoutes;

  /// No description provided for @citiesAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count} cities available'**
  String citiesAvailable(int count);

  /// No description provided for @citiesFlights.
  ///
  /// In en, this message translates to:
  /// **'{count} flights'**
  String citiesFlights(int count);

  /// No description provided for @flightsDomestic.
  ///
  /// In en, this message translates to:
  /// **'Domestic Flights'**
  String get flightsDomestic;

  /// No description provided for @flightsInternational.
  ///
  /// In en, this message translates to:
  /// **'International Flights'**
  String get flightsInternational;

  /// No description provided for @flightsAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get flightsAll;

  /// No description provided for @flightsEconomy.
  ///
  /// In en, this message translates to:
  /// **'Economy'**
  String get flightsEconomy;

  /// No description provided for @flightsBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get flightsBusiness;

  /// No description provided for @flightsFirstClass.
  ///
  /// In en, this message translates to:
  /// **'First Class'**
  String get flightsFirstClass;

  /// No description provided for @flightsDirect.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get flightsDirect;

  /// No description provided for @flightsSeatsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} left'**
  String flightsSeatsLeft(int count);

  /// No description provided for @flightsNoResults.
  ///
  /// In en, this message translates to:
  /// **'No flights available'**
  String get flightsNoResults;

  /// No description provided for @flightsAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available Flights'**
  String get flightsAvailable;

  /// No description provided for @flightsSortPrice.
  ///
  /// In en, this message translates to:
  /// **'Sort by Price'**
  String get flightsSortPrice;

  /// No description provided for @flightsCurrency.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get flightsCurrency;

  /// No description provided for @flightsAirlines.
  ///
  /// In en, this message translates to:
  /// **'Airlines'**
  String get flightsAirlines;

  /// No description provided for @flightsSortAsc.
  ///
  /// In en, this message translates to:
  /// **'Price: Low to High'**
  String get flightsSortAsc;

  /// No description provided for @flightsSortDesc.
  ///
  /// In en, this message translates to:
  /// **'Price: High to Low'**
  String get flightsSortDesc;

  /// No description provided for @flightDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Flight Details'**
  String get flightDetailsTitle;

  /// No description provided for @flightDetailsBookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get flightDetailsBookNow;

  /// No description provided for @flightDetailsPriceBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Price Breakdown'**
  String get flightDetailsPriceBreakdown;

  /// No description provided for @flightDetailsBaseFare.
  ///
  /// In en, this message translates to:
  /// **'Base Fare'**
  String get flightDetailsBaseFare;

  /// No description provided for @flightDetailsTaxes.
  ///
  /// In en, this message translates to:
  /// **'Taxes & Fees'**
  String get flightDetailsTaxes;

  /// No description provided for @flightDetailsServiceFee.
  ///
  /// In en, this message translates to:
  /// **'FlyFlex Service Fee'**
  String get flightDetailsServiceFee;

  /// No description provided for @flightDetailsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get flightDetailsTotal;

  /// No description provided for @flightDetailsSavings.
  ///
  /// In en, this message translates to:
  /// **'You save SAR {amount} ({percent}%)'**
  String flightDetailsSavings(String amount, int percent);

  /// No description provided for @flightDetailsInfo.
  ///
  /// In en, this message translates to:
  /// **'Flight Information'**
  String get flightDetailsInfo;

  /// No description provided for @flightDetailsAircraft.
  ///
  /// In en, this message translates to:
  /// **'Aircraft'**
  String get flightDetailsAircraft;

  /// No description provided for @flightDetailsDepartureTerminal.
  ///
  /// In en, this message translates to:
  /// **'Departure Terminal'**
  String get flightDetailsDepartureTerminal;

  /// No description provided for @flightDetailsArrivalTerminal.
  ///
  /// In en, this message translates to:
  /// **'Arrival Terminal'**
  String get flightDetailsArrivalTerminal;

  /// No description provided for @flightDetailsBaggage.
  ///
  /// In en, this message translates to:
  /// **'Baggage Allowance'**
  String get flightDetailsBaggage;

  /// No description provided for @flightDetailsOnTime.
  ///
  /// In en, this message translates to:
  /// **'On-time Rate'**
  String get flightDetailsOnTime;

  /// No description provided for @flightDetailsRefund.
  ///
  /// In en, this message translates to:
  /// **'Refund Policy'**
  String get flightDetailsRefund;

  /// No description provided for @flightDetailsBoardBy.
  ///
  /// In en, this message translates to:
  /// **'Board by {time}'**
  String flightDetailsBoardBy(String time);

  /// No description provided for @flightDetailsSeatsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} seats left'**
  String flightDetailsSeatsLeft(int count);

  /// No description provided for @flightDetailsCabin.
  ///
  /// In en, this message translates to:
  /// **'Cabin'**
  String get flightDetailsCabin;

  /// No description provided for @flightDetailsStops.
  ///
  /// In en, this message translates to:
  /// **'Stops'**
  String get flightDetailsStops;

  /// No description provided for @flightDetailsNonStop.
  ///
  /// In en, this message translates to:
  /// **'Non-stop'**
  String get flightDetailsNonStop;

  /// No description provided for @passengerTitle.
  ///
  /// In en, this message translates to:
  /// **'Passenger Details'**
  String get passengerTitle;

  /// No description provided for @passengerFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get passengerFirstName;

  /// No description provided for @passengerFirstNameHint.
  ///
  /// In en, this message translates to:
  /// **'As in passport'**
  String get passengerFirstNameHint;

  /// No description provided for @passengerLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get passengerLastName;

  /// No description provided for @passengerLastNameHint.
  ///
  /// In en, this message translates to:
  /// **'As in passport'**
  String get passengerLastNameHint;

  /// No description provided for @passengerDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get passengerDateOfBirth;

  /// No description provided for @passengerGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get passengerGender;

  /// No description provided for @passengerGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get passengerGenderMale;

  /// No description provided for @passengerGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get passengerGenderFemale;

  /// No description provided for @passengerPassportNumber.
  ///
  /// In en, this message translates to:
  /// **'Passport Number'**
  String get passengerPassportNumber;

  /// No description provided for @passengerPassportNumberHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. A12345678'**
  String get passengerPassportNumberHint;

  /// No description provided for @passengerPassportExpiry.
  ///
  /// In en, this message translates to:
  /// **'Passport Expiry Date'**
  String get passengerPassportExpiry;

  /// No description provided for @passengerNationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get passengerNationality;

  /// No description provided for @passengerNationalityHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Saudi Arabian'**
  String get passengerNationalityHint;

  /// No description provided for @passengerNationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID / Iqama'**
  String get passengerNationalId;

  /// No description provided for @passengerNationalIdHint.
  ///
  /// In en, this message translates to:
  /// **'10-digit ID number'**
  String get passengerNationalIdHint;

  /// No description provided for @passengerMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get passengerMobile;

  /// No description provided for @passengerMobileHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. +966 5X XXX XXXX'**
  String get passengerMobileHint;

  /// No description provided for @passengerEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get passengerEmail;

  /// No description provided for @passengerEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get passengerEmailHint;

  /// No description provided for @passengerContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue to Seat Selection'**
  String get passengerContinue;

  /// No description provided for @passengerRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get passengerRequired;

  /// No description provided for @passengerInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get passengerInvalidEmail;

  /// No description provided for @passengerInvalidMobile.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid mobile number'**
  String get passengerInvalidMobile;

  /// No description provided for @passengerInvalidPassport.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid passport number'**
  String get passengerInvalidPassport;

  /// No description provided for @passengerInvalidNationalId.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid ID number (10 digits)'**
  String get passengerInvalidNationalId;

  /// No description provided for @passengerExpiredPassport.
  ///
  /// In en, this message translates to:
  /// **'Passport must not be expired'**
  String get passengerExpiredPassport;

  /// No description provided for @passengerFlightSummary.
  ///
  /// In en, this message translates to:
  /// **'Flight Summary'**
  String get passengerFlightSummary;

  /// No description provided for @passengerPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get passengerPersonalInfo;

  /// No description provided for @passengerTravelDoc.
  ///
  /// In en, this message translates to:
  /// **'Travel Documents'**
  String get passengerTravelDoc;

  /// No description provided for @passengerContactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get passengerContactInfo;

  /// No description provided for @passengerTravelDocSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload your passport to auto-fill details'**
  String get passengerTravelDocSubtitle;

  /// No description provided for @passengerPersonalInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Details must match your passport'**
  String get passengerPersonalInfoSubtitle;

  /// No description provided for @passengerContactInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For booking confirmation and updates'**
  String get passengerContactInfoSubtitle;

  /// No description provided for @passengerSelectNationality.
  ///
  /// In en, this message translates to:
  /// **'Select nationality'**
  String get passengerSelectNationality;

  /// No description provided for @passengerSelectCountryCode.
  ///
  /// In en, this message translates to:
  /// **'Select country code'**
  String get passengerSelectCountryCode;

  /// No description provided for @passengerSearchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search country...'**
  String get passengerSearchCountry;

  /// No description provided for @passengerUploadPassport.
  ///
  /// In en, this message translates to:
  /// **'Upload passport'**
  String get passengerUploadPassport;

  /// No description provided for @passengerUploadPassportHint.
  ///
  /// In en, this message translates to:
  /// **'JPG, PNG or PDF — data will be extracted automatically'**
  String get passengerUploadPassportHint;

  /// No description provided for @passengerChooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get passengerChooseFile;

  /// No description provided for @passengerPassportUploaded.
  ///
  /// In en, this message translates to:
  /// **'Passport uploaded'**
  String get passengerPassportUploaded;

  /// No description provided for @passengerScanningPassport.
  ///
  /// In en, this message translates to:
  /// **'Reading passport...'**
  String get passengerScanningPassport;

  /// No description provided for @passengerScanSuccess.
  ///
  /// In en, this message translates to:
  /// **'Passport data extracted successfully'**
  String get passengerScanSuccess;

  /// No description provided for @passengerAutoFillBanner.
  ///
  /// In en, this message translates to:
  /// **'Details auto-filled from passport — you can edit them'**
  String get passengerAutoFillBanner;

  /// No description provided for @passengerAutoFilled.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get passengerAutoFilled;

  /// No description provided for @passengerMobileLocalHint.
  ///
  /// In en, this message translates to:
  /// **'5X XXX XXXX'**
  String get passengerMobileLocalHint;

  /// No description provided for @passengerUploadSourceTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload passport'**
  String get passengerUploadSourceTitle;

  /// No description provided for @passengerPickFromGallery.
  ///
  /// In en, this message translates to:
  /// **'From photo gallery'**
  String get passengerPickFromGallery;

  /// No description provided for @passengerPickFromGalleryHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a passport photo from your album'**
  String get passengerPickFromGalleryHint;

  /// No description provided for @passengerPickFromFiles.
  ///
  /// In en, this message translates to:
  /// **'From files'**
  String get passengerPickFromFiles;

  /// No description provided for @passengerPickFromFilesHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a PDF or image from your device'**
  String get passengerPickFromFilesHint;

  /// No description provided for @passengerUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open files. Restart the app and try again'**
  String get passengerUploadFailed;

  /// No description provided for @passengerInvalidFileType.
  ///
  /// In en, this message translates to:
  /// **'Unsupported file type. Use JPG, PNG or PDF'**
  String get passengerInvalidFileType;

  /// No description provided for @passengerFormIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Please complete all required fields'**
  String get passengerFormIncomplete;

  /// No description provided for @seatTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Your Seat'**
  String get seatTitle;

  /// No description provided for @seatAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get seatAvailable;

  /// No description provided for @seatSelected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get seatSelected;

  /// No description provided for @seatOccupied.
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get seatOccupied;

  /// No description provided for @seatPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get seatPremium;

  /// No description provided for @seatConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm Seat'**
  String get seatConfirm;

  /// No description provided for @seatNoSelection.
  ///
  /// In en, this message translates to:
  /// **'Select a seat to continue'**
  String get seatNoSelection;

  /// No description provided for @seatFirstClass.
  ///
  /// In en, this message translates to:
  /// **'First Class'**
  String get seatFirstClass;

  /// No description provided for @seatBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business Class'**
  String get seatBusiness;

  /// No description provided for @seatEconomy.
  ///
  /// In en, this message translates to:
  /// **'Economy'**
  String get seatEconomy;

  /// No description provided for @seatSelectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Seat {seat}'**
  String seatSelectedLabel(String seat);

  /// No description provided for @seatExtraCharge.
  ///
  /// In en, this message translates to:
  /// **'+SAR {amount}'**
  String seatExtraCharge(String amount);

  /// No description provided for @paymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get paymentTitle;

  /// No description provided for @paymentSelectMethod.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get paymentSelectMethod;

  /// No description provided for @paymentCreditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get paymentCreditCard;

  /// No description provided for @paymentApplePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get paymentApplePay;

  /// No description provided for @paymentGooglePay.
  ///
  /// In en, this message translates to:
  /// **'Google Pay'**
  String get paymentGooglePay;

  /// No description provided for @paymentBankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get paymentBankTransfer;

  /// No description provided for @paymentPay.
  ///
  /// In en, this message translates to:
  /// **'Pay SAR {amount}'**
  String paymentPay(String amount);

  /// No description provided for @paymentProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get paymentProcessing;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed. Please try again.'**
  String get paymentFailed;

  /// No description provided for @paymentSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get paymentSummary;

  /// No description provided for @paymentVisaMastercard.
  ///
  /// In en, this message translates to:
  /// **'Visa, Mastercard, Amex'**
  String get paymentVisaMastercard;

  /// No description provided for @paymentApplePaySub.
  ///
  /// In en, this message translates to:
  /// **'Pay with Face ID / Touch ID'**
  String get paymentApplePaySub;

  /// No description provided for @paymentGooglePaySub.
  ///
  /// In en, this message translates to:
  /// **'Pay with Google account'**
  String get paymentGooglePaySub;

  /// No description provided for @paymentBankTransferSub.
  ///
  /// In en, this message translates to:
  /// **'Direct bank transfer'**
  String get paymentBankTransferSub;

  /// No description provided for @ticketTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Ticket'**
  String get ticketTitle;

  /// No description provided for @ticketBoardingPass.
  ///
  /// In en, this message translates to:
  /// **'BOARDING PASS'**
  String get ticketBoardingPass;

  /// No description provided for @ticketPassenger.
  ///
  /// In en, this message translates to:
  /// **'Passenger'**
  String get ticketPassenger;

  /// No description provided for @ticketSeat.
  ///
  /// In en, this message translates to:
  /// **'Seat'**
  String get ticketSeat;

  /// No description provided for @ticketGate.
  ///
  /// In en, this message translates to:
  /// **'Gate'**
  String get ticketGate;

  /// No description provided for @ticketDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get ticketDate;

  /// No description provided for @ticketCabin.
  ///
  /// In en, this message translates to:
  /// **'Cabin'**
  String get ticketCabin;

  /// No description provided for @ticketBoardingTime.
  ///
  /// In en, this message translates to:
  /// **'Boarding'**
  String get ticketBoardingTime;

  /// No description provided for @ticketDownload.
  ///
  /// In en, this message translates to:
  /// **'Download Ticket'**
  String get ticketDownload;

  /// No description provided for @ticketShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get ticketShare;

  /// No description provided for @ticketBackHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get ticketBackHome;

  /// No description provided for @ticketStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'CONFIRMED'**
  String get ticketStatusConfirmed;

  /// No description provided for @ticketStatusCheckedIn.
  ///
  /// In en, this message translates to:
  /// **'CHECKED IN'**
  String get ticketStatusCheckedIn;

  /// No description provided for @ticketStatusBoarded.
  ///
  /// In en, this message translates to:
  /// **'BOARDED'**
  String get ticketStatusBoarded;

  /// No description provided for @bookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Bookings'**
  String get bookingsTitle;

  /// No description provided for @bookingsUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming ({count})'**
  String bookingsUpcoming(int count);

  /// No description provided for @bookingsPast.
  ///
  /// In en, this message translates to:
  /// **'Past ({count})'**
  String bookingsPast(int count);

  /// No description provided for @bookingsNoUpcoming.
  ///
  /// In en, this message translates to:
  /// **'No upcoming trips'**
  String get bookingsNoUpcoming;

  /// No description provided for @bookingsNoPast.
  ///
  /// In en, this message translates to:
  /// **'No past trips'**
  String get bookingsNoPast;

  /// No description provided for @bookingsStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get bookingsStatusUpcoming;

  /// No description provided for @bookingsStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get bookingsStatusCompleted;

  /// No description provided for @bookingsStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get bookingsStatusCancelled;

  /// No description provided for @bookingsRef.
  ///
  /// In en, this message translates to:
  /// **'Ref'**
  String get bookingsRef;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileMyBookings.
  ///
  /// In en, this message translates to:
  /// **'My Bookings'**
  String get profileMyBookings;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// No description provided for @profilePaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get profilePaymentMethods;

  /// No description provided for @profileHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get profileHelp;

  /// No description provided for @profileAbout.
  ///
  /// In en, this message translates to:
  /// **'About FlyFlex'**
  String get profileAbout;

  /// No description provided for @profileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOut;

  /// No description provided for @profileSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOutTitle;

  /// No description provided for @profileSignOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get profileSignOutConfirm;

  /// No description provided for @profileTotalBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get profileTotalBookings;

  /// No description provided for @profileTotalFlights.
  ///
  /// In en, this message translates to:
  /// **'Flights'**
  String get profileTotalFlights;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get profileMemberSince;

  /// No description provided for @profileTierBronze.
  ///
  /// In en, this message translates to:
  /// **'Bronze'**
  String get profileTierBronze;

  /// No description provided for @profileTierSilver.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get profileTierSilver;

  /// No description provided for @profileTierGold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get profileTierGold;

  /// No description provided for @profileTierPlatinum.
  ///
  /// In en, this message translates to:
  /// **'Platinum'**
  String get profileTierPlatinum;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notificationsEmpty;

  /// No description provided for @notificationsMarkAll.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notificationsMarkAll;

  /// No description provided for @cabinEconomy.
  ///
  /// In en, this message translates to:
  /// **'Economy'**
  String get cabinEconomy;

  /// No description provided for @cabinBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get cabinBusiness;

  /// No description provided for @cabinFirst.
  ///
  /// In en, this message translates to:
  /// **'First Class'**
  String get cabinFirst;

  /// No description provided for @citiesDomestic.
  ///
  /// In en, this message translates to:
  /// **'Domestic'**
  String get citiesDomestic;

  /// No description provided for @citiesInternational.
  ///
  /// In en, this message translates to:
  /// **'International'**
  String get citiesInternational;

  /// No description provided for @citiesFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load cities'**
  String get citiesFailedToLoad;

  /// No description provided for @flightsDomesticRegion.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get flightsDomesticRegion;

  /// No description provided for @flightsInternationalRegion.
  ///
  /// In en, this message translates to:
  /// **'Worldwide'**
  String get flightsInternationalRegion;

  /// No description provided for @flightsOnePassenger.
  ///
  /// In en, this message translates to:
  /// **'1 Passenger'**
  String get flightsOnePassenger;

  /// No description provided for @flightsNoResultsHint.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters or\nsearch for a different route.'**
  String get flightsNoResultsHint;

  /// No description provided for @flightsStop.
  ///
  /// In en, this message translates to:
  /// **'{count} Stop'**
  String flightsStop(int count);

  /// No description provided for @flightsSeatsLeftFull.
  ///
  /// In en, this message translates to:
  /// **'{count} seats left'**
  String flightsSeatsLeftFull(int count);

  /// No description provided for @homeYouSave.
  ///
  /// In en, this message translates to:
  /// **'You save SAR {amount}'**
  String homeYouSave(String amount);

  /// No description provided for @homeDealsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} deals'**
  String homeDealsCount(int count);

  /// No description provided for @flightDetailsAmenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get flightDetailsAmenities;

  /// No description provided for @flightDetailsSellingFast.
  ///
  /// In en, this message translates to:
  /// **'Selling Fast!'**
  String get flightDetailsSellingFast;

  /// No description provided for @flightDetailsOnlySeatsLeft.
  ///
  /// In en, this message translates to:
  /// **'Only {count} seat(s) left'**
  String flightDetailsOnlySeatsLeft(int count);

  /// No description provided for @flightDetailsLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading flight details…'**
  String get flightDetailsLoading;

  /// No description provided for @flightDetailsFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load details'**
  String get flightDetailsFailedToLoad;

  /// No description provided for @flightDetailsTotalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get flightDetailsTotalPrice;

  /// No description provided for @flightDetailsInclTaxes.
  ///
  /// In en, this message translates to:
  /// **'incl. taxes & fees'**
  String get flightDetailsInclTaxes;

  /// No description provided for @flightDetailsSavePercent.
  ///
  /// In en, this message translates to:
  /// **'Save {percent}%'**
  String flightDetailsSavePercent(int percent);

  /// No description provided for @flightDetailsTaxesPercent.
  ///
  /// In en, this message translates to:
  /// **'Taxes & Fees (15%)'**
  String get flightDetailsTaxesPercent;

  /// No description provided for @seatSelectASeat.
  ///
  /// In en, this message translates to:
  /// **'Select a Seat'**
  String get seatSelectASeat;

  /// No description provided for @seatTotal.
  ///
  /// In en, this message translates to:
  /// **'total'**
  String get seatTotal;

  /// No description provided for @paymentSecureTitle.
  ///
  /// In en, this message translates to:
  /// **'Secure Payment'**
  String get paymentSecureTitle;

  /// No description provided for @paymentTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get paymentTotalAmount;

  /// No description provided for @paymentPayNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get paymentPayNow;

  /// No description provided for @paymentDoNotClose.
  ///
  /// In en, this message translates to:
  /// **'Please do not close this screen'**
  String get paymentDoNotClose;

  /// No description provided for @paymentCardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get paymentCardNumber;

  /// No description provided for @paymentCardNumberHint.
  ///
  /// In en, this message translates to:
  /// **'0000 0000 0000 0000'**
  String get paymentCardNumberHint;

  /// No description provided for @paymentExpiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry'**
  String get paymentExpiry;

  /// No description provided for @paymentExpiryHint.
  ///
  /// In en, this message translates to:
  /// **'MM/YY'**
  String get paymentExpiryHint;

  /// No description provided for @paymentCvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get paymentCvv;

  /// No description provided for @paymentCvvHint.
  ///
  /// In en, this message translates to:
  /// **'•••'**
  String get paymentCvvHint;

  /// No description provided for @paymentCardHolder.
  ///
  /// In en, this message translates to:
  /// **'CARD HOLDER'**
  String get paymentCardHolder;

  /// No description provided for @paymentExpires.
  ///
  /// In en, this message translates to:
  /// **'EXPIRES'**
  String get paymentExpires;

  /// No description provided for @paymentChoosePayment.
  ///
  /// In en, this message translates to:
  /// **'Choose Payment'**
  String get paymentChoosePayment;

  /// No description provided for @paymentAirline.
  ///
  /// In en, this message translates to:
  /// **'Airline'**
  String get paymentAirline;

  /// No description provided for @paymentFlyFlexFee.
  ///
  /// In en, this message translates to:
  /// **'FlyFlex Fee'**
  String get paymentFlyFlexFee;

  /// No description provided for @paymentYouSaveFlyFlex.
  ///
  /// In en, this message translates to:
  /// **'You save SAR {amount} with FlyFlex!'**
  String paymentYouSaveFlyFlex(String amount);

  /// No description provided for @ticketBookingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed!'**
  String get ticketBookingConfirmed;

  /// No description provided for @ticketBoardingPassReady.
  ///
  /// In en, this message translates to:
  /// **'Your boarding pass is ready'**
  String get ticketBoardingPassReady;

  /// No description provided for @ticketSavedToDevice.
  ///
  /// In en, this message translates to:
  /// **'Ticket saved to device'**
  String get ticketSavedToDevice;

  /// No description provided for @ticketShareLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Share link copied'**
  String get ticketShareLinkCopied;

  /// No description provided for @ticketViewMyBookings.
  ///
  /// In en, this message translates to:
  /// **'View My Bookings'**
  String get ticketViewMyBookings;

  /// No description provided for @ticketDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get ticketDuration;

  /// No description provided for @ticketClass.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get ticketClass;

  /// No description provided for @bookingsNoBookingsYet.
  ///
  /// In en, this message translates to:
  /// **'No bookings yet'**
  String get bookingsNoBookingsYet;

  /// No description provided for @bookingsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover premium unsold seats\nat unbeatable prices'**
  String get bookingsEmptySubtitle;

  /// No description provided for @bookingsFindFlights.
  ///
  /// In en, this message translates to:
  /// **'Find Flights'**
  String get bookingsFindFlights;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Arabic, English'**
  String get profileLanguageSubtitle;

  /// No description provided for @profileLanguageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get profileLanguageArabic;

  /// No description provided for @profileLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get profileLanguageEnglish;

  /// No description provided for @profilePersonalInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Name, email, phone'**
  String get profilePersonalInfoSubtitle;

  /// No description provided for @profileTravelDocSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Passport, ID'**
  String get profileTravelDocSubtitle;

  /// No description provided for @profilePaymentMethodsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Cards, digital wallets'**
  String get profilePaymentMethodsSubtitle;

  /// No description provided for @profileNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Alerts & preferences'**
  String get profileNotificationsSubtitle;

  /// No description provided for @profileHelpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'24/7 assistance'**
  String get profileHelpSubtitle;

  /// No description provided for @profileMember.
  ///
  /// In en, this message translates to:
  /// **'{tier} Member'**
  String profileMember(String tier);

  /// No description provided for @profilePoints.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String profilePoints(int points);

  /// No description provided for @dateSelectPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get dateSelectPlaceholder;

  /// No description provided for @notificationsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll notify you about price drops\nand booking updates.'**
  String get notificationsEmptySubtitle;

  /// No description provided for @amenitySnacks.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get amenitySnacks;

  /// No description provided for @amenityUsbCharging.
  ///
  /// In en, this message translates to:
  /// **'USB Charging'**
  String get amenityUsbCharging;

  /// No description provided for @amenityFullMeal.
  ///
  /// In en, this message translates to:
  /// **'Full Meal'**
  String get amenityFullMeal;

  /// No description provided for @amenityWifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get amenityWifi;

  /// No description provided for @amenityFlatBed.
  ///
  /// In en, this message translates to:
  /// **'Flat Bed'**
  String get amenityFlatBed;

  /// No description provided for @amenityLoungeAccess.
  ///
  /// In en, this message translates to:
  /// **'Lounge Access'**
  String get amenityLoungeAccess;

  /// No description provided for @amenityAmenityKit.
  ///
  /// In en, this message translates to:
  /// **'Amenity Kit'**
  String get amenityAmenityKit;

  /// No description provided for @amenityPrivateSuite.
  ///
  /// In en, this message translates to:
  /// **'Private Suite'**
  String get amenityPrivateSuite;

  /// No description provided for @amenityBar.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get amenityBar;

  /// No description provided for @amenityPriorityBoarding.
  ///
  /// In en, this message translates to:
  /// **'Priority Boarding'**
  String get amenityPriorityBoarding;

  /// No description provided for @amenityShowerSpa.
  ///
  /// In en, this message translates to:
  /// **'Shower Spa'**
  String get amenityShowerSpa;

  /// No description provided for @amenityExtraLegroom.
  ///
  /// In en, this message translates to:
  /// **'Extra Legroom'**
  String get amenityExtraLegroom;

  /// No description provided for @amenityEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get amenityEntertainment;

  /// No description provided for @amenityChauffeur.
  ///
  /// In en, this message translates to:
  /// **'Chauffeur Service'**
  String get amenityChauffeur;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
