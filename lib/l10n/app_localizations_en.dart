// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'FlyFlex';

  @override
  String get appTagline => 'Unsold Seats. Your Opportunity.';

  @override
  String get navHome => 'Home';

  @override
  String get navBookings => 'Bookings';

  @override
  String get navAlerts => 'Alerts';

  @override
  String get navProfile => 'Profile';

  @override
  String get buttonRetry => 'Try Again';

  @override
  String get buttonContinue => 'Continue';

  @override
  String get buttonConfirm => 'Confirm';

  @override
  String get buttonCancel => 'Cancel';

  @override
  String get buttonNext => 'Next';

  @override
  String get buttonGetStarted => 'Get Started';

  @override
  String get buttonSkip => 'Skip';

  @override
  String get buttonSignIn => 'Sign In';

  @override
  String get buttonSignOut => 'Sign Out';

  @override
  String get buttonBack => 'Back';

  @override
  String get buttonSave => 'Save';

  @override
  String get loading => 'Loading...';

  @override
  String get errorGeneral => 'Something went wrong';

  @override
  String get errorRetry => 'Please try again';

  @override
  String get errorNoWifi => 'No internet connection';

  @override
  String get statusLive => 'LIVE';

  @override
  String get onboarding1Title => 'Discover Unsold Seats';

  @override
  String get onboarding1Subtitle =>
      'Airlines publish seats not sold before takeoff. You discover them first.';

  @override
  String get onboarding2Title => 'Book at Up to 83% Off';

  @override
  String get onboarding2Subtitle =>
      'Premium cabin seats at a fraction of the original price. Luxury, redefined.';

  @override
  String get onboarding3Title => 'Fly Premium. Pay Less.';

  @override
  String get onboarding3Subtitle =>
      'Business and First Class experiences, made accessible. Your upgrade awaits.';

  @override
  String get loginWelcome => 'Welcome Back';

  @override
  String get loginTagline => 'Sign in to discover premium unsold seats';

  @override
  String get loginEmail => 'Email Address';

  @override
  String get loginEmailHint => 'you@example.com';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginContinueGuest => 'Continue as Guest';

  @override
  String get loginEmailRequired => 'Email is required';

  @override
  String get loginEmailInvalid => 'Enter a valid email address';

  @override
  String get loginPasswordRequired => 'Password is required';

  @override
  String get loginPasswordMinLength => 'Password must be at least 6 characters';

  @override
  String get splashTagline => 'Premium Unsold Seats';

  @override
  String get homeAvailableSeats => 'Available\nSeats Now';

  @override
  String get homeAverageSavings => 'Average\nSavings';

  @override
  String get homePartnerAirlines => 'Partner\nAirlines';

  @override
  String get homeHeroTagline => 'Unsold Seats.\nYour Opportunity.';

  @override
  String get homeHeroSubtitle =>
      'Premium last-minute seats at up to 83% off.\nAvailable right now.';

  @override
  String get homeFlightCategories => 'Flight Categories';

  @override
  String get homeDomesticFlights => 'Domestic Flights';

  @override
  String get homeInternationalFlights => 'International Flights';

  @override
  String get homeDomesticSubtitle => 'Explore Saudi Arabia';

  @override
  String get homeInternationalSubtitle => 'Fly Worldwide';

  @override
  String get homeLastMinuteDeals => 'Last Minute Deals';

  @override
  String get homeDealsSubtitle => 'Selling fast · Limited seats available';

  @override
  String get homePopularCities => 'Popular Cities';

  @override
  String get homeExploreAll => 'Explore all';

  @override
  String homeRoutes(int count) {
    return '$count routes';
  }

  @override
  String get homeDomesticRoutes => '24 routes';

  @override
  String get homeInternationalRoutes => '48 routes';

  @override
  String citiesAvailable(int count) {
    return '$count cities available';
  }

  @override
  String citiesFlights(int count) {
    return '$count flights';
  }

  @override
  String get flightsDomestic => 'Domestic Flights';

  @override
  String get flightsInternational => 'International Flights';

  @override
  String get flightsAll => 'All';

  @override
  String get flightsEconomy => 'Economy';

  @override
  String get flightsBusiness => 'Business';

  @override
  String get flightsFirstClass => 'First Class';

  @override
  String get flightsDirect => 'Direct';

  @override
  String flightsSeatsLeft(int count) {
    return '$count left';
  }

  @override
  String get flightsNoResults => 'No flights available';

  @override
  String get flightsAvailable => 'Available Flights';

  @override
  String get flightsSortPrice => 'Sort by Price';

  @override
  String get flightsCurrency => 'SAR';

  @override
  String get flightsAirlines => 'Airlines';

  @override
  String get flightsSortAsc => 'Price: Low to High';

  @override
  String get flightsSortDesc => 'Price: High to Low';

  @override
  String get flightDetailsTitle => 'Flight Details';

  @override
  String get flightDetailsBookNow => 'Book Now';

  @override
  String get flightDetailsPriceBreakdown => 'Price Breakdown';

  @override
  String get flightDetailsBaseFare => 'Base Fare';

  @override
  String get flightDetailsTaxes => 'Taxes & Fees';

  @override
  String get flightDetailsServiceFee => 'FlyFlex Service Fee';

  @override
  String get flightDetailsTotal => 'Total';

  @override
  String flightDetailsSavings(String amount, int percent) {
    return 'You save SAR $amount ($percent%)';
  }

  @override
  String get flightDetailsInfo => 'Flight Information';

  @override
  String get flightDetailsAircraft => 'Aircraft';

  @override
  String get flightDetailsDepartureTerminal => 'Departure Terminal';

  @override
  String get flightDetailsArrivalTerminal => 'Arrival Terminal';

  @override
  String get flightDetailsBaggage => 'Baggage Allowance';

  @override
  String get flightDetailsOnTime => 'On-time Rate';

  @override
  String get flightDetailsRefund => 'Refund Policy';

  @override
  String flightDetailsBoardBy(String time) {
    return 'Board by $time';
  }

  @override
  String flightDetailsSeatsLeft(int count) {
    return '$count seats left';
  }

  @override
  String get flightDetailsCabin => 'Cabin';

  @override
  String get flightDetailsStops => 'Stops';

  @override
  String get flightDetailsNonStop => 'Non-stop';

  @override
  String get passengerTitle => 'Passenger Details';

  @override
  String get passengerFirstName => 'First Name';

  @override
  String get passengerFirstNameHint => 'As in passport';

  @override
  String get passengerLastName => 'Last Name';

  @override
  String get passengerLastNameHint => 'As in passport';

  @override
  String get passengerDateOfBirth => 'Date of Birth';

  @override
  String get passengerGender => 'Gender';

  @override
  String get passengerGenderMale => 'Male';

  @override
  String get passengerGenderFemale => 'Female';

  @override
  String get passengerPassportNumber => 'Passport Number';

  @override
  String get passengerPassportNumberHint => 'e.g. A12345678';

  @override
  String get passengerPassportExpiry => 'Passport Expiry Date';

  @override
  String get passengerNationality => 'Nationality';

  @override
  String get passengerNationalityHint => 'e.g. Saudi Arabian';

  @override
  String get passengerNationalId => 'National ID / Iqama';

  @override
  String get passengerNationalIdHint => '10-digit ID number';

  @override
  String get passengerMobile => 'Mobile Number';

  @override
  String get passengerMobileHint => 'e.g. +966 5X XXX XXXX';

  @override
  String get passengerEmail => 'Email Address';

  @override
  String get passengerEmailHint => 'Optional';

  @override
  String get passengerContinue => 'Continue to Seat Selection';

  @override
  String get passengerRequired => 'This field is required';

  @override
  String get passengerInvalidEmail => 'Enter a valid email address';

  @override
  String get passengerInvalidMobile => 'Enter a valid mobile number';

  @override
  String get passengerInvalidPassport => 'Enter a valid passport number';

  @override
  String get passengerInvalidNationalId =>
      'Enter a valid ID number (10 digits)';

  @override
  String get passengerExpiredPassport => 'Passport must not be expired';

  @override
  String get passengerFlightSummary => 'Flight Summary';

  @override
  String get passengerPersonalInfo => 'Personal Information';

  @override
  String get passengerTravelDoc => 'Travel Documents';

  @override
  String get passengerContactInfo => 'Contact Information';

  @override
  String get passengerTravelDocSubtitle =>
      'Upload your passport to auto-fill details';

  @override
  String get passengerPersonalInfoSubtitle =>
      'Details must match your passport';

  @override
  String get passengerContactInfoSubtitle =>
      'For booking confirmation and updates';

  @override
  String get passengerSelectNationality => 'Select nationality';

  @override
  String get passengerSelectCountryCode => 'Select country code';

  @override
  String get passengerSearchCountry => 'Search country...';

  @override
  String get passengerUploadPassport => 'Upload passport';

  @override
  String get passengerUploadPassportHint =>
      'JPG, PNG or PDF — data will be extracted automatically';

  @override
  String get passengerChooseFile => 'Choose file';

  @override
  String get passengerPassportUploaded => 'Passport uploaded';

  @override
  String get passengerScanningPassport => 'Reading passport...';

  @override
  String get passengerScanSuccess => 'Passport data extracted successfully';

  @override
  String get passengerAutoFillBanner =>
      'Details auto-filled from passport — you can edit them';

  @override
  String get passengerAutoFilled => 'Auto';

  @override
  String get passengerMobileLocalHint => '5X XXX XXXX';

  @override
  String get passengerUploadSourceTitle => 'Upload passport';

  @override
  String get passengerPickFromGallery => 'From photo gallery';

  @override
  String get passengerPickFromGalleryHint =>
      'Choose a passport photo from your album';

  @override
  String get passengerPickFromFiles => 'From files';

  @override
  String get passengerPickFromFilesHint =>
      'Choose a PDF or image from your device';

  @override
  String get passengerUploadFailed =>
      'Could not open files. Restart the app and try again';

  @override
  String get passengerInvalidFileType =>
      'Unsupported file type. Use JPG, PNG or PDF';

  @override
  String get passengerFormIncomplete => 'Please complete all required fields';

  @override
  String get seatTitle => 'Select Your Seat';

  @override
  String get seatAvailable => 'Available';

  @override
  String get seatSelected => 'Selected';

  @override
  String get seatOccupied => 'Occupied';

  @override
  String get seatPremium => 'Premium';

  @override
  String get seatConfirm => 'Confirm Seat';

  @override
  String get seatNoSelection => 'Select a seat to continue';

  @override
  String get seatFirstClass => 'First Class';

  @override
  String get seatBusiness => 'Business Class';

  @override
  String get seatEconomy => 'Economy';

  @override
  String seatSelectedLabel(String seat) {
    return 'Seat $seat';
  }

  @override
  String seatExtraCharge(String amount) {
    return '+SAR $amount';
  }

  @override
  String get paymentTitle => 'Payment';

  @override
  String get paymentSelectMethod => 'Select Payment Method';

  @override
  String get paymentCreditCard => 'Credit Card';

  @override
  String get paymentApplePay => 'Apple Pay';

  @override
  String get paymentGooglePay => 'Google Pay';

  @override
  String get paymentBankTransfer => 'Bank Transfer';

  @override
  String paymentPay(String amount) {
    return 'Pay SAR $amount';
  }

  @override
  String get paymentProcessing => 'Processing...';

  @override
  String get paymentFailed => 'Payment failed. Please try again.';

  @override
  String get paymentSummary => 'Order Summary';

  @override
  String get paymentVisaMastercard => 'Visa, Mastercard, Amex';

  @override
  String get paymentApplePaySub => 'Pay with Face ID / Touch ID';

  @override
  String get paymentGooglePaySub => 'Pay with Google account';

  @override
  String get paymentBankTransferSub => 'Direct bank transfer';

  @override
  String get ticketTitle => 'Your Ticket';

  @override
  String get ticketBoardingPass => 'BOARDING PASS';

  @override
  String get ticketPassenger => 'Passenger';

  @override
  String get ticketSeat => 'Seat';

  @override
  String get ticketGate => 'Gate';

  @override
  String get ticketDate => 'Date';

  @override
  String get ticketCabin => 'Cabin';

  @override
  String get ticketBoardingTime => 'Boarding';

  @override
  String get ticketDownload => 'Download Ticket';

  @override
  String get ticketShare => 'Share';

  @override
  String get ticketBackHome => 'Back to Home';

  @override
  String get ticketStatusConfirmed => 'CONFIRMED';

  @override
  String get ticketStatusCheckedIn => 'CHECKED IN';

  @override
  String get ticketStatusBoarded => 'BOARDED';

  @override
  String get bookingsTitle => 'My Bookings';

  @override
  String bookingsUpcoming(int count) {
    return 'Upcoming ($count)';
  }

  @override
  String bookingsPast(int count) {
    return 'Past ($count)';
  }

  @override
  String get bookingsNoUpcoming => 'No upcoming trips';

  @override
  String get bookingsNoPast => 'No past trips';

  @override
  String get bookingsStatusUpcoming => 'Upcoming';

  @override
  String get bookingsStatusCompleted => 'Completed';

  @override
  String get bookingsStatusCancelled => 'Cancelled';

  @override
  String get bookingsRef => 'Ref';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileMyBookings => 'My Bookings';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profilePaymentMethods => 'Payment Methods';

  @override
  String get profileHelp => 'Help & Support';

  @override
  String get profileAbout => 'About FlyFlex';

  @override
  String get profileSignOut => 'Sign Out';

  @override
  String get profileSignOutTitle => 'Sign Out';

  @override
  String get profileSignOutConfirm => 'Are you sure you want to sign out?';

  @override
  String get profileTotalBookings => 'Bookings';

  @override
  String get profileTotalFlights => 'Flights';

  @override
  String get profileMemberSince => 'Member Since';

  @override
  String get profileTierBronze => 'Bronze';

  @override
  String get profileTierSilver => 'Silver';

  @override
  String get profileTierGold => 'Gold';

  @override
  String get profileTierPlatinum => 'Platinum';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsEmpty => 'No notifications yet';

  @override
  String get notificationsMarkAll => 'Mark all read';

  @override
  String get cabinEconomy => 'Economy';

  @override
  String get cabinBusiness => 'Business';

  @override
  String get cabinFirst => 'First Class';

  @override
  String get citiesDomestic => 'Domestic';

  @override
  String get citiesInternational => 'International';

  @override
  String get citiesFailedToLoad => 'Failed to load cities';

  @override
  String get flightsDomesticRegion => 'Saudi Arabia';

  @override
  String get flightsInternationalRegion => 'Worldwide';

  @override
  String get flightsOnePassenger => '1 Passenger';

  @override
  String get flightsNoResultsHint =>
      'Try adjusting your filters or\nsearch for a different route.';

  @override
  String flightsStop(int count) {
    return '$count Stop';
  }

  @override
  String flightsSeatsLeftFull(int count) {
    return '$count seats left';
  }

  @override
  String homeYouSave(String amount) {
    return 'You save SAR $amount';
  }

  @override
  String homeDealsCount(int count) {
    return '$count deals';
  }

  @override
  String get flightDetailsAmenities => 'Amenities';

  @override
  String get flightDetailsSellingFast => 'Selling Fast!';

  @override
  String flightDetailsOnlySeatsLeft(int count) {
    return 'Only $count seat(s) left';
  }

  @override
  String get flightDetailsLoading => 'Loading flight details…';

  @override
  String get flightDetailsFailedToLoad => 'Failed to load details';

  @override
  String get flightDetailsTotalPrice => 'Total Price';

  @override
  String get flightDetailsInclTaxes => 'incl. taxes & fees';

  @override
  String flightDetailsSavePercent(int percent) {
    return 'Save $percent%';
  }

  @override
  String get flightDetailsTaxesPercent => 'Taxes & Fees (15%)';

  @override
  String get seatSelectASeat => 'Select a Seat';

  @override
  String get seatTotal => 'total';

  @override
  String get paymentSecureTitle => 'Secure Payment';

  @override
  String get paymentTotalAmount => 'Total Amount';

  @override
  String get paymentPayNow => 'Pay Now';

  @override
  String get paymentDoNotClose => 'Please do not close this screen';

  @override
  String get paymentCardNumber => 'Card Number';

  @override
  String get paymentCardNumberHint => '0000 0000 0000 0000';

  @override
  String get paymentExpiry => 'Expiry';

  @override
  String get paymentExpiryHint => 'MM/YY';

  @override
  String get paymentCvv => 'CVV';

  @override
  String get paymentCvvHint => '•••';

  @override
  String get paymentCardHolder => 'CARD HOLDER';

  @override
  String get paymentExpires => 'EXPIRES';

  @override
  String get paymentChoosePayment => 'Choose Payment';

  @override
  String get paymentAirline => 'Airline';

  @override
  String get paymentFlyFlexFee => 'FlyFlex Fee';

  @override
  String paymentYouSaveFlyFlex(String amount) {
    return 'You save SAR $amount with FlyFlex!';
  }

  @override
  String get ticketBookingConfirmed => 'Booking Confirmed!';

  @override
  String get ticketBoardingPassReady => 'Your boarding pass is ready';

  @override
  String get ticketSavedToDevice => 'Ticket saved to device';

  @override
  String get ticketShareLinkCopied => 'Share link copied';

  @override
  String get ticketViewMyBookings => 'View My Bookings';

  @override
  String get ticketDuration => 'Duration';

  @override
  String get ticketClass => 'Class';

  @override
  String get bookingsNoBookingsYet => 'No bookings yet';

  @override
  String get bookingsEmptySubtitle =>
      'Discover premium unsold seats\nat unbeatable prices';

  @override
  String get bookingsFindFlights => 'Find Flights';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profileLanguageSubtitle => 'Arabic, English';

  @override
  String get profileLanguageArabic => 'Arabic';

  @override
  String get profileLanguageEnglish => 'English';

  @override
  String get profilePersonalInfoSubtitle => 'Name, email, phone';

  @override
  String get profileTravelDocSubtitle => 'Passport, ID';

  @override
  String get profilePaymentMethodsSubtitle => 'Cards, digital wallets';

  @override
  String get profileNotificationsSubtitle => 'Alerts & preferences';

  @override
  String get profileHelpSubtitle => '24/7 assistance';

  @override
  String profileMember(String tier) {
    return '$tier Member';
  }

  @override
  String profilePoints(int points) {
    return '$points pts';
  }

  @override
  String get dateSelectPlaceholder => 'Select date';

  @override
  String get notificationsEmptySubtitle =>
      'We\'ll notify you about price drops\nand booking updates.';

  @override
  String get amenitySnacks => 'Snacks';

  @override
  String get amenityUsbCharging => 'USB Charging';

  @override
  String get amenityFullMeal => 'Full Meal';

  @override
  String get amenityWifi => 'WiFi';

  @override
  String get amenityFlatBed => 'Flat Bed';

  @override
  String get amenityLoungeAccess => 'Lounge Access';

  @override
  String get amenityAmenityKit => 'Amenity Kit';

  @override
  String get amenityPrivateSuite => 'Private Suite';

  @override
  String get amenityBar => 'Bar';

  @override
  String get amenityPriorityBoarding => 'Priority Boarding';

  @override
  String get amenityShowerSpa => 'Shower Spa';

  @override
  String get amenityExtraLegroom => 'Extra Legroom';

  @override
  String get amenityEntertainment => 'Entertainment';

  @override
  String get amenityChauffeur => 'Chauffeur Service';
}
