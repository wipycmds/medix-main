import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import '../Data/Core/api_client.dart';

final locator = GetIt.I;

Future<void> setUpLocator() async {
  locator.registerSingleton<Client>(Client());
  locator.registerLazySingleton<ApiClient>(() => ApiClient(locator()));
}
