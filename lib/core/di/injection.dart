import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization/locale_cubit.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/logic/cubit/auth_cubit.dart';
import '../../features/onboarding/data/datasources/onboarding_local_datasource.dart';
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../features/onboarding/data/repositories/onboarding_repository.dart';
import '../../features/onboarding/logic/cubit/onboarding_cubit.dart';
import '../../features/home/data/datasources/home_local_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/data/repositories/home_repository.dart';
import '../../features/home/logic/cubit/home_cubit.dart';
import '../../features/cities/data/datasources/cities_local_datasource.dart';
import '../../features/cities/data/repositories/cities_repository_impl.dart';
import '../../features/cities/data/repositories/cities_repository.dart';
import '../../features/cities/logic/cubit/cities_cubit.dart';
import '../../features/flights/data/datasources/flights_local_datasource.dart';
import '../../features/flights/data/repositories/flights_repository_impl.dart';
import '../../features/flights/data/repositories/flights_repository.dart';
import '../../features/flights/logic/cubit/flights_cubit.dart';
import '../../features/flight_details/data/datasources/flight_details_local_datasource.dart';
import '../../features/flight_details/data/repositories/flight_details_repository.dart';
import '../../features/flight_details/data/repositories/flight_details_repository_impl.dart';
import '../../features/flight_details/logic/cubit/flight_details_cubit.dart';
import '../../features/passengers/data/datasources/passengers_local_datasource.dart';
import '../../features/passengers/data/repositories/passengers_repository_impl.dart';
import '../../features/passengers/data/repositories/passengers_repository.dart';
import '../../features/passengers/logic/cubit/passengers_cubit.dart';
import '../../features/seat_selection/data/datasources/seat_local_datasource.dart';
import '../../features/seat_selection/data/repositories/seat_repository_impl.dart';
import '../../features/seat_selection/data/repositories/seat_repository.dart';
import '../../features/seat_selection/logic/cubit/seat_cubit.dart';
import '../../features/payment/data/datasources/payment_local_datasource.dart';
import '../../features/payment/data/repositories/payment_repository_impl.dart';
import '../../features/payment/data/repositories/payment_repository.dart';
import '../../features/payment/logic/cubit/payment_cubit.dart';
import '../../features/bookings/data/datasources/bookings_local_datasource.dart';
import '../../features/bookings/data/repositories/bookings_repository_impl.dart';
import '../../features/bookings/data/repositories/bookings_repository.dart';
import '../../features/bookings/logic/cubit/bookings_cubit.dart';
import '../../features/tickets/data/datasources/tickets_local_datasource.dart';
import '../../features/tickets/data/repositories/tickets_repository_impl.dart';
import '../../features/tickets/data/repositories/tickets_repository.dart';
import '../../features/tickets/logic/cubit/tickets_cubit.dart';
import '../../features/profile/data/datasources/profile_local_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/data/repositories/profile_repository.dart';
import '../../features/profile/logic/cubit/profile_cubit.dart';
import '../../features/notifications/data/datasources/notifications_local_datasource.dart';
import '../../features/notifications/data/repositories/notifications_repository_impl.dart';
import '../../features/notifications/data/repositories/notifications_repository.dart';
import '../../features/notifications/logic/cubit/notifications_cubit.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  _registerLocale();
  _registerAuth();
  _registerOnboarding();
  _registerHome();
  _registerCities();
  _registerFlights();
  _registerFlightDetails();
  _registerPassengers();
  _registerSeatSelection();
  _registerPayment();
  _registerBookings();
  _registerTickets();
  _registerProfile();
  _registerNotifications();
}

// LocaleCubit is a singleton — it lives for the entire app lifetime.
void _registerLocale() {
  sl.registerLazySingleton<LocaleCubit>(
    () => LocaleCubit(sl<SharedPreferences>()),
  );
}

void _registerAuth() {
  sl
    ..registerLazySingleton<AuthLocalDatasource>(AuthLocalDatasource.new)
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl()),
    )
    ..registerFactory<AuthCubit>(() => AuthCubit(sl()));
}

void _registerOnboarding() {
  sl
    ..registerLazySingleton<OnboardingLocalDatasource>(
        OnboardingLocalDatasource.new)
    ..registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(sl()),
    )
    ..registerFactory<OnboardingCubit>(() => OnboardingCubit(sl()));
}

void _registerHome() {
  sl
    ..registerLazySingleton<HomeLocalDatasource>(HomeLocalDatasource.new)
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl()),
    )
    ..registerFactory<HomeCubit>(() => HomeCubit(sl()));
}

void _registerCities() {
  sl
    ..registerLazySingleton<CitiesLocalDatasource>(CitiesLocalDatasource.new)
    ..registerLazySingleton<CitiesRepository>(
      () => CitiesRepositoryImpl(sl()),
    )
    ..registerFactory<CitiesCubit>(() => CitiesCubit(sl()));
}

void _registerFlights() {
  sl
    ..registerLazySingleton<FlightsLocalDatasource>(FlightsLocalDatasource.new)
    ..registerLazySingleton<FlightsRepository>(
      () => FlightsRepositoryImpl(sl()),
    )
    ..registerFactory<FlightsCubit>(() => FlightsCubit(sl()));
}

void _registerFlightDetails() {
  sl
    ..registerLazySingleton<FlightDetailsLocalDatasource>(
        FlightDetailsLocalDatasource.new)
    ..registerLazySingleton<FlightDetailsRepository>(
      () => FlightDetailsRepositoryImpl(sl()),
    )
    ..registerFactory<FlightDetailsCubit>(() => FlightDetailsCubit(sl()));
}

void _registerPassengers() {
  sl
    ..registerLazySingleton<PassengersLocalDatasource>(
        () => PassengersLocalDatasource(sl<SharedPreferences>()))
    ..registerLazySingleton<PassengersRepository>(
      () => PassengersRepositoryImpl(sl()),
    )
    ..registerFactory<PassengersCubit>(() => PassengersCubit(sl()));
}

void _registerSeatSelection() {
  sl
    ..registerLazySingleton<SeatLocalDatasource>(SeatLocalDatasource.new)
    ..registerLazySingleton<SeatRepository>(
      () => SeatRepositoryImpl(sl()),
    )
    ..registerFactory<SeatCubit>(() => SeatCubit(sl()));
}

void _registerPayment() {
  sl
    ..registerLazySingleton<PaymentLocalDatasource>(PaymentLocalDatasource.new)
    ..registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(sl()),
    )
    ..registerFactory<PaymentCubit>(() => PaymentCubit(sl()));
}

void _registerBookings() {
  sl
    ..registerLazySingleton<BookingsLocalDatasource>(
        BookingsLocalDatasource.new)
    ..registerLazySingleton<BookingsRepository>(
      () => BookingsRepositoryImpl(sl()),
    )
    ..registerFactory<BookingsCubit>(() => BookingsCubit(sl()));
}

void _registerTickets() {
  sl
    ..registerLazySingleton<TicketsLocalDatasource>(
        TicketsLocalDatasource.new)
    ..registerLazySingleton<TicketsRepository>(
      () => TicketsRepositoryImpl(sl()),
    )
    ..registerFactory<TicketsCubit>(() => TicketsCubit(sl()));
}

void _registerProfile() {
  sl
    ..registerLazySingleton<ProfileLocalDatasource>(ProfileLocalDatasource.new)
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()),
    )
    ..registerFactory<ProfileCubit>(() => ProfileCubit(sl()));
}

void _registerNotifications() {
  sl
    ..registerLazySingleton<NotificationsLocalDatasource>(
        NotificationsLocalDatasource.new)
    ..registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepositoryImpl(sl()),
    )
    ..registerFactory<NotificationsCubit>(() => NotificationsCubit(sl()));
}
